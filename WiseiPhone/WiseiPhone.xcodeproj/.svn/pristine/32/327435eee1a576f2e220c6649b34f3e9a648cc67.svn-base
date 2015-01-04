import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.Collator;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Locale;


public class TestChinal {

  
    public static void main(String[] args) {
        
    }
    
    public void star(){
        
        try {
            Socket so = new Socket("192.168.10.110", 38);
             
            BufferedInputStream in=  new BufferedInputStream(so.getInputStream());
            BufferedOutputStream out= new BufferedOutputStream(so.getOutputStream());
            byte[] by = new byte[1024];
            in.read(by);
            System.out.println(new String(by));
            out.write("nihao".getBytes());
            out.flush();
            
            
            
            
            
        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
    }
    
}
