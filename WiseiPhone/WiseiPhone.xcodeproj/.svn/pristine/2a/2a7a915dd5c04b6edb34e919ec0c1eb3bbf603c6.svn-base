package com.wh.ws.ui;

import com.wh.ws.R;

import android.annotation.SuppressLint;
import android.app.Fragment;
import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.MeasureSpec;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Scroller;
import android.widget.Toast;


public class BaseFragmentManager extends RelativeLayout {
    public int curS;
    private int w;
    private int h;
    public static boolean isFullScreen;
    public static boolean isButton =true;
    public boolean isContral;
    private int currentPage = 0;
    private Scroller mScro;
    private static final int spend = 600;
    private VelocityTracker mVt;
    private OnPageScroller op;
    

    public BaseFragmentManager(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        // TODO Auto-generated constructor stub
        initView();
    }
    
    public BaseFragmentManager(Context context, AttributeSet attrs) {
        super(context, attrs);
        // TODO Auto-generated constructor stub
        initView();
    }

    public BaseFragmentManager(Context context) {
        super(context);
        // TODO Auto-generated constructor stub
        initView();
    }

    private void initView() {
        isButton =true;
        mScro = new Scroller(getContext());

        isFullScreen = false;
        curS = 4;
        MyLiner ll;
        this.removeAllViews();
        if (curS == Const.JK_1S) {

            this.removeAllViews();
            ll = new MyLiner(getContext());
            ll.setBackgroundColor(Color.WHITE);
            ll.setId(1111);
            this.addView(ll);
        }
        if(curS == Const.JK_4S){
            for (int i = 0; i < 4; i++) {
                ll = new MyLiner(getContext());
                ll.setBackgroundColor(Color.WHITE);
                ll.setId(1111 + i);
                this.addView(ll);
            }
            
            
        }

   

    }





    @Override
    protected void onLayout(boolean arg0, int arg1, int arg2, int arg3, int arg4) {
        // TODO Auto-generated method stub
        if (curS == Const.JK_1S) {
            getChildAt(0).layout(0, 0, w, h);
        } else if (curS == Const.JK_4S) {
            if (!isFullScreen) {
                if(isContral){
                    
                    
                }
                getChildAt(0).layout(0, 0, w / 2, h / 2);
                getChildAt(1).layout(w / 2, 0, w, h / 2);
                getChildAt(2).layout(0, h / 2, w / 2, h);
                getChildAt(3).layout(w / 2, h / 2, w, h);
            } else if (isFullScreen) {
                int cd = 0;
                int ww = w;

                for (int i = 0; i < 4; i++) {
                    if(getChildAt(i).isSelected()){
                        getChildAt(i).layout(cd, 0, ww + cd, h);
                        scrollTo(i*w, 0);
                        this.currentPage=i;
                    }else{
                        getChildAt(i).layout(cd, 0, ww + cd, h);
                    }
                    cd += w;
                    ww += w;
                }

            }

        }
        if(BaseFragmentManager.isFullScreen){
            Const.SCROOL = true;
        }
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        // TODO Auto-generated method stub
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
       Const.base_w=w = MeasureSpec.getSize(widthMeasureSpec);
       Const.base_h= h = MeasureSpec.getSize(heightMeasureSpec);
        if (curS == Const.JK_1S) {
          //  getChildAt(0).getLocationInWindow(location)
            getChildAt(0).measure(MeasureSpec.makeMeasureSpec(w, MeasureSpec.EXACTLY),
                    MeasureSpec.makeMeasureSpec(h, MeasureSpec.EXACTLY));

        } else if (curS == Const.JK_4S)
            if (!isFullScreen) {
            
                    for (int i = 0; i < getChildCount(); i++) {
                        getChildAt(i).measure(MeasureSpec.makeMeasureSpec(w / 2, MeasureSpec.EXACTLY),
                                MeasureSpec.makeMeasureSpec(h / 2, MeasureSpec.EXACTLY));
                  
                }
                
            } else {
                for (int i = 0; i < getChildCount(); i++) {
                    getChildAt(i).measure(MeasureSpec.makeMeasureSpec(w, MeasureSpec.EXACTLY),
                            MeasureSpec.makeMeasureSpec(h, MeasureSpec.EXACTLY));
                }
            }

        // getChildAt(0).measure(500, 500);

    }

   private int endx;
   private int starx;
   private int ori;
   private int offer;
   private int ostarx;
   private int clickcount=0;
   private long firClick;
   private long secClick;

