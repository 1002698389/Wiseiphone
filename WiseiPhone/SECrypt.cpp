#include "stdafx.h"
#include "SECrypt.h"
extern "C"
{
#include "rsa/rsa.h"
}
#include "../SETracker/SETracker.h"
#include "zlib/zlib.h"

SERC4::SERC4(VA_LOGON* pLogon)
{

	prepare_key((unsigned char*) (pLogon->sessionkey), pLogon->sessionkeylen, &m_rc4key);

}
SERC4::SERC4(const char* sessionKey, int sessionKeyLen)
{
	prepare_key((unsigned char*) (sessionKey), sessionKeyLen, &m_rc4key);
}
SERC4::~SERC4()
{

}
bool SERC4::encrypt(VA_MSG* pMsg)
{
	if( !(pMsg->header.key & msgflag_encrypted))
	{
		m_rc4keyTemp=m_rc4key;
		rc4( ((unsigned char*)(pMsg)+sizeof(VA_HEADER)), pMsg->header.msgLen- sizeof(VA_HEADER), &m_rc4keyTemp);
		pMsg->header.flag |=msgflag_encrypted;
	}
	return true;
}
bool SERC4::decrypt(VA_MSG* pMsg)
{
	if(pMsg->header.flag & msgflag_encrypted)
	{
		m_rc4keyTemp=m_rc4key;
		rc4( ((unsigned char*)(pMsg)+sizeof(VA_HEADER)), pMsg->header.msgLen- sizeof(VA_HEADER), &m_rc4keyTemp);
		pMsg->header.flag &=~msgflag_encrypted;
	}
	return true;
}

static SECrypt theCrypt;
SECrypt* g_getCrypt()
{
	return & theCrypt;
}

SECrypt::SECrypt(void)
{
	m_bInited=false;

}

SECrypt::~SECrypt(void)
{
}

void    SECrypt::closecrypt()
{
	m_bInited=false;

}

bool    SECrypt::test()
{
	//use private key encrypt

	//then decrypt
	


	VA_LOGON logonMsg={0};
	strcpy(logonMsg.sessionkey,"testsessionkey");
	strcpy(logonMsg.logonUsrName, "testuser");
	strcpy(logonMsg.logonUsrPassSHA1,"testsha1");

	logonMsg.sessionkeylen=strlen(logonMsg.sessionkey);
	logonMsg.usrnamelen=strlen(logonMsg.logonUsrName);
	logonMsg.usrpasslen=strlen(logonMsg.logonUsrPassSHA1);

	VA_LOGON compare;
	memcpy(&compare, &logonMsg, sizeof(logonMsg));

	VA_PUBKEY tempPubKey;
	fillPubkey(&tempPubKey);
	if(!rsa_encrypt_use_pubkey(&tempPubKey, &logonMsg))
		return false;


	if(!rsa_decrypt_use_privatekey(&logonMsg))
		return false;

	if(strcmp(logonMsg.sessionkey, compare.sessionkey)
		|| strcmp(logonMsg.logonUsrName, compare.logonUsrName)
		|| strcmp(logonMsg.logonUsrPassSHA1, compare.logonUsrPassSHA1))
		return false;
	return true;

}

