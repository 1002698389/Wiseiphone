package com.wh.protocal;

import java.nio.ByteBuffer;

public class Clent {
    public IData idata;
    
    

    public void sendData(ByteBuffer by){
        idata.send(by);
    }
 
    
 public void setIdata(IData idatea){
     this.idata = idatea;
 }
    
    
 public interface IData{
        void send(ByteBuffer by);
    }

}
