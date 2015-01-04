package com.wh.ws.utill;

import com.wh.ws.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.Toast;



public class UtillView implements OnClickListener {
    private static UtillView myUtill;
    private Context mContext;
    private static LayoutInflater mInflater;
    
    private LinearLayout mL;
    private LinearLayout mLayout;
    

    public UtillView(Context context) {
        this.mContext = context;
        mInflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    public static UtillView getInstance(Context context) {
        if (myUtill == null) {
            myUtill = new UtillView(context);
        }
        return myUtill;
    }

    public  View getMainButtom(){
        mLayout = (LinearLayout) mInflater.from(mContext).inflate(R.layout.item_contral, null);
        mL = (LinearLayout)mLayout.findViewById(R.id.item_contral_one);
        for(int i = 0;i<mL.getChildCount();i++){
            ((FrameLayout)mL.getChildAt(i)).getChildAt(0).setOnClickListener(this);
        }
        return mLayout;
    }
    
    public void rest(){
        for(int i = 0;i<mL.getChildCount();i++){
            mL.getChildAt(i).setSelected(false);
            ((FrameLayout)mL.getChildAt(i)).getChildAt(0).setSelected(false);
        }
    }
    
    
    @Override
    public void onClick(View arg0) {
        
        if(arg0 == ((FrameLayout)mL.getChildAt(0)).getChildAt(0)){
            rest();
            mL.getChildAt(0).setSelected(true);
            arg0.setSelected(true);
            mLayout.getChildAt(0).setVisibility(View.INVISIBLE);
            mLayout.getChildAt(1).setVisibility(View.GONE);
            mLayout.getChildAt(2).setVisibility(View.GONE);
            Toast.makeText(mContext, "Ë¢ÐÂ", 1).show();
        }else if(arg0 == ((FrameLayout)mL.getChildAt(1)).getChildAt(0)){
            rest();
            mL.getChildAt(1).setSelected(true);
            arg0.setSelected(true);
            mLayout.getChildAt(0).setVisibility(View.VISIBLE);
            mLayout.getChildAt(1).setVisibility(View.GONE);
            mLayout.getChildAt(2).setVisibility(View.GONE);
        }else if(arg0 == ((FrameLayout)mL.getChildAt(2)).getChildAt(0)){
            rest();
            mL.getChildAt(2).setSelected(true);
            arg0.setSelected(true);
            mLayout.getChildAt(0).setVisibility(View.GONE);
            mLayout.getChildAt(1).setVisibility(View.VISIBLE);
            mLayout.getChildAt(2).setVisibility(View.GONE);
        }else if(arg0 == ((FrameLayout)mL.getChildAt(3)).getChildAt(0)){
            rest();
            mL.getChildAt(3).setSelected(true);
            arg0.setSelected(true);
            mLayout.getChildAt(0).setVisibility(View.GONE);
            mLayout.getChildAt(1).setVisibility(View.GONE);
            mLayout.getChildAt(2).setVisibility(View.VISIBLE);
        }else if(arg0 == ((FrameLayout)mL.getChildAt(4)).getChildAt(0)){
            rest();
            mL.getChildAt(4).setSelected(true);
            arg0.setSelected(true);
            mLayout.getChildAt(0).setVisibility(View.INVISIBLE);
            mLayout.getChildAt(1).setVisibility(View.GONE);
            mLayout.getChildAt(2).setVisibility(View.GONE);
            Toast.makeText(mContext, "Ô¤ÖÃ", 1).show();
        }
    }


}
