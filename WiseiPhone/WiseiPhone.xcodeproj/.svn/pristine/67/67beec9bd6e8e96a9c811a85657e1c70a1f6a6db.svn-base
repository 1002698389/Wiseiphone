package com.wh.core;

import java.nio.ByteOrder;
import java.nio.charset.Charset;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.CumulativeProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolDecoderOutput;
import org.apache.mina.filter.codec.ProtocolEncoder;
import org.apache.mina.filter.codec.ProtocolEncoderOutput;



public class MyDecoder  extends CumulativeProtocolDecoder  {


    @Override
    public void finishDecode(IoSession arg0, ProtocolDecoderOutput arg1) throws Exception {
        // TODO Auto-generated method stub
    }

    @Override
    protected boolean doDecode(IoSession arg0, IoBuffer io, ProtocolDecoderOutput arg2) throws Exception {
      
       /* if(io != null){
        arg2.write(io);
        return false;
        }*/
        int msglen =0;
        if(io.remaining()>=8){
            io.order(ByteOrder.LITTLE_ENDIAN);
            msglen  =io.getInt(4);
        }else{
            return false;
        }
        if(io.remaining() ==msglen){
            IoBuffer i = IoBuffer.allocate(io.capacity());
            i.order(ByteOrder.LITTLE_ENDIAN);
            i.put(io);
            arg2.write(i);
            return true;
        }
        return false;
    }


   
  

}
