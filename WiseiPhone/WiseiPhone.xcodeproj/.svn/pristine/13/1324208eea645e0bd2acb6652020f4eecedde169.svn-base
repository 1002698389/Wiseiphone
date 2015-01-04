package com.wh.protocal;

import java.nio.ByteBuffer;

import com.wh.net.Const;
import com.wh.protocal.ProTal.VaLoggons;

public class VaLogon extends BaseData {

    public ProTal.VaLoggons va;

    /**
     * @param args
     */
    public static void main(String[] args) {
      VaLogon vaa = new VaLogon();
       ProTal.VaLoggons vl = new VaLoggons(2,2,2);
       vl.pad =0;
       vl.logonUsrName ="admin".getBytes();
       vl.logonUsrPassSHA1 = "".getBytes();
       vl.sessionkey = "se_key_1344452233_key".getBytes();
       vl.sessionkeylen = (short) vl.sessionkey.length;
       vl.usrnamelen = (short) vl.logonUsrName.length;
       vl.usrpasslen= (short) vl.logonUsrPassSHA1.length;

       vaa.setInfo(vl);
       
     ByteBuffer by =  vaa.newPackage();
     System.out.println(by.mark());
     System.out.println(by.get());
     System.out.println(by.get());
     System.out.println(by.get());
     System.out.println(by.get());
     System.out.println(by.getInt());
     System.out.println(by.mark());
    }
    
    
    
    
    /**
     * @param va
     */
    public void setInfo(ProTal.VaLoggons va){
        this.va = va;
        
    }
    
    @Override
     public byte getKey() {
        
        return va.key;
    }

    @Override
    public byte getFlag() {
        // TODO Auto-generated method stub
        return va.flag;
    }

    @Override
    public byte getServerIndex() {
        // TODO Auto-generated method stub
        return va.serverIndex;
    }

    @Override
    public byte getChIndex() {
        // TODO Auto-generated method stub
        return va.chIndex;
    }

   @Override
    public int getBodylen() {
        // TODO Auto-generated method stub
        return 8+BaseData.MaxLen.E_MODULE_LEN*3;
    }
    @Override
    ByteBuffer putBody() {
//        sessionkeylen  = (short) Const.Key.SessionKey.getBytes().length;
//        usrnamelen =5;
//        usrpasslen =2;
//        pad =2;
      //  va.sessionkeylen
//        logonUsrName = new byte[BaseData.MaxLen.E_MODULE_LEN];
//        System.arraycopy("admin".getBytes(), 0, logonUsrName, 0, "admin".getBytes().length);
//        
//        logonUsrPassSHA1 =new byte[BaseData.MaxLen.E_MODULE_LEN];
//        
//        sessionkey =new byte[BaseData.MaxLen.E_MODULE_LEN];
//        System.arraycopy(Const.Key.SessionKey.getBytes(), 0, sessionkey, 0, Const.Key.SessionKey.getBytes().length);
//        
        ByteBuffer by = ByteBuffer.allocate(getBodylen());
        by.putShort(va.sessionkeylen);
        by.putShort(va.usrnamelen);
        by.putShort(va.usrnamelen);
        by.putShort(va.pad);
        
        by.put(va.logonUsrName);
        by.put(va.logonUsrPassSHA1);
        by.put(va.sessionkey);
        by.flip();
        return by;
    }


   public ProTal.VaLoggons getInfoByBuffer(ByteBuffer by){
       
       ProTal.VaLoggons vl = new VaLoggons(2,2,2);
       vl.pad =0;
       vl.logonUsrName ="admin".getBytes();
       vl.logonUsrPassSHA1 = "".getBytes();
       vl.sessionkey = "se_key_1344452233_key".getBytes();
       vl.sessionkeylen = (short) vl.sessionkey.length;
       vl.usrnamelen = (short) vl.logonUsrName.length;
       vl.usrpasslen= (short) vl.logonUsrPassSHA1.length;

       
       
       
       
       
    return va;
       
       
       
       
   }


    @Override
    void readBody(Byte[] buffer) {
        // TODO Auto-generated method stub
        
    }

}
