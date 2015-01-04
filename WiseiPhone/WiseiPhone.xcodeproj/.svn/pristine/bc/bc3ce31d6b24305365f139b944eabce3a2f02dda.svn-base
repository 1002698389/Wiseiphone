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
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;


public class Server {

    /**
     * @param args
     */
    public static void main(String[] args) {
      try {
        new Server().Lisen();
    } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    }
    public void Lisen() throws IOException{
        
        ServerSocket ser = new ServerSocket(38);
        while(true){
        Socket server  = ser.accept();  
        new Con(server).start();
        }
        
    }
    
    class Con  extends Thread{
        Socket sk;
        public Con(Socket socket){
            this.sk = socket;
            
        }
        @Override
        public void run() {
            InputStream in  =null;
            OutputStream os =null;
           BufferedReader bd = new BufferedReader(new InputStreamReader(sk.getInputStream()));
           PrintWriter p = new PrintWriter(sk.getOutputStream());
            byte[] msg = new byte[1024];
            try {
                 in = sk.getInputStream();
                 os = sk.getOutputStream();
                 
                 byte[] by = new byte[1024];
                 p.write("欢迎连接服务器");
                while(true){
                    int aa = 0;
                   while((aa=br.read(by))!=-1){
                       System.out.println(new char[aa]);
                   }
                    
                    
                }
                 
                 
//                 int a =  br.read(msg);
//                 System.out.println("服务器收到"+new String(msg, 0, a));
                 
                 
                 
              
                 
             
                              
           
                 
                 
                 
            
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }finally{
//                    br.close();
//                    bw.close();
//                    os.close();
//                    sk.close();
              
              
            }
           
           
        }
        
        
    }
    
    

}
