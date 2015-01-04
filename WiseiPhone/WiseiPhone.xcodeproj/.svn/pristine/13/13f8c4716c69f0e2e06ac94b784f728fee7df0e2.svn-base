package com.wh.net;

import java.nio.ByteOrder;
import java.util.Iterator;

import org.apache.mina.core.buffer.IoBuffer;


public class Test {

    /**
     * @param args
     */
    public static void main(String[] args) {
        
        
        
        IoBuffer io = IoBuffer.allocate(4);
        io.order(ByteOrder.LITTLE_ENDIAN);
        io.putInt(400);
        io.clear();
      
        byte[] b = io.array();
         for (int i = 0; i < b.length; i++) {
            System.out.print(b[i]+" ");
        }
         io.flip();
         System.out.println();
         
         
         System.out.println();
         IoBuffer ia = IoBuffer.allocate(4);
         ia.order(ByteOrder.nativeOrder());
         ia.putUnsignedInt(400);
         ia.clear();
         byte[] b1 = ia.array();
          for (int i = 0; i < b1.length; i++) {
             System.out.print(b1[i]+" ");
         }  
        
        
        
        
        
        
        
        
//        String a="ÄãºÃ";
//        byte[] b = a.getBytes();
//        
//        for (int i = 0; i < b.length; i++) {
//            System.out.print(b[i]+" ");
//        }
//        
//       System.out.println(" shang"); 
//        
//        
//        
//        byte[]  aa =   new byte[]{-108,1,0,0};
//        byte[]  aa1 =   new byte[]{0,0,1,-108};
//        
//        
//        IoBuffer io = IoBuffer.allocate(5);
//        io.order(ByteOrder.BIG_ENDIAN);
//        io.putInt(404);
//        io.flip();
//       
//      
//        
//        System.out.println(io.getUnsignedInt());
//         byte[] arr=io.array();
//        for (int i = 0; i < arr.length; i++) {
//         System.out.print(arr[i]+" ");
//      }
//        io.getShort();
//        System.out.println(io.remaining());
        
//        
//        io.flip();
//        
//        byte[] arr = io.array();
//       
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
        
//        IoBuffer io = IoBuffer.wrap(aa);
//        io.order(ByteOrder.LITTLE_ENDIAN);
        
//        byte[] a = io.array();
//        for (byte b : a) {
//            System.out.println(b+" ");
//        }
//        
//        System.out.println(io.getInt());
//        
        
        
       // byte[]  aa1 =   new byte[]{0,0,1,-108};
//        System.out.println(UtillNumber.bytesToInt(aa));
//        
   
//     //  io.order(ByteOrder.BIG_ENDIAN);
//       System.out.println(io.getInt());
//       io.clear();
       
       
    //   System.out.println(io.getInt());
//        
//        byte[] big = io.array();
//        for (int i = 0; i < big.length; i++) {
//            byte b = big[i];
//            System.out.print(b+" ");
//        io.order(ByteOrder.LITTLE_ENDIAN);
//        byte[] bigs = io.array();
//        for (int i = 0; i < bigs.length; i++) {
//            byte b = bigs[i];
//            System.out.print(b+"  ");
//            
//        }
        
       //   System.out.println(io.getInt());
//            
        
       
  
        
        
//        
//       // io.order(ByteOrder.)
//        io.put((byte)32);
//        io.putInt(404);
//        io.flip();
//   
//        byte[] by =io.array();
//        
//        for (int i = 0; i < by.length; i++) {
//            byte b = by[i];
//            System.out.print(b+" ");
//            
//        }
        
//        System.out.println(io.get());
//        System.out.println(io.getInt());
//        System.out.println(io.getUnsignedInt());
//        System.out.println(UtillNumber.bytesToInt(aa));
    }

}