    @Override
    public boolean onTouchEvent(MotionEvent event) {

        if (mScro.computeScrollOffset()) {
            return false;
        }
       if(!isFullScreen){
           return false;
       } 
       
        switch (event.getAction()) {
        case MotionEvent.ACTION_DOWN:
            BtnDown();
            clickcount++;
            if (clickcount == 1) {
                firClick = System.currentTimeMillis();
            } else if (clickcount == 2) {
                secClick = System.currentTimeMillis();
                if (secClick - firClick < 500) {
                    if(BaseFragmentManager.isFullScreen){
                        DoubleClick();
                    }
                }
                clickcount = 0;
                firClick = 0;
                secClick = 0;
            }
            if (mVt == null) {
                mVt = VelocityTracker.obtain();
         
            } else {

                mVt.clear();
            }
            mVt.addMovement(event);
     
            starx = (int) event.getX();
            ostarx = (int) event.getX();
            break;
        case MotionEvent.ACTION_MOVE:
            mVt.addMovement(event);
            endx = (int) event.getX();

            offer = Math.abs(endx - starx);
            if (endx - starx < 0) {
                this.scrollBy(offer, 0);

                starx = endx;

            } else if (endx - starx > 0) {
                this.scrollBy(-offer, 0);
                starx = endx;
            }
            if (mVt == null) {
                return false;
            }
           

            break;
        case MotionEvent.ACTION_UP:
           
          
            endx = (int) event.getX();
            offer = Math.abs(endx - ostarx);
            if(endx-ostarx>0){
                ori =1;
            }else{
                ori =-1;
            }
            
            mVt.computeCurrentVelocity(1000);
            int v = (int) mVt.getXVelocity();
            System.out.println(v+"   q");
            if ((offer >= w / 2 || spend < Math.abs(v)) && isCanMove(ori, 4)) {
                scrolOffer(currentPage, w - offer, ori);
            } else {
                if (ori < 0) {
                    mScro.startScroll(this.getScrollX(), 0, -offer, 0, offer * 2);
                    invalidate();
                } else if (ori > 0) {
                    mScro.startScroll(this.getScrollX(), 0, offer, 0, offer * 2);
                    invalidate();
                }
            }
            if (mVt != null) {
                mVt.recycle();
                mVt = null;
            }
            break;
        default:
            break;
        }

        return true;
    }

    private void BtnDown(){
      
    }
    
    @SuppressLint("WrongCall")
    private void DoubleClick(){
        Toast.makeText(getContext(), "a", 1).show();
        if(BaseFragmentManager.isFullScreen){
            BaseFragmentManager.isFullScreen =false;
            this.onMeasure(MeasureSpec.makeMeasureSpec(w, MeasureSpec.EXACTLY),
                    MeasureSpec.makeMeasureSpec(h, MeasureSpec.EXACTLY));
            this.onLayout(false, 0, 0, w, h);
            this.scrollTo(0,0);
        }
    }
    
    private boolean isCanMove(int or, int pageCount) {
        if (or < 0 && currentPage != pageCount - 1)
            return true;
        else if (or > 0 && currentPage != 0)
            return true;
        else
            return false;

    }

    private void scrolOffer(int cur, int value, int oris) {

        if (oris < 0) {

            mScro.startScroll(this.getScrollX(), 0, value, 0, value);
            currentPage += 1;
            if(op !=  null){
                this.clearSelected();
                op.pageScroller(((MyLiner)getChildAt(currentPage)).getChildAt(0), currentPage);
            }

        } else if (oris > 0 && currentPage < 4 && currentPage >= 0) {

            mScro.startScroll(this.getScrollX(), 0, -value, 0, value);
            currentPage -= 1;
            if(op !=  null){
                this.clearSelected();
                op.pageScroller(((MyLiner)getChildAt(currentPage)).getChildAt(0), currentPage);
            }

        }

        invalidate();
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {

        if(!isButton)
            return false;
                    
        if (isFullScreen && Const.SCROOL) {

            return true;
        }
            
            
       
     
       return false;
    }

    @Override
    public void computeScroll() {
        if (mScro.computeScrollOffset()) {
            scrollTo(mScro.getCurrX(), mScro.getCurrY());
            postInvalidate();
        }

        super.computeScroll();
    }
    
    //其他类的公用方法
    public void setPageScroller(OnPageScroller on)
    {
        this.op = on;
        
    }
    public int getCurPage(){
        return currentPage;
    }
    public View getSelcted() {
        for (int i = 0; i < getChildCount(); i++) {
            View v = ((MyLiner) getChildAt(i)).getChildAt(0);
            if (v.isSelected()) {
                return v;
            }
        }
        return null;

    }
    
    public DrawX getDrawX(){
        
       return  (DrawX)getSelcted().findViewById(R.id.fgt_drawx);
        
    }
    public void clearSelected() {

        for (int i = 0; i < getChildCount(); i++) {
            ((MyLiner)getChildAt(i)).getChildAt(0).setSelected(false);
            getChildAt(i).setSelected(false);
        }
    }

    public void updateLayout(){
        if(isContral){
            
            for(int i = 0;i<getChildCount();i++){
                MyLiner my =(MyLiner)getChildAt(i);
                if(my.isSelected()){
                   my.measure(MeasureSpec.makeMeasureSpec(w, MeasureSpec.EXACTLY),
                           MeasureSpec.makeMeasureSpec(h, MeasureSpec.EXACTLY));
                  my.layout(0, 0, w, h);
                }else{
                    my.layout(0, 0, 0, 0);
                }
            }
        }
    }
    
    
    public int getSelectedIndex(){
     
        
        for(int i =0;i<this.getChildCount();i++){
            if(this.getChildAt(i).isSelected()){
                return i;
            }
            
        }
        
        return -1;
    }
    @SuppressLint("WrongCall")
    public void isFull(boolean bool){
        if(bool){
          this.isContral= true;
          this.isButton = false;
          this.updateLayout();
        }else{
            ((MyLiner)this.getSelcted().getParent()).measure(MeasureSpec.makeMeasureSpec(w / 2, MeasureSpec.EXACTLY),
                    MeasureSpec.makeMeasureSpec(h / 2, MeasureSpec.EXACTLY));
            this.onLayout(false, 0, 0, w, h);
            this.isButton = true;
        }
   
    }
}

 interface OnPageScroller{
     
     void pageScroller(View v , int curPage);
     
     
 }
