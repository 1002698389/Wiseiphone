import org.apache.mina.core.session.IoSession;

import com.wh.net.MinaCient;


public class Test {

    /**
     * @param args
     */
    public static void main(String[] args) {
      
       IoSession io = MinaCient.getIosession();
        
       io.write("nihao".getBytes());
        

    }

}
interface Commend{
    
    public void openFile();
    public void closeFile();
    public void parseFile();
}
class commendI implements Commend{
Recever re;
 
 
    public void setRecever(Recever r){
        this.re=r;
    }
    @Override
    public void openFile() {
        // TODO Auto-generated method stub
        System.out.println("�Ҹ�������ļ�");
       re.open();
    }
    @Override
    public void closeFile() {
        // TODO Auto-generated method stub
        System.out.println("�Ҹ���ر����ļ�");
        re.close();
    }
    @Override
    public void parseFile() {
        // TODO Auto-generated method stub
        System.out.println("�Ҹ��������ļ�");
        re.parse();
    }
    
}

class Recever{
    
    public void open(){
        
        System.out.println("���Ѿ������ļ�");
    }
    public void close(){
        System.out.println("�ҹر����ļ�");
        
    }
    public void parse(){
        System.out.println("�Ҹ������ļ�");
    }
}
class invoke{
    Commend co;
    public void setCommend(Commend cos){
        
        this.co=cos;
    }
    public void  Open(){
        co.openFile();
    }
    public void close(){
        co.closeFile();
    }
    public void parse(){
        co.parseFile();
    }
}