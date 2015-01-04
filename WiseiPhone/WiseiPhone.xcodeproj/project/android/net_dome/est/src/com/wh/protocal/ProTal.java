package com.wh.protocal;

public class ProTal  {

  public static class VaLoggons extends BaseProTal{
      
      public VaLoggons(int i, int j, int k) {
        super((byte)i, (byte)j, (byte)k);
        // TODO Auto-generated constructor stub
    }
    public short sessionkeylen;
      public short usrnamelen;
      public short usrpasslen;
      public short pad;
      public byte[] logonUsrName;
      public byte[] logonUsrPassSHA1;
      public byte[] sessionkey;
  }

}
