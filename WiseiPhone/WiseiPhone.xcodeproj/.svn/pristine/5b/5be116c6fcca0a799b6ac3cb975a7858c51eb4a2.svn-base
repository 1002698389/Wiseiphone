package com.wh.sum;

import java.util.Random;

import com.wh.core.Const;

public class SessionKey {

   
    public static String getKey(){
        long time = System.currentTimeMillis();
        Random ran = new Random();
        long r = Math.abs(ran.nextLong());
        long b = time +r;
        String bb =String.format("%s%s%s", "se",b,"key");
        System.out.println(bb);
        return bb;
    }
    
    
    
    
    public static void main(String[] args) {
        
        new SessionKey().getKey();
    }
    
}
