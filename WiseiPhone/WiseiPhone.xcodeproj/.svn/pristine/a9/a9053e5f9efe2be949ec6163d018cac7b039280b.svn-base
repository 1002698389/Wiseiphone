package com.wh.net;

import java.net.InetSocketAddress;
import java.net.SocketAddress;

import org.apache.mina.core.future.ConnectFuture;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;
import org.apache.mina.transport.socket.nio.NioSocketConnector;

public class MinaCient {
    private String ip;
    private int point;
    public static IoSession session;

    public MinaCient(String ip, int point) {
        this.ip = ip;
        this.point = point;
    }
    
    
    public static void main(String[] args) {
        new MinaCient("192.168.1.244", 9800).star();
    }

    public void star() {
        byte[] by = new byte[]{110,118};
        
        System.out.println("zhuanhuan"+new String(by));
        
        
        
        
        
        
//        String a="王";
//        byte[] by =a.getBytes();
//        for(int i=0;i<by.length;i++){
//            System.out.print("二进制"+by[i]);
//        }
        
        
        
        
        
        NioSocketConnector nkt = new NioSocketConnector();
        nkt.setConnectTimeoutMillis(5000);
        nkt.setHandler(new MyHandler());
        ConnectFuture cf = nkt.connect(new InetSocketAddress(ip, point));
       
        cf.awaitUninterruptibly();
        if (cf.isDone()) {
            if (!cf.isConnected()) {
                System.out.print("连接失败");
                cf.cancel();
                nkt.dispose();
            } else {
                session = cf.getSession();
                System.out.println("chengong");
            }

        }

    }
    
    public static IoSession getIosession(){
          if(session !=null){
              return session; 
          }
                  
          return null;
    }
    
    
    
   
}
