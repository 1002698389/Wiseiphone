package com.wh.ws.ui;



import com.wh.ws.R;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.widget.Toast;

public class MyDialog extends Dialog {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dialog_choose);

    }

    public MyDialog(Context context) {
        super(context);

        // TODO Auto-generated constructor stub
    }

    public MyDialog(Context context, boolean cancelable, OnCancelListener cancelListener) {
        super(context, cancelable, cancelListener);
        // TODO Auto-generated constructor stub
    }

    public MyDialog(Context context, int theme) {
        super(context, theme);
        // TODO Auto-generated constructor stub
    }

    public void setPos() {

        WindowManager.LayoutParams wind = this.getWindow().getAttributes();
        wind.width = Const.WIGHT+100;
        wind.height = LayoutParams.WRAP_CONTENT ;
        Toast.makeText(getContext(), ""+Const.WIGHT +"  "+Const.HIGHT, 1).show();
        this.getWindow().setAttributes(wind);
    }

    public void showd() {
        Window w = this.getWindow();
        LayoutParams la = new LayoutParams();
       //w.setGravity(Gravity.LEFT | Gravity.TOP);
       // w.setLayout(Const.WIGHT, Const.HIGHT);
        la.y = 1000;
        la.x = 20 ;
        w.setAttributes(la);
        this.setCanceledOnTouchOutside(true);
        
        this.show();
        setPos();
    }

}