bool    SECrypt::initCrypt(int keylen, CAtom* pAtom)
{
	while(pAtom !=NULL)
	{
		CAtomDicti* pDict=dynamic_cast<CAtomDicti*>(pAtom);
		if(!pDict)
			break;

		int storeKeyLen=pDict->getIntValue("klen", keylen);
		if(storeKeyLen !=keylen)
			break;

		std::string strPKey=pDict->getStringValue("prvkey");
		if(strPKey.empty())
			break;
		//base 64
		unsigned int buffLen=CBase64::CalculateRecquiredDecodeOutputBufferSize((char*)strPKey.c_str(), strPKey.length());
		char* pTempBuff=new char[buffLen];
		unsigned int decodeLen=CBase64::DecodeBuffer((char*)strPKey.c_str(), pTempBuff);
		if(decodeLen != sizeof(m_privkey))
		{
			delete [] pTempBuff;
			break;
		}
		memcpy(&m_privkey, pTempBuff, decodeLen);
		delete [] pTempBuff;

		//
		std::string strPubKey=pDict->getStringValue("pubkey");
		if(strPubKey.empty())
			break;

		buffLen=CBase64::CalculateRecquiredDecodeOutputBufferSize((char*)strPubKey.c_str(), strPubKey.length());
		pTempBuff=new char[buffLen];
		decodeLen=CBase64::DecodeBuffer((char*)strPubKey.c_str(), pTempBuff);
		if(decodeLen != sizeof(m_pubkey))
		{
			delete [] pTempBuff;
			break;
		}
		memcpy(&m_pubkey, pTempBuff, decodeLen);
		delete [] pTempBuff;

		//test
		if(!test())
			break;

		m_bInited=true;
		return true;
	}

	{
		//create 
		R_RANDOM_STRUCT m_randstruct;
		R_RandomInit (&m_randstruct);
		unsigned int bytesNeeded;
		unsigned char seedByte=0;
		srand(time(NULL));
		while (1) {
			R_GetRandomBytesNeeded (&bytesNeeded, &m_randstruct);
			if (bytesNeeded == 0)
				break;

			seedByte= (unsigned char) rand();

			R_RandomUpdate (&m_randstruct, &seedByte, 1);
		}


		R_RSA_PROTO_KEY protoKey;

		protoKey.bits = (unsigned int)keylen;
		protoKey.useFermat4 = 1;


		//modulusLen = (1024) / 8;
		//if (inputLen > 128-11) 117
		//	return (RE_LEN);
		//output len 128

		//max session key len 128-11...
		int status;

		memset(&m_pubkey,0, sizeof(m_pubkey));
		memset(&m_privkey, 0, sizeof(m_privkey));
		if (status = R_GeneratePEMKeys
			(&m_pubkey, &m_privkey, &protoKey, &m_randstruct))
		{
			//	LOG("Generate RSA Key Fail %d\n", status);
			return false;
		}

		R_RandomFinal(&m_randstruct);

		m_bInited=test();
		return m_bInited;
	}
}

bool    SECrypt::rsa_encrypt_use_pubkey(VA_PUBKEY* rsaPubkey, VA_LOGON* pkey)
{
	R_RANDOM_STRUCT random={0};
	//	R_RandomInit(&random);
	R_RSA_PUBLIC_KEY pubkey={0};
	memcpy(pubkey.exponent, rsaPubkey->exponent, sizeof(pubkey.exponent));
	memcpy(pubkey.modulus, rsaPubkey->modulo, sizeof(pubkey.modulus));
	pubkey.bits=rsaPubkey->bits;

	unsigned char outputbuff[E_MODULE_LEN]={0};
	unsigned int  outputlen=sizeof(outputbuff);
	int rs=RSAPublicEncrypt(outputbuff, &outputlen, (unsigned char*)pkey->sessionkey, pkey->sessionkeylen,
		&pubkey, &random);
	ASSERT(outputlen == E_MODULE_LEN);
	if(rs ==0)
	{
		memcpy(pkey->sessionkey, outputbuff, outputlen );
	//	pkey->sessionkeylen=outputlen;
	}
	else
	{
		return false;
	}
	memset(&random,0, sizeof(random));
	rs=RSAPublicEncrypt(outputbuff, &outputlen, (unsigned char*)pkey->logonUsrName, pkey->usrnamelen,
		&pubkey, &random);

	ASSERT(outputlen == E_MODULE_LEN);
	if(rs ==0)
	{
		memcpy(pkey->logonUsrName, outputbuff, outputlen );
	}
	else
	{
		return false;
	}

	memset(&random,0, sizeof(random));
	rs=RSAPublicEncrypt(outputbuff, &outputlen, (unsigned char*)pkey->logonUsrPassSHA1, pkey->usrpasslen,
		&pubkey, &random);

	ASSERT(outputlen == E_MODULE_LEN);
	if(rs ==0)
	{
		memcpy(pkey->logonUsrPassSHA1, outputbuff, outputlen );
	}
	else
	{
		return false;
	}

	//encrypt other block
	return true;
}

