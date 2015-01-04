package com.wh.core;

import org.apache.mina.core.buffer.IoBuffer;

public class HeadManager {
    private BaseProTal ba;
    public CallBak callback;

    public void addCallBack(CallBak call) {
        this.callback = call;
    }

    public byte key;
    public byte flag;
    public byte serverIndex;
    public byte chIndex;
    public int msgLen;

    public void unPackge(IoBuffer by) {

        if (by.limit() >= 8) {
            ba = new BaseProTal();
            ba.key = by.get();
            ba.flag = by.get();
            ba.serverIndex = by.get();
            ba.chIndex = by.get();
            ba.msgLen = by.getInt();
            System.out.println(ba.msgLen);
            this.nofify(by, ba.key, ba);
        }

    }

    public void nofify(IoBuffer buffer, byte cmd, BaseProTal header) {

        callback.readPkgBoddy(buffer, cmd, header);

    }

    public interface CallBak {
        public void readPkgBoddy(IoBuffer b, int cmd, BaseProTal header);

    }
}
