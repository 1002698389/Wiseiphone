package com.wh.core;

public class BaseProTal {
    public BaseProTal(byte key, byte flag, byte severindex, int len) {
        this.key = key;
        this.flag = flag;
        this.serverIndex = severindex;
        this.msgLen = len;
    }

    public BaseProTal() {

    }

    public byte key;
    public byte flag;
    public byte serverIndex;
    public byte chIndex;
    public int msgLen;

}
