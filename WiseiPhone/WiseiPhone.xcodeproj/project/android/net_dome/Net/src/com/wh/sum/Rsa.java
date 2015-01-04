package com.wh.sum;

import java.nio.ByteBuffer;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.security.spec.X509EncodedKeySpec;


import javax.crypto.Cipher;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.util.Base64;
import org.omg.CORBA.PRIVATE_MEMBER;

import sun.misc.BASE64Decoder;


public class Rsa {
    private static Rsa rsa = null;
    public RSAPublicKey rsaPublicKey = null;
    private Rsa(){
       
    }
    
    public static Rsa getRsaInstance(){
        
        if(rsa == null){
            return new Rsa();
        }
        return rsa;
    }
    
    
    
    
    
    
    
    
    private RSAPublicKey getRsaPublickey(byte[] pubkey){
        X509EncodedKeySpec keySpec =  new X509EncodedKeySpec(pubkey);
        RSAPublicKey pubkey1 = null;
        try {
            KeyFactory kf = KeyFactory.getInstance("RSA");
            pubkey1 =(RSAPublicKey)kf.generatePublic(keySpec);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return pubkey1;
    }
    
    
    public void setPubkey(byte[] pubkey){
       rsaPublicKey = getRsaPublickey(pubkey);
    }
    
    
    
    /**
     * @param args
     */
    public static void main(String[] args) {
        ByteBuffer io = ByteBuffer.allocate(4);
        io.putInt(404);
        io.flip();
        byte[] mi ="admin".getBytes();
        Rsa rsa = Rsa.getRsaInstance();
//        RSAPublicKey pu = rsa.getPublicKey("jiami");
     
//        rsa.encrypt(data)
        KeyPair k = rsa.generateKey();
        
        byte[] data = k.getPublic().getEncoded();
        for (int i = 0; i < data.length; i++) {
            System.out.print(data[i]+" ");
        
        }
        System.out.println();
        System.out.println(data.length);
        
        rsa.rsaPublicKey = rsa.getRsaPublickey(data);
        
        byte[] pwd =  rsa.encrypt(mi);
        System.out.println(new String(pwd));
        
        
        PrivateKey pri = (RSAPrivateKey)k.getPrivate();
        byte[] j = rsa.decrypt((RSAPrivateKey)pri, pwd);
        
         System.out.println(new String(j));
        
        
       // System.out.println(new String(miw));
    }
    public  RSAPublicKey getPublicKey(String key) throws Exception {  
        byte[] keyBytes;  
        keyBytes = (new BASE64Decoder()).decodeBuffer(key);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);  
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");  
        RSAPublicKey publicKey = (RSAPublicKey)keyFactory.generatePublic(keySpec);  
        return publicKey;  
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
    private byte[] encrypt(byte[] data){
        
        if(rsaPublicKey != null){
            try{
                Cipher cipher = Cipher.getInstance("RSA");
                cipher.init(Cipher.ENCRYPT_MODE, rsaPublicKey);
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
