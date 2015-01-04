import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.StringWriter;


public class Test1 {

    /**
     * @param args
     * @throws FileNotFoundException 
     */
    public static void main(String[] args) throws FileNotFoundException {
       // System.out.println(Test1.init());
        StringWriter s = new StringWriter();
        s.write("王辉。今天来写这个");
        PrintWriter pr = new PrintWriter("E://wanghui.txt");
        pr.write(s.toString());
        pr.flush();
        pr.close();
        
    }
    
    public static String init(){
      StringWriter sw = new StringWriter();
    //  sw.write("sdfdsfdsfds王辉");
      PrintWriter pw = new PrintWriter(sw);
      try{
          int[] s = {1,2,3,4,5};
          System.out.println(s[6]);
          
      } catch(Exception e){
          Throwable tw =e.getCause();
          while(tw!=null){
              tw.printStackTrace(pw);
              tw =e.getCause();
          }
          pw.flush();
          pw.close();
          System.out.println("      = = = = ="+pw.toString()+"---------");
      }
      
      
      
        
       //sw.flush();
        return  sw.getBuffer().toString();
    }
    

}
