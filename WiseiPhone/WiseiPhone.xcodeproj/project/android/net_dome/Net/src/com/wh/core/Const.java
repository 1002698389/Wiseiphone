package com.wh.core;

import java.util.Random;

public class Const {
    
    
    
    public static final class Net{
        public static final int client_disconnected = 0;
        public static final int client_connecting = 1;
        public static final int client_connected = 2;
        public static final int client_pubkeygeted = 3;
        public static final int client_authok = 4;
        public static final int NetClientStatus = 5;
    }
    
    
    
    public static final class Key{
        public static  String key ;
        
        
    }
    
    
    public static void main(String[] args) {
        
        Random ran = new Random();
         StringBuffer sb = new StringBuffer();
         long a = System.currentTimeMillis();
         long b = ran.nextLong();
         long c = ran.nextLong();
         sb.append(a).append(Math.abs(b)).append(Math.abs(c));
       
       System.out.println(sb.toString());
       System.out.println(sb.toString().getBytes().length);
         
        
        
      
     int ab =34333333;
     System.out.println(String.valueOf(ab).getBytes().length);
        
     
    }

}
 