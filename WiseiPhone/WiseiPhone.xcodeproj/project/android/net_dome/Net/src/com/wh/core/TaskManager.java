package com.wh.core;

import java.nio.Buffer;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;


import com.wh.core.HeadManager.CallBak;
import com.wh.customnet.VaCustomLogin;
import com.wh.sum.SessionKey;

public class TaskManager implements CallBak {
    private TaskManager(){
        ha = new HashMap<Integer, TaskManager.CallBody>();
        
        if(Const.Key.key == null){
            Const.Key.key = SessionKey.getKey();
        }
     }
    private static TaskManager task;
    private IoSession io;
    
    public static TaskManager getIntance(){
        
        if(task == null){
            task  = new TaskManager();
        }
        return task;
    }
    
    private HashMap<Integer, CallBody> ha;
    
    
    public IoSession getSession(){
        
        
        if(io ==null){
            System.out.println("无法得到session");
         
        }
        return io;
    }
   
    public void addCall(CallBody call,int cmd){
        if(ha.containsKey(cmd)){
            ha.remove(cmd);
        }
        ha.put(cmd, call);
    }
    
    public void removeByKey(int cmd){
        if(ha.containsKey(cmd)){
            ha.remove(cmd);
        }
        
        
    }
      public void setSeesion(IoSession s){
        this.io =s;
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
    
    @Override
    public void readPkgBoddy(IoBuffer buffer, int cmd,BaseProTal header) {
      notifyCall(buffer, cmd,header);
        
    }
    
    public void notifyCall(IoBuffer buffer,int cmd,BaseProTal header){
        
           if(!ha.containsKey(cmd)){
                try {
                    throw new Exception("命令对应类无法找到，无法运行！");
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
           }
           CallBody cl = ha.get(cmd);
           cl.callBody(buffer, cmd,header);
    }
    
    
   
 public static void main(String[] args) {
    ArrayList<String> s = new ArrayList<String>();
    
    s.add(0, "w");
    s.add(5,"b");
    
    System.out.println(s.size());
     
}
 
 public interface CallBody{
     
     public void callBody(IoBuffer buffer,int cmd,BaseProTal header);
 }


 
}