bool    SECrypt::rsa_decrypt_use_privatekey(VA_LOGON* pkey)
{
//	if(!m_bInited)
//		return false;

	if(pkey->sessionkeylen > E_MAX_RSA_STR_LEN*2
		|| pkey->usrnamelen > E_MAX_RSA_STR_LEN*2
		|| pkey->usrpasslen >E_MAX_RSA_STR_LEN*2)
		return false;
	unsigned char outputbuff[E_MODULE_LEN]={0};
	unsigned int  outputlen=E_MODULE_LEN;
	int rs=
		RSAPrivateDecrypt(outputbuff, &outputlen, (unsigned char*)pkey->sessionkey,E_MODULE_LEN, &m_privkey);

	ASSERT(outputlen == pkey->sessionkeylen);
	if(rs ==0 && outputlen== pkey->sessionkeylen)
	{
		memset(pkey->sessionkey,0, sizeof(pkey->sessionkey) );
		memcpy(pkey->sessionkey, outputbuff, outputlen);
	}
	else
	{
		return false;
	}

	outputlen=E_MODULE_LEN;
	rs=
		RSAPrivateDecrypt(outputbuff, &outputlen, (unsigned char*)pkey->logonUsrName,E_MODULE_LEN, &m_privkey);
	
	ASSERT(outputlen == pkey->usrnamelen);
	if(rs ==0 && outputlen== pkey->usrnamelen)
	{
		memset(pkey->logonUsrName,0, sizeof(pkey->logonUsrName) );
		memcpy(pkey->logonUsrName, outputbuff, outputlen);
	}
	else
	{
		return false;
	}


	outputlen=E_MODULE_LEN;
	rs=
		RSAPrivateDecrypt(outputbuff, &outputlen, (unsigned char*)pkey->logonUsrPassSHA1,E_MODULE_LEN, &m_privkey);

	ASSERT(outputlen == pkey->usrpasslen);
	if(rs ==0 && outputlen== pkey->usrpasslen)
	{
		memset(pkey->logonUsrPassSHA1,0, sizeof(pkey->logonUsrPassSHA1) );
		memcpy(pkey->logonUsrPassSHA1, outputbuff, outputlen);
	}
	else
	{
		return false;
	}

	return true;
}


