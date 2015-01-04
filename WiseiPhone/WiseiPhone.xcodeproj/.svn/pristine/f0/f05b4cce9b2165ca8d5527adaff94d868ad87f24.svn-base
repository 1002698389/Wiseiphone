package com.wh.sum;

import java.util.Random;

import com.wh.net.Const;

public class SessionKey {

   
    public void getKey(){
        
        long time = System.currentTimeMillis();
        Random ran = new Random();
        long r = Math.abs(ran.nextLong());
        long b = time +r;
        System.out.println("daying b");
        
        Const.Key.SessionKey = b+"";
        
        
    }
    public static void main(String[] args) {
        
        new SessionKey().getKey();
    }
    
}
