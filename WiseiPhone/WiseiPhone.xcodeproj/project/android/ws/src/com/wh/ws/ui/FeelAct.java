package com.wh.ws.ui;

import com.wh.ws.R;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class FeelAct extends BaseAct implements OnClickListener {
   private  LinearLayout mLitem = null;
   private Button mbtn =null;
   private String[] item =null;
   private int mCurrenSelected = -1;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_feel);
        item = new String[]{"ÍµµÁ¼à²â1","ÍµµÁ¼à²â2","ÍµµÁ¼à²â3","ÑÌ»ð¼à²â","ÒÅÁô¼à²â","×Ô¶¯×·×Ù ","ÅÇ»²¼à²â","ÈËÔ±¼¼¼ÆÊý"};
        init_title(R.drawable.img_title_left, "ÓÃ»§ÌåÑé", R.drawable.img_titile_back);
        init();
        
    }
    
    private void init(){
        restBtn(3);
        mLitem = (LinearLayout)findViewById(R.id.act_feel_item);
        mbtn = (Button)findViewById(R.id.act_feel_btn);
        mbtn.setOnClickListener(this);
        for(int i =0;i<mLitem.getChildCount();i++){
            
            mLitem.getChildAt(i).setOnClickListener(this);
            
        }
        
    }
    
    
   private void rest(View v){
       for(int i =0;i<mLitem.getChildCount();i++){
           mLitem.getChildAt(i).setSelected(false);
           ((RelativeLayout)mLitem.getChildAt(i)).getChildAt(2).setSelected(false);
       }
       v.setSelected(true);
       ((RelativeLayout)v).getChildAt(2).setSelected(true);
   }
    
    
    private void init_title(int id, String name, int id1) {

        ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView  title_tv = (TextView) findViewById(R.id.title_tv_center);

        title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);

        title_left.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View arg0) {
                if(!getPw().isShowing()){
                    getPw().showAsDropDown(arg0, 0, 0);
                }else{
                    getPw().dismiss();
                }
                
            }
        });
        title_right.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                FeelAct.this.finish();
                
            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View v) {
      if(v == mLitem.getChildAt(0)){
          rest(v);
          mCurrenSelected = 0;
      }else if(v == mLitem.getChildAt(1)){
          rest(v); 
          mCurrenSelected = 1;
      }else if(v== mLitem.getChildAt(2)){
          rest(v); 
          mCurrenSelected = 2;
      }else if(v== mLitem.getChildAt(3)){
          rest(v); 
          mCurrenSelected = 3;
      }else if(v== mLitem.getChildAt(4)){
          rest(v); 
          mCurrenSelected = 4;
      }else if(v== mLitem.getChildAt(5)){
          rest(v); 
          mCurrenSelected = 5;
      }else if(v== mLitem.getChildAt(6)){
          rest(v); 
          mCurrenSelected = 6;
      }else if(v== mLitem.getChildAt(7)){
          rest(v); 
          mCurrenSelected = 7;
      }else if(v == mbtn){
          if(mCurrenSelected<0){
              return;
          }
          Intent in = new Intent();
          in.setClass(FeelAct.this, FeelVideoAct.class);
          Bundle b = new Bundle();
          b.putString("name", item[mCurrenSelected]);
          in.putExtras(b);
          startActivity(in);
      }
        
        
        
        
    }

    
    
    
    
}
