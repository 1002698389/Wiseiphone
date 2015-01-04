package com.wh.protocal;

import java.nio.ByteBuffer;

public class BaseUndata {
   protected  ByteBuffer bbf;
   public BaseUndata(ByteBuffer bytebuffer){
       this.bbf = bytebuffer;
   }
   
   public void unPackageHeader(){
        bbf.flip();
        byte  key = bbf.get();
        byte  flag = bbf.get();
        byte  serverIndex = bbf.get();
        byte  chIndex  = bbf.get();
        int   msgLen =bbf.getInt();
        System.out.println(key +" "+flag+"  "+msgLen);
       
   }

    
    
    
}