SERC4*  SECrypt::getRC4(VA_LOGON* pmsg)
{
	return new SERC4(pmsg);
}
char* SECrypt::encodeAtom(CAtom* pItem, int& len, bool& bCompressed)
{
	std::string str=Encode(pItem);
	while(bCompressed && str.length() > E_DEFAULT_DATALEN)
	{
		unsigned long destlen=str.length()+ str.length()/100+ 12;
		ASSERT(destlen < sizeof(m_tempBuff));
		int res=compress((BYTE*) m_tempBuff, &destlen, 
			(const BYTE*) (str.c_str()), str.length());
		if(res !=Z_OK)
			break;
		
		if(destlen > str.length())
			break;

		len=destlen;
		bCompressed=true;
		return m_tempBuff;	
	}
	bCompressed=false;
	if(str.length() > E_MAX_DATALEN-2*sizeof(VA_HEADER))
	{
		ASSERT(FALSE);
		return NULL;
	}
	memcpy(m_tempBuff,  str.c_str(), str.length());
	len=str.length();
	return m_tempBuff;	
}
bool SECrypt::encodeAtom(CAtom* pItem, char* pBuff, int& pBuffLen, bool& bCompressed)
{
	std::string str=Encode(pItem);
	while(bCompressed && str.length() > E_DEFAULT_DATALEN)
	{
		unsigned long destlen=str.length()+ str.length()/100+ 12;
		ASSERT(destlen < pBuffLen);
		int res=compress((BYTE*) pBuff, &destlen, 
			(const BYTE*) (str.c_str()), str.length());
		if(res !=Z_OK)
			break;
		if(destlen > str.length())
			break;

		pBuffLen=destlen;
		bCompressed=true;
		return true;	
	}
	bCompressed=false;
	if(str.length() > E_MAX_DATALEN-2*sizeof(VA_HEADER))
	{
		ASSERT(FALSE);
		return false;
	}
	memcpy(pBuff,  str.c_str(), str.length());
	pBuffLen=str.length();
	return true;	
}
//VA_STATUS* SECrypt::encodeStatusMsg(CAtom* pItem, char* pBuff, int pBuffLen, bool bCompressIftooLart)
//{
//	ASSERT(pItem);
//	std::string str=Encode(pItem);
//	VA_STATUS* pStatus=(VA_STATUS*) (pBuff);
//	pStatus->header.flag=0;
//	while(bCompressIftooLart && str.length() > E_DEFAULT_DATALEN)
//	{
//		unsigned long destlen=str.length()+ str.length()/100+ 12;
//		ASSERT(destlen < pBuffLen);
//		int res=compress((BYTE*) (pStatus->data), &destlen, 
//			(const BYTE*) (str.c_str()), str.length());
//		if(res !=Z_OK)
//			break;
//		if(destlen > str.length())
//			break;
//		pStatus->header.msgLen=destlen+sizeof(VA_HEADER);
//		pStatus->header.flag |=msgflag_zlibed;
//		return pStatus;	
//	}
//	
//	//just 
//	if(str.length() > E_MAX_DATALEN)
//	{
//		ASSERT(FALSE);
//		return NULL;
//	}
//	pStatus->header.msgLen=sizeof(VA_HEADER)+str.length();
//	memcpy(pStatus->data,  str.c_str(), str.length());
//	return pStatus;	
//}
CAtom*     SECrypt::decodeAtom(const char* pStr, int strLen, bool bCompressed)
{
	char* pTempBuff=m_tempBuff;
	int pTempBuffLen=sizeof(m_tempBuff);

	if(bCompressed)
	{
		unsigned long destLen=pTempBuffLen;
		int nResult=uncompress((BYTE*) pTempBuff, &destLen, 
			(const BYTE*) pStr, strLen);

		if(nResult !=Z_OK)
		{
			ASSERT(FALSE);
			return NULL;
		}
		pStr=pTempBuff;
		strLen=destLen;
	}
	std::string strTemp((const char*) pStr, strLen);
	return Decode(strTemp);
}
CAtom*     SECrypt::decodeAtom(const char* pStr, int strLen, bool bCompressed, char* pTempBuff, int pTempBuffLen)
{
	if(bCompressed)
	{
		unsigned long destLen=pTempBuffLen;
		int nResult=uncompress((BYTE*) pTempBuff, &destLen, 
			(const BYTE*) pStr, strLen);

		if(nResult !=Z_OK)
		{
			ASSERT(FALSE);
			return NULL;
		}
		pStr=pTempBuff;
		strLen=destLen;
	}
	std::string strTemp((const char*) pStr, strLen);
	return Decode(strTemp);
}
//CAtom*     SECrypt::decodeStatusMsg(VA_STATUS* pStatus, char* pBuff, int pBuffLen)
//{
//	char* pStr=pStatus->data;
//	int   strLen=pStatus->header.msgLen -sizeof(VA_HEADER);
//	if(pStatus->header.flag & msgflag_zlibed)
//	{
//		//decompress.
//		unsigned long destLen=pBuffLen;
//		int nResult=uncompress((BYTE*) pBuff, &destLen, 
//			(const BYTE*) pStatus->data, strLen);
//
//		if(nResult !=Z_OK)
//		{
//			ASSERT(FALSE);
//			return NULL;
//		}
//		pStr=pBuff;
//		strLen=destLen;
//	}
//
//	std::string strTemp((const char*) pStr, strLen);
//	return Decode(strTemp);
//}
CAtom*  SECrypt::toAtom()
{
	//
	if(!m_bInited)
		return NULL;

	CAtomDicti* pDict=new CAtomDicti;
	pDict->setItem("klen", (int) m_pubkey.bits);

	int buffLen=CBase64::CalculateRecquiredEncodeOutputBufferSize(sizeof(m_privkey));

	char* tempBuff=new char[buffLen];
	CBase64::EncodeBuffer((char*) &m_privkey, sizeof(m_privkey), tempBuff);

	pDict->setItem("prvkey", (const char*) tempBuff);

	delete [] tempBuff;
	buffLen=CBase64::CalculateRecquiredEncodeOutputBufferSize(sizeof(m_pubkey));
	tempBuff=new char[buffLen];
	CBase64::EncodeBuffer((char*) &m_pubkey, sizeof(m_pubkey), tempBuff);

	pDict->setItem("pubkey", (const char*) tempBuff);
	delete [] tempBuff;
	return pDict;

}

void    SECrypt::fillPubkey(VA_PUBKEY* pkey)
{
	memset(pkey, 0, sizeof(VA_PUBKEY));
	pkey->header.key=key_va_pubkey;
	pkey->header.flag=0;
	pkey->header.msgLen=sizeof(VA_PUBKEY);
	
	sprintf(pkey->protol,"rsa");
	pkey->bits=m_pubkey.bits;
	memcpy(pkey->modulo, m_pubkey.modulus, sizeof(m_pubkey.modulus));
	memcpy(pkey->exponent, m_pubkey.exponent, sizeof(m_pubkey.exponent));
}
