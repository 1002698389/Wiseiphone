package com.wh.ws.utill;

import com.wh.ws.R;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Matrix;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Transformation;
import android.webkit.WebView.FindListener;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.LinearLayout;
import android.widget.Toast;



public class UtillViewqx implements OnClickListener {
    private static UtillViewqx myUtill;
    private Context mContext;
    private static LayoutInflater mInflater;
    
    private LinearLayout mL;
    private LinearLayout mLayout;
    
    private ImageView iv ;
    Matrix ma;
     

    public UtillViewqx(Context context) {
        this.mContext = context;
        mInflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }
    public void clear(){
        
        myUtill = null;
    }

    public static UtillViewqx getInstance(Context context) {
        if (myUtill == null) {
            myUtill = new UtillViewqx(context);
        }
        return myUtill;
    }

    public  View getQx(){
        mLayout = (LinearLayout) mInflater.from(mContext).inflate(R.layout.item_qx, null);
        mL = (LinearLayout)mLayout.findViewById(R.id.item_qx_qxs);
        

        ma = new Matrix();
        for(int i = 0;i<mL.getChildCount();i++){
          mL.getChildAt(i).setOnClickListener(this);
        }
        return mLayout;
    }
    
    public void rest(){
        for(int i = 0;i<mL.getChildCount();i++){
            mL.getChildAt(i).setSelected(false);
            ((Button)mL.getChildAt(i)).setTextColor(Color.BLACK);
        }
    }
    
    int i = 0;
    @SuppressLint("ResourceAsColor")
    @Override
    public void onClick(View arg0) {
       if(arg0 == mL.getChildAt(0)){
           rest();
           arg0.setSelected(true);
           ((Button)arg0).setTextColor(Color.WHITE);
//           iv.bringToFront();
//           iv.layout(0, 600+i, 1000, 800+i);
//           
//            ma.postTranslate(i,-10);
//            
//               i+=10;
//           
//           iv.setImageMatrix(ma);
//          
//       
//     
//        arg0.layout(20, 20,200,400);
//        
//        arg0.bringToFront();
        
           
       } else if(arg0 == mL.getChildAt(1)){
           rest();
           arg0.setSelected(true);
           ((Button)arg0).setTextColor(Color.WHITE);
       
       } else if(arg0 == mL.getChildAt(2)){
           rest();
           arg0.setSelected(true);
           ((Button)arg0).setTextColor(Color.WHITE);
       }
       else if(arg0 == mL.getChildAt(3)){
           rest();
           arg0.setSelected(true);
           ((Button)arg0).setTextColor(Color.WHITE);
       
       }
       
    }


}
