package com.wh.core;

import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolCodecFactory;
import org.apache.mina.filter.codec.ProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolEncoder;


public class MycoderFactory implements ProtocolCodecFactory {
  
    private  MyEncoder myencoder = null;  
    private  MyDecoder mydecoder = null; 
    public MycoderFactory(){
        System.out.println("myfactory");
        myencoder = new MyEncoder();
        mydecoder = new MyDecoder();
    }

    @Override
    public ProtocolDecoder getDecoder(IoSession arg0) throws Exception {
        // TODO Auto-generated method stub
        return mydecoder;
    }

    @Override
    public ProtocolEncoder getEncoder(IoSession arg0) throws Exception {
        // TODO Auto-generated method stub
        return myencoder;
    }

}
