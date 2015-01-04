import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.util.Calendar;

import javax.crypto.spec.RC2ParameterSpec;


public class a {

    
    public static void main(String[] args) throws UnsupportedEncodingException {
        
     ByteBuffer byteb = ByteBuffer.wrap("nihao".getBytes("UTF-8"));
    
     
     byte[] b = byteb.array();
      
     for(int i=0;i<b.length;i++){
         System.out.print(b[i]);
     }
     
     System.out.println(b);
        
       
    }
    
    

}
