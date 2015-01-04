package com.wh.core;

import java.nio.ByteOrder;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;

import com.wh.core.TaskManager.CallBody;


public abstract class Base_data implements CallBody {
    //该类封装 session rc4 rsa;
    public final class Flag{
        public  static final int unflag = 0;
        public  static final int msgflag_encrypted = 1;
        public  static final int msgflag_zlibed = 2;
        
    }
    
    public final class MaxLen{
        public  static final int E_MAX_RSA_MODULUS_BITS = 1024;
        public  static final int E_MAX_RSA_MODULUS_LEN = 132;
        public  static final int E_MAX_RSA_PRIME_BITS = 516;
        public  static final int E_MAX_RSA_PRIME_LEN = 68;
        public  static final int E_MAX_SESSION_KEYLEN = 256;
        public  static final int E_MAX_NAMELEN = 128;
        public  static final int E_MODULE_LEN = 128;
        public  static final int E_MAX_RSA_STR_LEN = 56 ;  
        
        
    }
    
    public IoSession io = null;

    public Base_data() {
        io = TaskManager.getIntance().getSession();
    }

    protected IoSession getSession() {
        if (null != io && !io.isClosing()) {
            return io;
        }
        return null;
    }
    
    //根据原数据生成要求指定长度数据
    public byte[] addByteByMaxlen(String data,int maxLen){
        byte[] dest = new byte[maxLen];
        byte[] src  = data.getBytes();
        System.arraycopy(src, 0, dest, 0, src.length);
        return dest;
    }
    
    @Override
    public void callBody(IoBuffer buffer, int cmd, BaseProTal header) {
          if(header != null){
              
              if(cmd == 0){
                  
                  onRecive(buffer, cmd, header);
                  return;
              }
              
              //解析数组 抓出包体
              byte[] by = buffer.array();
//              System.out.println("原生数据");
//              for (int i = 0; i < by.length; i++) {
//                System.out.print(by[i]+" ");
//            }
//              
              
              byte[] target = new byte[header.msgLen];
              System.arraycopy(by, 8, target, 0, header.msgLen);
              IoBuffer buff = IoBuffer.wrap(target);
              
              if(header.flag ==  Base_data.Flag.unflag){
                  
                  onRecive(buff, cmd, header);
                  
              }else if(header.flag ==  Base_data.Flag.msgflag_encrypted){
               
                  //解密在这写
                  
                  //调用解析包体
                  onRecive(buff, cmd, header);
                  
              }
              
          }
        
    }
    protected void print_pkg_header(BaseProTal header) {
        
        System.out.println("登陆返回包——");
        System.out.println("key "+ header.key);
        System.out.println("flag "+ header.flag);
        System.out.println("serverindex "+ header.serverIndex);
        System.out.println("chindex "+ header.chIndex);
        System.out.println("msglen "+ header.msgLen);
        
    }
    
    public void onSendMessages(){
        IoBuffer header = getHeader();
        IoBuffer body =getBody();
        System.out.println("header成功"+header.mark());
        BaseProTal ba = new BaseProTal();
        ba.key =(byte) header.getUnsigned();
        ba.key =(byte) header.getUnsigned();
        ba.key =(byte) header.getUnsigned();
        ba.key =(byte) header.getUnsigned();
        ba.msgLen =   (int) header.getUnsignedInt();
        if(ba.key==Base_data.Flag.msgflag_encrypted){
            System.out.println("加密包体");
        }else{
        }
        header.flip();
        IoBuffer io = IoBuffer.allocate(ba.msgLen);
        io.order(ByteOrder.LITTLE_ENDIAN);
        io.put(header);
        io.put(body);
        io.flip();
        getSession().write(io);
    }
    
    
    protected abstract IoBuffer getHeader();
    protected abstract IoBuffer getBody();    
    protected abstract void onRecive(IoBuffer bodyBuffer, int cmd, BaseProTal header);
    
    
}
