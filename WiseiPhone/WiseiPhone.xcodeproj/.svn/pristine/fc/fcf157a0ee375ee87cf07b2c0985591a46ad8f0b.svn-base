package com.wh.customnet;

import java.nio.ByteOrder;

import org.apache.mina.core.buffer.IoBuffer;

import com.wh.core.BaseProTal;
import com.wh.core.Base_data;
import com.wh.core.Const;
import com.wh.core.ProTal;
import com.wh.sum.Rsa;

public class VaCustomLogin extends Base_data {

     
    private ProTal.VaLoggons va;

    public void set(ProTal.VaLoggons vas){
      this.va =vas;
      va.sessionkeylen = (short) va.sessionkey.length;
      va.usrnamelen = (short) va.logonUsrName.length;
      va.usrpasslen = (short) va.logonUsrPassSHA1.length;
      va.logonUsrName = new byte[128];
      va.logonUsrPassSHA1 = new byte[128];
      va.sessionkey = new byte[128];
      va.logonUsrName = super.addByteByMaxlen("admin", MaxLen.E_MODULE_LEN);
      va.logonUsrPassSHA1 = super.addByteByMaxlen("", MaxLen.E_MODULE_LEN);
      va.sessionkey = super.addByteByMaxlen(Const.Key.key, MaxLen.E_MODULE_LEN);
      va.msgLen = 8+8+3*128;
    }
    
 

    @Override
    protected void onRecive(IoBuffer bodyBuffer, int cmd, BaseProTal header) {
       
        byte[] by = bodyBuffer.array();
        System.out.println("自定义");
        switch (header.key) {
        case 0:
            super.print_pkg_header(header);
             //Rsa.getRsaInstance().setPubkey(bodyBuffer.array());
             ProTal.VaLoggons vlog = new  ProTal.VaLoggons();
             vlog.flag=4;
             vlog.key =1;
             vlog.logonUsrName="admin".getBytes();
             vlog.logonUsrPassSHA1= "".getBytes();
             vlog.sessionkey = Const.Key.key.getBytes();
             this.set(vlog);
             this.onSendMessages();
            break;
        case 1:
            break;
        case 2:
              super.print_pkg_header(header);
      
            
             String s = bodyBuffer.getInt()==0?"登陆成功":"登陆失败";
             System.out.println(s);
             System.out.println("用户权限"+ bodyBuffer.getInt());
            break;

        default:
            break;
        }
        
        
        
        
       
      
        
    }

    @Override
    protected IoBuffer getHeader() {
        IoBuffer io = IoBuffer.allocate(8);
        io.order(ByteOrder.LITTLE_ENDIAN);
        io.putUnsigned(va.key);
        io.putUnsigned(va.flag);
        io.putUnsigned(va.serverIndex);
        io.putUnsigned(va.chIndex);
        io.putInt(va.msgLen);
        io.flip();
        return io;
    }

    @Override
    protected IoBuffer getBody() {
        IoBuffer io = IoBuffer.allocate(va.msgLen);
        io.order(ByteOrder.LITTLE_ENDIAN);
        io.putUnsignedShort(va.sessionkeylen);
        io.putUnsignedShort(va.usrnamelen);
        io.putUnsignedShort(va.usrpasslen);
        io.putUnsignedShort(va.pad);
         int a = va.logonUsrName.length;
        io.put(va.logonUsrName);
        io.put(va.logonUsrPassSHA1);
        io.put(va.sessionkey);
        io.flip();
        return io;
    }

}
