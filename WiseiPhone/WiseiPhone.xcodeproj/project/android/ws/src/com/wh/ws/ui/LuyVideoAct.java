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

public class LuyVideoAct extends BaseAct implements OnClickListener {
   private  LinearLayout mLitem = null;
   private Button mbtn =null;
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_luy_video);
        Intent in = getIntent();
         Bundle bun = in.getExtras();
         
        init_title(R.drawable.img_title_left, "Â¼Ïñ²¥·Å", R.drawable.img_titile_back);
        init();
        
    }
    
    private void init(){
        mLitem = (LinearLayout)findViewById(R.id.video_contral_item);
        for(int i =0;i<mLitem.getChildCount();i++){
            
            mLitem.getChildAt(i).setOnClickListener(this);
            
        }
        
    }
    
    

    
    
    private void init_title(int id, String name, int id1) {

        //ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView  title_tv = (TextView) findViewById(R.id.title_tv_center);

      //  title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);

//        title_left.setOnClickListener(new OnClickListener() {
//            
//            @Override
//            public void onClick(View arg0) {
//                if(!getPw().isShowing()){
//                    getPw().showAsDropDown(arg0, 0, 0);
//                }else{
//                    getPw().dismiss();
//                }
//                
//            }
//        });
        title_right.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                LuyVideoAct.this.finish();
                
            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View v) {
      if(v == mLitem.getChildAt(0)){
      }else if(v == mLitem.getChildAt(1)){
      }else if(v== mLitem.getChildAt(2)){
          if(v.isSelected()){
              v.setSelected(false);
          }else{
              v.setSelected(true);
          }
          
      }else if(v== mLitem.getChildAt(3)){
          if(v.isSelected()){
              v.setSelected(false);
          }else{
              v.setSelected(true);
          }
      }else if(v== mLitem.getChildAt(4)){
          if(v.isSelected()){
              v.setSelected(false);
          }else{
              v.setSelected(true);
          }
      }
        
        
        
        
    }

    
    
    
    
}
