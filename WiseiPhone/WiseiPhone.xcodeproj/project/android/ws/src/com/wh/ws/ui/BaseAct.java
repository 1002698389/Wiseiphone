package com.wh.ws.ui;



import com.wh.ws.R;
import com.wh.ws.utill.UtillView;
import com.wh.ws.utill.UtillViewqx;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.Toast;

public class BaseAct extends Activity{
    private PopupWindow m_pw = null;
    private ImageButton[] ibs ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        DisplayMetrics dp = new DisplayMetrics();
        dp = getResources().getDisplayMetrics();
       // getWindowManager().getDefaultDisplay().getMetrics(dp);
     
        Const.WIGHT = dp.widthPixels;
        Const.HIGHT = dp.heightPixels;
        init_layout();
        
    }
    public void showNotice(String s){
        
        Toast.makeText(getApplicationContext(), s, 1).show();
        
    }
    
    private void init_layout() {
        View chooise_gn = LayoutInflater.from(getApplicationContext()).inflate(R.layout.dialog_choose, null);
       // chooise_gn.setVisibility(View.GONE);
        ImageButton ib_yl = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_yl);
        ImageButton ib_manager = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_vmanager);
        ImageButton ib_warminfo = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_warms);
        ImageButton ib_feel = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_feel);
        ImageButton ib_zn = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_zn);
        ImageButton ib_set = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_set);
        ImageButton ib_ivm = (ImageButton)chooise_gn.findViewById(R.id.dialog_ib_ivm);
       
        
         ibs = new ImageButton[]{ib_yl,ib_manager,ib_warminfo,ib_feel,ib_zn,ib_set};
        ib_yl.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                gotoActivity(MainActivity.class);
                
                
            }
        });
        
        ib_manager.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                gotoActivity(VideoManagerAct.class); // TODO Auto-generated method stub
            }
        });
        
        ib_warminfo.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                gotoActivity(WarnInfoAct.class);
              
            }
        });
        
        
        ib_feel.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
               gotoActivity(FeelAct.class);
            }
        });
        
        ib_zn.setOnClickListener(new OnClickListener() {
        
            @Override
            public void onClick(View v) {
                gotoActivity(MarktSetAct.class);
            }
        });
        
        ib_set.setOnClickListener(new OnClickListener() {
         
            @Override
            public void onClick(View v) {
                gotoActivity(SetAct.class);
            }
        });
        
     ib_ivm.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                gotoActivity(ImgOrVideoManagerAct.class); // TODO Auto-generated method stub
            }
        });
        m_pw = new PopupWindow(chooise_gn,Const.WIGHT,LayoutParams.WRAP_CONTENT);
        m_pw.setBackgroundDrawable(new BitmapDrawable());
        m_pw.setOutsideTouchable(true);
        m_pw.setFocusable(true);
        
    }
    
    public void restBtn(int b){
        for(int i=0;i<ibs.length;i++){
            if(i == b){
                ibs[i].setSelected(true);
            }else{
            ibs[i].setSelected(false);
            }
        }
    }
    
    private void gotoActivity(Class s){
        Intent i = new Intent();
        i.setClass(BaseAct.this, s);
        i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(i);
        if(m_pw != null){
            m_pw.dismiss();
        }
    }
    public PopupWindow  getPw(){
        
        return m_pw;
    }
    
    public UtillView getUtillview(){
        return  UtillView.getInstance(getApplicationContext());
    }
    public UtillViewqx getUtillviewqx(){
        return  UtillViewqx.getInstance(getApplicationContext());
    }
    
    public void des(){
        finish();
    }
  @Override
protected void onDestroy() {
      this.getUtillviewqx().clear();
    super.onDestroy();
}
}
