package com.wh.core;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolEncoder;
import org.apache.mina.filter.codec.ProtocolEncoderOutput;



public class MyEncoder implements ProtocolEncoder {

   /* @Override
    public void encode(IoSession arg0, Object arg1, ProtocolEncoderOutput out) throws Exception {
       
        System.out.println("lai");
        BaseProTal b = (BaseProTal)arg1;
        IoBuffer io = IoBuffer.allocate(100).setAutoExpand(true);
        io.put(b.key);
        io.put(b.flag);
        io.putInt(b.msgLen);
        io.flip();
        out.write(io);
        out.flush();
    }*/

    @Override
    public void dispose(IoSession arg0) throws Exception {
        // TODO Auto-generated method stub
        
    }

/*    @Override
    public void dispose(IoSession arg0) throws Exception {
        // TODO Auto-generated method stub
        
    }*/

    @Override
    public void encode(IoSession arg0, Object arg1, ProtocolEncoderOutput out) throws Exception {
 
        IoBuffer io = (IoBuffer)arg1;
        out.write(io);
        out.flush();
/*        BaseProTal ba = (BaseProTal)arg1;
        System.out.println("±àÂëÆ÷µ÷ÓÃ");
       IoBuffer io = IoBuffer.allocate(100).setAutoExpand(true);
       
       io.put(ba.key);
       io.put(ba.flag);
       io.putInt(ba.msgLen);
       io.flip();
       out.write(io);
       out.flush();*/
         
   /*     byte[] b = ba.array();
        for (int i = 0; i < b.length; i++) {
           System.out.print(b[i]+" "); 
        }
        
        out.write("nihao".getBytes());
        out.flush();*/
        
    }

   
  

}
