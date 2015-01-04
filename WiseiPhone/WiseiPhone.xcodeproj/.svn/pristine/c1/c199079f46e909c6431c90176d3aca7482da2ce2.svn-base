package com.wh.customnet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;


public class TestServer extends Thread {
    private Socket mSocket;

    public TestServer(Socket socket) {
        this.mSocket = socket;
    }

    public static void main(String[] args) throws Exception {
        ServerSocket s = new ServerSocket(9800);
        while (true) {
            Socket socket = s.accept();
            new TestServer(socket).start();
        }
    }

    @Override
    public void run() {
        System.out.println("服务端执行");

        try {
            PrintWriter out = new PrintWriter(mSocket.getOutputStream()) ;
            InputStream in = mSocket.getInputStream();
            
            out.write("1231222222222222222222222");
            out.flush();
            System.out.println("fa chenggng");
            
            
            byte[] by = new byte[1024];

            in.read(by);

            // for(int i=0;i<by.length;i++){
            //
            // System.out.print(by[i]+" ");
            // }
            //
            //
            
            

            ByteBuffer io = ByteBuffer.wrap(by);
            io.order(ByteOrder.LITTLE_ENDIAN);
            System.out.println(io.mark());
            System.out.println("________报文头__________");
            System.out.println("key " + io.get());
            System.out.println("flag " + io.get());
            System.out.println("serverindex " + io.get());
            System.out.println("char " + io.get());
            System.out.println("消息长度 " + io.getInt());
            
            System.out.println("________报文体__________");
            int slen = io.getShort();
            int zlen=io.getShort();
            int mlen=io.getShort();
            System.out.println("seseseion长度 " + slen);
            System.out.println("账号长度 " + zlen);
            System.out.println("密码长度 " + mlen);
            System.out.print("banben " + io.getShort());
            
            
            byte[] b = new byte[128];
            io.get(b, 0, 128);
            System.out.println("账号 "+ new String(b,0,zlen));
            
            byte[] b1 = new byte[128];
            io.get(b, 0, 128);
            System.out.println("密码 "+ (char)b1[0]);
            
            byte[] bb = new byte[128];
            io.get(bb, 0, bb.length);
            System.out.println("sessionkey值 "+ new String(bb,0,slen));
            
          //  System.out.println("账号 " + io.getShort());
            // out = mSocket.getOutputStream();
            // out.write("ni men hao".getBytes());
         
            
         Thread.sleep(10000);   
            
            in.close();
            out.close();
            mSocket.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

}
