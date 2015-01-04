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

public class DvdMangerAct extends BaseAct implements OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_dvd);
        init_title(R.drawable.img_title_left, "…Ë±∏", R.drawable.img_titile_back);
        init();
        
    }
    
    private void init(){
   
        
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
                DvdMangerAct.this.finish();
                
            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View v) {
        // TODO Auto-generated method stub
        
    }
}


