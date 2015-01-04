package com.wh.net;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;

import com.wh.protocal.BaseData;
import com.wh.protocal.Clent;
import com.wh.protocal.Clent.IData;
import com.wh.protocal.VaLogon;
import com.wh.sum.SessionKey;


public class Client {
    private  Clent c ;
    private int curnetstatu = -1;
    private SocketChannel sk;
    
//    
    String tIp ="192.168.1.244";
    int tPoint = 9800;
//    String tIp ="192.168.1.184";
//    int tPoint = 38;
    
  public static void main(String[] args) throws UnknownHostException, IOException {
//      
      try {
//          Client cc = new Client();
//          cc.Start();
//          VaLogon va = new VaLogon();
//          SocketChannel sk1    = (SocketChannel)skey.channel();
//          sk1.write(va.newPackage());
          new SessionKey().getKey();
          VaLogon va = new VaLogon();
         ByteBuffer by = va.newPackage();
         by.flip();
         System.out.println(by.get()+"  "+by.mark());
         System.out.println(by.get()+"  "+by.mark());
         System.out.println(by.get()+"  "+by.mark());
         System.out.println(by.getInt()+"  "+by.mark()+"");
         System.out.println(by.getShort()+"  "+by.mark());
         System.out.println(by.getShort()+"  "+by.mark());
            
            
            
//          System.out.println(by.get());
//          System.out.println(by.get());
//          System.out.println(by.get());
//          System.out.println(by.get());
//          System.out.println(by.getInt());
//          System.out.println();
//          System.out.println();
//          System.out.println();
         System.out.println(by.getShort());
         System.out.println(by.getShort());
         System.out.println(by.getShort());
         System.out.println(by.getShort());
    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
  }
  
  
  
  
  
  
  
   public void Start() throws UnknownHostException, IOException, Exception{
           c = new Clent();
           ByteBuffer mgs = ByteBuffer.allocate(1024);
           sk = SocketChannel.open(new InetSocketAddress(tIp, tPoint));
           sk.configureBlocking(false);
           Selector sele = Selector.open();
           
           sk.register(sele, SelectionKey.OP_READ | SelectionKey.OP_WRITE );
            while(true){
            while(sele.select(100)>0){
                Iterator it = sele.selectedKeys().iterator();
                while(it.hasNext()){
                    final SelectionKey skey = (SelectionKey) it.next();
                    it.remove();
                    if(skey.isReadable()){
                        SocketChannel sk1    = (SocketChannel)skey.channel();
                        ByteBuffer msg = ByteBuffer.allocate(1024);
                        int a =  sk1.read(msg);
                        msg.flip();
                        System.out.println(msg.toString());

                    }else if(skey.isWritable()){
                        new SessionKey().getKey();
                        VaLogon va = new VaLogon();
                        SocketChannel sk1    = (SocketChannel)skey.channel();
                        sk1.write(va.newPackage());
                        
                        ByteBuffer by = va.newPackage();
                        by.flip();
                        System.out.println(by.get());
                        System.out.println(by.get());
                        System.out.println(by.get());
                        System.out.println(by.get());
                        System.out.println(by.getInt());
                        
                        
                        
                        
                        
                        
//                        c.setIdata(new IData() {
//                          
//                           @Override
//                           public void send(ByteBuffer by) {
//                               SocketChannel sk1    = (SocketChannel)skey.channel();
//                               try {
//                                sk1.write(by);
//                            } catch (IOException e) {
//                                e.printStackTrace();
//                            }
//                               
//                           }
//                       });
                    
                        break;
                    
                      
                    }
                }
            }
           
            }
            
           
           
//           while(!sk.finishConnect()){
//               
//               System.out.println("dengdai");
//               Thread.sleep(1000);
//               
//           }
//           int num=0;
//           while((num = sk.read(mgs))!=-1){
//               
//               if(num  == 0){
//                   
//                   Thread.sleep(10);
//                   continue;
//               }
//           }
//           
//           mgs.flip();
//           
//           System.out.println(mgs.remaining());
//           
           
           
           
//           InputStream in  =null;
//           OutputStream os =null;
//           BufferedInputStream br = null;
//           BufferedOutputStream bw = null;
//           byte[] msg = new byte[1024];
//           try {
//           
//                in = sk.getInputStream();
//                os = sk.getOutputStream();
//                br = new BufferedInputStream(in);
//                bw = new BufferedOutputStream(os); 
//                while(true){
//                    int a =0;
//                    while((a=br.read(msg))!=-1){
//                        System.out.println(a);
//                      //  System.out.print(new String(msg,0,a));
//                    }
                    
       }
        
   public Clent gettClent(){
       if(c != null){
           return c;
       }
       return null;
   }
        
   
  
}

   
