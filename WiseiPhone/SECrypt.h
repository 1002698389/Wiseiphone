#pragma once

#include "NetProtocal.h"
#include "global.h"
#include "rsaref.h"
#include "../ssdsdk/src/CBase64.h"
#include "../ssdsdk/src/softwarecopy.h"
#include "../ssdsdk/src/software.h"
#include "../ssdsdk/src/sha1.h"
class SERC4
{
public:
	SERC4(VA_LOGON* pLogon);
	SERC4(const char* sessionKey, int sessionKeyLen);
	virtual ~SERC4();
	bool encrypt(VA_MSG* pMsg);
	bool decrypt(VA_MSG* pMsg);
protected:
	rc4_key m_rc4key;
	rc4_key m_rc4keyTemp;
};
class CAtom;
class SECrypt
{
public:
	SECrypt(void);
	~SECrypt(void);
public:
	void    closecrypt(); 
	bool    test();
	bool    initCrypt(int keylen=1024, CAtom* pAtom=NULL);
	
	bool    rsa_encrypt_use_pubkey(VA_PUBKEY* pubKey, VA_LOGON* pmsg);
	bool    rsa_decrypt_use_privatekey(VA_LOGON* pmsg);

	SERC4*  getRC4(VA_LOGON* pmsg);
	CAtom*  toAtom();
	void    fillPubkey(VA_PUBKEY* pPubKey);
	//VA_STATUS* encodeStatusMsg(CAtom* pItem, char* pBuff, int pBuffLen, bool bCompressIftooLart=true);
	bool encodeAtom(CAtom* pItem, char* pBuff, int& pBuffLen, bool& bCompressed);
	char* encodeAtom(CAtom* pItem, int& len, bool& bCompressed);
	//CAtom*     decodeStatusMsg(VA_STATUS* pStatus, char* pBuff, int pBuffLen);
	CAtom*     decodeAtom(const char* pData, int dataLen, bool bCompressed);
	CAtom*     decodeAtom(const char* pData, int dataLen, bool bCompressed, char* pTempBuff, int pTempBuffLen);
	/*
	PES_SESSIONKEY get_pub_crypted_sessionkey(PES_PUBKEY rsaPubkey, PES_SESSIONKEY orikey);
		bool rsa_decrypt(PES_SESSIONKEY pkey);
	bool rsa_encrypt(PES_PUBKEY rsaPubkey, PES_SESSIONKEY pkey);
	bool get_pubkey(PES_PUBKEY pkey);
	bool generatersa_key(int keylen=512);
	void set_sessionkey(const char* key,int sessionkeylen);
	PES_UNION encrypt(PES_UNION orimsg);
	PES_UNION decrypt(PES_UNION orimsg);
	int getSessionKeyLen(){ return m_sessionkeylen;	}
	const char* getSessionKey(){ return m_sessionkey;	}
	*/
private:
//	char m_sessionkey[E_MAX_SESSION_KEYLEN];
//	int  m_sessionkeylen;
//	R_RANDOM_STRUCT   m_randstruct;
	R_RSA_PUBLIC_KEY  m_pubkey;
	R_RSA_PRIVATE_KEY m_privkey;
	bool m_bInited;
//	bool sessioKeyFilled;
//	bool pubkeyFilled;
//	bool prikeyFilled;
	char m_tempBuff[64*1024];
};
extern SECrypt* g_getCrypt();