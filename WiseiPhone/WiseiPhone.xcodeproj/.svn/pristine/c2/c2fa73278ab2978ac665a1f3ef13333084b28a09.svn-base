package com.wh.ws.ui;

import com.wh.ws.R;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.Toast;

public class MyLiner extends LinearLayout {
    private BaseFragmentManager bt;

    public MyLiner(Context context) {
        super(context);
        init();
        // TODO Auto-generated constructor stub

    }

    public MyLiner(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init();
        // TODO Auto-generated constructor stub
    }

    public MyLiner(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
        // TODO Auto-generated constructor stub
    }

    private void init() {

    }

    @Override
    public void setSelected(boolean selected) {
        // TODO Auto-generated method stub
        if (selected == true) {
            bt = (BaseFragmentManager) getParent();
            bt.clearSelected();
            this.getChildAt(0).setSelected(true);
        }

        super.setSelected(selected);

    }

    private void BtnDown() {

    }

    @SuppressLint("WrongCall")
    private void DoubleClick() {

        bt.isFullScreen = true;
        bt.onMeasure(MeasureSpec.makeMeasureSpec(Const.base_w, MeasureSpec.EXACTLY),
                MeasureSpec.makeMeasureSpec(Const.base_h, MeasureSpec.EXACTLY));
        bt.onLayout(true, 0, 0, 0, 0);
    }

    private int clickcount = 0;
    private long firClick;
    private long secClick;

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        // TODO Auto-generated method stub
    

        if (event.getAction() == MotionEvent.ACTION_DOWN) {// Èç¹ûµã»÷
            BtnDown();
            this.setSelected(true);
         
        } else if (event.getAction() == MotionEvent.ACTION_UP) {

            clickcount++;
            if (clickcount == 1) {
                firClick = System.currentTimeMillis();
            } else if (clickcount == 2) {
                secClick = System.currentTimeMillis();
                if (secClick - firClick < 1000) {
                    if (BaseFragmentManager.isFullScreen) {
                        return false;
                    }
                    DoubleClick();
                }
                clickcount = 0;
                firClick = 0;
                secClick = 0;
            }

        }
        return true;
    }

    
    
    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {
    //   if(this.isSelected() && this.getChildAt(0))
        if(bt !=null ){
            if(this.isSelected()){
                View v = bt.getSelcted();
                ImageButton ib = (ImageButton)v.findViewById(R.id.fgt_ib_add);
                if(ib.getVisibility()==View.VISIBLE){
                    return false;
                }
                
            }else{
                return true;
            }
        }
        if (!BaseFragmentManager.isButton)
            return false;
        
        if (this.isSelected()) {
            return true;
        } else if (BaseFragmentManager.isFullScreen) {
            return false;
        }
        return true;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        // this.getChildAt(0).measure(widthMeasureSpec, heightMeasureSpec);
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
    }
}
