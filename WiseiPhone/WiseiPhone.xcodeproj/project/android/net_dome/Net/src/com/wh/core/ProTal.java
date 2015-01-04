package com.wh.core;

import com.wh.core.ProTal.VaLoggons;

public class ProTal  {

  public static class VaLoggons extends BaseProTal{
      
      public VaLoggons(byte key,byte flag,byte severindex,int len) {
        super((byte)key, (byte)flag, (byte)severindex, len);
        // TODO Auto-generated constructor stub
     }
      public VaLoggons(){}
      public short sessionkeylen;
      public short usrnamelen;
      public short usrpasslen;
      public short pad;
      public byte[] logonUsrName;
      public byte[] logonUsrPassSHA1 ;
      public byte[] sessionkey  ;
  }
      
      
      
public static class VaResult extends BaseProTal{
      
      public VaResult(byte key,byte flag,byte severindex,int len) {
        super((byte)key, (byte)flag, (byte)severindex, len);
        // TODO Auto-generated constructor stub
     }
     
      int logonResult;
      int usrPermi;
      
  }
      
      
      
      
      
 



}
