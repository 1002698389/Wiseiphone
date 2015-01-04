package com.wh.net;

import java.nio.ByteBuffer;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;





public class MyHandler extends IoHandlerAdapter{

   
  @Override
public void messageReceived(IoSession session, Object message) throws Exception {
    // TODO Auto-generated method stub
    super.messageReceived(session, message);
    System.out.println("jieshou");
    IoBuffer  io = (IoBuffer)message;
    byte[] b = io.array();
    System.out.println("changdu"+io.limit());
    for(int i=0;i<io.limit();i++){
        
        System.out.print(b[i]+" ");
    }
//   long a= session.getReadBytes();
//   IoBuffer io = (IoBuffer)message;
//   ByteBuffer by = io.buf();
//   session.write("nihao".getBytes());
//    
}
  
 @Override
    public void messageSent(IoSession session, Object message) throws Exception {
        // TODO Auto-generated method stub
        super.messageSent(session, message);
        System.out.println("keyifa");
 
       
         
    }
     @Override
    public void sessionCreated(IoSession session) throws Exception {
        // TODO Auto-generated method stub
        super.sessionCreated(session);
        System.out.println("´´½¨");
        
        
        
        
    }
     @Override
        public void sessionClosed(IoSession session) throws Exception {
            // TODO Auto-generated method stub
            super.sessionClosed(session);
            System.out.println("guanbi");
        }
}
