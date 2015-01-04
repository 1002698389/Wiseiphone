//package com.wh.ws.ob;
//
//import android.content.Context;
//import android.graphics.Bitmap;
//import android.graphics.BitmapFactory;
//import android.graphics.Canvas;
//import android.graphics.Matrix;
//import android.graphics.Paint;
//import android.view.View;
//
//import com.wh.ws.R;
//import com.wh.ws.ui.Const;
//
//public class DrawOri extends Thread {
//    public static final int ORI_1  = 1;
//    public static final int ORI_2  = ORI_1 + 1;
//    public static final int ORI_3  = ORI_1 + 2;
//    public static final int ORI_4  = ORI_1 + 3;
//    public static final int ORI_5  = ORI_1 + 4;
//    public static final int ORI_6  = ORI_1 + 5;
//    public static final int ORI_7  = ORI_1 + 6;
//    public static final int ORI_8  = ORI_1 + 7;
//    private static DrawOri mDrawOri = null;
//    private Context mContext;
//    private Canvas canvas = null;
//    private int ori = -1;
//    private Paint pa = null;
//    private int offer =75;
//    public boolean isDraw = false;
//    public boolean xc=false;
//    private Matrix mMatrix,ma = null;
//    Bitmap[] bits,bith;
//    View v;
//
//
//    
//    public void setOne(Context cte,int ori,View v){
//        this.mContext =cte;
//        this.ori = ori;
//        this.v=v;
//        init();
//    }
//    
//    
//
//    public void star(){
//        xc =true;
//        isDraw =true;
//        
//    }
//    public void stopTh(){
//      
//        xc =false;
//      
//        v.postInvalidate();
//        
//    }
//    public void stopt(){
//        isDraw =false;
//    
//        v.postInvalidate();
//    }
//    private void init(){
//       pa = new Paint();
//       mMatrix = new Matrix();
//       ma = new Matrix();
//       
//       Bitmap bit = BitmapFactory.decodeResource(mContext.getResources(), R.drawable.arrow_rule_normal);
//       Bitmap bit1 = BitmapFactory.decodeResource(mContext.getResources(), R.drawable.arrow_rule_selected);
//       Bitmap bit2 = BitmapFactory.decodeResource(mContext.getResources(), R.drawable.arrow_normal);
//       bits = new Bitmap[]{bit,bit1,bit2};
//        
//    }
//    
//    
//    private void roTate(Matrix mas){
//        bith = new Bitmap[3];
//        for(int i = 0;i<3;i++){
//            Bitmap bi = Bitmap.createBitmap(bits[i],0, 0, bits[i].getWidth(), bits[i].getHeight(), mas,true);
//            bith[i]= bi;
//        }
//    }
//    
//    public void setDraxType(int type,boolean bool){
//        this.isDraw =bool;
//        
//        switch (type) {
//        case ORI_1:
//           mMatrix.setTranslate(0, 0);
//          ma.setRotate(315);
//          this.roTate(ma);
//            break;
//        case ORI_2:
//            mMatrix.setTranslate(Const.base_w/2-bits[0].getWidth()/2, 0);
//            ma.setRotate(0);
//            this.roTate(ma);
//            break;
//        case ORI_3:
//            mMatrix.setTranslate(Const.base_w-bits[0].getWidth(), 0);
//            ma.setRotate(45);
//            this.roTate(ma);
//            break;
//        case ORI_4:
//            mMatrix.setTranslate(Const.base_w-bits[0].getWidth(), Const.base_h/2-bits[0].getHeight()/2);
//            ma.setRotate(90);
//            this.roTate(ma);
//            
//            
//            break;
//        case ORI_5:
//            mMatrix.setTranslate(Const.base_w-bits[0].getWidth(), Const.base_h-bits[0].getHeight()-offer);
//            ma.setRotate(135);
//            this.roTate(ma);
//            break;
//        case ORI_6:
//            mMatrix.setTranslate(Const.base_w/2-bits[0].getWidth()/2, Const.base_h-bits[0].getHeight()-offer);
//            ma.setRotate(180);
//            this.roTate(ma);
//            break;
//        case ORI_7:
//            mMatrix.setTranslate(0, Const.base_h-bits[0].getHeight()-offer);
//            ma.setRotate(225);
//            this.roTate(ma);
//             break;
//       case ORI_8:
//           mMatrix.setTranslate(0, Const.base_h/2-bits[0].getHeight());
//           ma.setRotate(270);
//           this.roTate(ma);
//             break;
//    
//
//        default:
//            break;
//        }
//        
//    }
//    public void setPara(Canvas can){
//        this.canvas =can;
//
//    }
//
//    
//    @Override
//    public void run() {
//        super.run();
//        int a = 0;
//        int b = 0;
//        while(xc){
//             while(isDraw){
//                 if(b>=3){
//                     b=0;
//                 }
//                 if(canvas != null && bith[1] !=null ){
//                     try{
//                 canvas.drawBitmap(bith[b],mMatrix, pa);
//                     }catch(Exception e){
//                         e.printStackTrace();
//                     }
//                 }
//                 b++;
//                 v.postInvalidate();
//            try {
//                Thread.sleep(300);
//            } catch (InterruptedException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//         
//
//         }
//    }}}
