package com.wh.core;

import java.nio.ByteBuffer;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;

import com.wh.core.ProTal.VaLoggons;
import com.wh.core.TaskManager.CallBody;
import com.wh.customnet.VaCustomLogin;

public class MyHandler extends IoHandlerAdapter{
 private HeadManager h = null;
   
  @Override
public void messageReceived(IoSession session, Object message) throws Exception {
    // TODO Auto-generated method stub
      
     
    super.messageReceived(session, message);
    System.out.println("收到消息!!received");
    

    IoBuffer  io = (IoBuffer)message;
    io.flip();

     
     //把实现callback类注册到任务分发器里
   
        //     
//     Ti_valogon ti = new Ti_valogon();
//     Ti_valogon2 tt = new Ti_valogon2();
//     ti_pubkey p = new ti_pubkey();
//     Ti_PubKey p = new Ti_PubKey();
 
     //开始调用
     h.unPackge(io);
     

}
  
 @Override
    public void messageSent(IoSession session, Object message) throws Exception {
        // TODO Auto-generated method stub
        super.messageSent(session, message);
        System.out.println("发送消息成功");
 
       
         
    }
     @Override
    public void sessionCreated(IoSession session) throws Exception {
        // TODO Auto-generated method stub
        super.sessionCreated(session);
        System.out.println("session创建");
       
      
        //创建 解开包头类
         h = new HeadManager();
        //根据包头命令分发任务类
        TaskManager t = TaskManager.getIntance();
        //分发任务注册到包头类
        t.setSeesion(session);
        h.addCallBack(t);
        VaCustomLogin vaa = new VaCustomLogin(); 
        t.addCall((CallBody)vaa, 0);
        t.addCall((CallBody)vaa, 1);
        t.addCall((CallBody)vaa, 2);
/*      BaseProTal b = new BaseProTal();
      b.key=12;
      b.flag=12;
      b.msgLen=404;
      session.write(b);
              
     session.write("nihao");
        
        IoBuffer io = IoBuffer.allocate(4);
        io.putInt(300);
        io.flip();
        
        session.write(io.buf());*/
        
        
     
 /*       ProTal.VaLoggons vlog = new  ProTal.VaLoggons();
          vlog.flag=0;
          vlog.key =1;
          vlog.logonUsrName="admin".getBytes();
          vlog.logonUsrPassSHA1= new byte[]{0};
          vlog.sessionkey = Const.Key.key.getBytes();
          vaa.set(vlog);
          vaa.onSendMessages(vlog);*/
     
        
      
        
        
    }
     
     @Override
        public void exceptionCaught(IoSession session, Throwable cause) throws Exception {
            // TODO Auto-generated method stub
            super.exceptionCaught(session, cause);
            cause.printStackTrace();
        }
     @Override
        public void sessionClosed(IoSession session) throws Exception {
            // TODO Auto-generated method stub
            super.sessionClosed(session);
            System.out.println("session关闭");
        }
  
}
