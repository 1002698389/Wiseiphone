package com.wh.sum;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;

public class Rsa {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Rsa rsa = new Rsa();
       KeyPair keyPair = rsa.generateKey();
       RSAPublicKey publickey = (RSAPublicKey) keyPair.getPublic();
       RSAPrivateKey privatekey = (RSAPrivateKey) keyPair.getPrivate();
       System.out.println(publickey.toString());
       System.out.println(); 
       System.out.println(); 
       System.out.println(privatekey.toString()); 
       
       String name = "admin";
        
       byte[] jia = rsa.encrypt(publickey, name.getBytes());
       System.out.println(new String(jia,0,jia.length));
       
      
       byte[] de = rsa.decrypt(privatekey, jia);
       System.out.println(new String(de,0,de.length));
       
       

    }


    
    private byte[] decrypt(RSAPrivateKey privatekey,byte[] raw){
        if(privatekey != null){
            try {
                Cipher cipher = Cipher.getInstance("RSA");
                cipher.init(Cipher.DECRYPT_MODE, privatekey); 
                return cipher.doFinal(raw);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        return null;
    }
    
    
    private byte[] encrypt(RSAPublicKey pulicKey,byte[] data){
        
        if(pulicKey != null){
            try{
                Cipher cipher = Cipher.getInstance("RSA");
                cipher.init(Cipher.ENCRYPT_MODE, pulicKey);
                return cipher.doFinal(data); 
            }
            catch(Exception e){
                e.printStackTrace();
            }
            
            
        }
        
        
        
        
        return null;
       
        
        
    }
    
    
    public KeyPair generateKey(){
        KeyPairGenerator keypairgen;
        try {
            keypairgen = KeyPairGenerator.getInstance("RSA");
            keypairgen.initialize(1024,new SecureRandom());
            KeyPair keypair = keypairgen.generateKeyPair();
            return keypair;
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
       
        return null;
        
        
        
        
    }
    

}
