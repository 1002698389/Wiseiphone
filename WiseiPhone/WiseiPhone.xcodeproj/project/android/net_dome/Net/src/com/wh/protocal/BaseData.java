package com.wh.protocal;

import java.nio.ByteBuffer;

import com.wh.core.Const;
import com.wh.sum.Rc4;

public abstract class BaseData {
    public  final class  VaCmd{
       public  static final int cmdchannel_start = 1;
       public  static final int cmdchannel_stop = 2;
       public  static final int cmdchannel_updateparam= 3;
       public  static final int cmdchannel_startrecord= 4;
       public  static final int cmdchannel_updaterecord= 5;
       public  static final int cmdchannel_stoprecord= 6;
       public  static final int cmdchannel_callfastport= 7;
       public  static final int cmdchannel_delfastport= 8;
       public  static final int cmdchannel_savefastport= 9;
       public  static final int cmdchannel_addfastport= 10;
       public  static final int cmdchannel_setloopindex= 11;
       public  static final int cmdchannel_addloop= 12;
       public  static final int cmdchannel_delloop= 13;
       public  static final int cmdchannel_smartschedule_start= 14;
       public  static final int cmdchannel_smartschedule_stop= 15;
       public  static final int cmdchannel_smart_start= 16;
       public  static final int cmdchannel_smart_stop= 17;
       public  static final int cmdchannel_yuntai_start= 18;
       public  static final int cmdchannel_yuntai_stop= 19;
       public  static final int cmdchannel_yuntai_command= 20;
       public  static final int cmdchannel_smartschedule_update= 21;
       public  static final int cmdchannel_recordparam_change= 22;
       public  static final int cmdchannel_ptzsetmode= 23;
       public  static final int cmdchannel_ptzsettarget= 24;
       public  static final int cmdchannel_ptzsetparam= 25;
       public  static final int cmdchannel_setvideomaprelat= 26;
    }
    
    public final class Flag{
        public  static final int unflag = 0;
        public  static final int msgflag_encrypted = 1;
        public  static final int msgflag_zlibed = 2;
        
    }
   
    public final class MsgVaKeyType{
        public  static final int key_va_pubkey= 0;
        public  static final int key_va_logon= 1;
        public  static final int key_va_logon_result= 2;
        
        public  static final int key_va_status_server= 3;
        public  static final int key_va_status_channel= 4;
        public  static final int key_va_status_tracker= 5;

        public  static final int key_va_content_stream= 6;
        public  static final int key_va_content_site= 7;
        public  static final int key_va_content_scene= 8;         
        public  static final int key_va_content_recorder= 9;
        
        public  static final int key_va_cmd_getstatus= 10;
        public  static final int key_va_cmd_interested= 11;

        public  static final int key_va_cmd_channel= 12;      
        public  static final int key_va_cmd_scene= 13;
        public  static final int key_va_cmd_tracker= 14;
        public  static final int key_va_cmd_rule= 15;
        public  static final int key_va_cmd_stream= 16;

        public  static final int key_va_data_video= 17;
        public  static final int key_va_data_motiondata= 18;
        public  static final int key_va_data_alert= 19;
        public  static final int key_va_data_picture= 20;
        public  static final int key_va_event_global= 21;
        public  static final int key_va_data_channel= 22;
        public  static final int key_va_cmd_global= 23;
        public  static final int key_va_data_global= 24;
        public  static final int key_va_keeplive= 25;
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
    
   public final int mHeadLen = 8;
   private byte  key;
   private byte  flag;
   private byte  serverIndex;
   private byte  chIndex;
   private int   msgLen;
    

   public void getHeader(ByteBuffer buffer){
       buffer.flip();
       key =  buffer.get();
       flag =buffer.get();
       serverIndex = buffer.get();
       chIndex =buffer.get();
       msgLen =buffer.getInt();
   }
   
   
   
   
   public ByteBuffer putHeader(){
       ByteBuffer by = ByteBuffer.allocate(8);
       by.put(getKey());
       by.put(getFlag());
       System.out.println("包场"+getFlag());
       by.put(getServerIndex());
       by.put((byte)0);
       by.putInt(getBodylen());
  
       by.flip();
       return by;
   }
   
   
   //生成消息头
   public abstract  byte getKey();
   public abstract  byte getFlag();
   public abstract  byte getServerIndex();
   public abstract  byte getChIndex();
   public abstract  int  getBodylen();
   
    
    
    public static void main(String[] args) {
       
    }
    public ByteBuffer newPackage(){
        ByteBuffer header = putHeader();
        ByteBuffer body =   putBody();
        ByteBuffer by = ByteBuffer.allocate(this.mHeadLen+this.getBodylen());
        by.put(header);
        by.put(body);
        by.flip();
        
 
        
        
        return by;
    }
    
    public  void SendDate(ByteBuffer by){
        by = newPackage();
     
        
    }
    
    
    public void reciverDate(Byte[] buffer){
        
       
        
       // read(buffer);
    }

    abstract ByteBuffer putBody();
    abstract void readBody(Byte[] buffer);
    
    
    
  
    
   
}
