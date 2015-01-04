package com.wh.protocal;

public class BaseProTal {
    public BaseProTal(byte key,byte flag,byte severindex){
        this.key = key;
        this.flag =flag;
        this.serverIndex =severindex;
    }
    public byte  key;
    public byte  flag;
    public byte  serverIndex;
    public byte  chIndex;
    public int   msgLen;

}
