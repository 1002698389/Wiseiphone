package com.wh.ws.ui;

import java.text.SimpleDateFormat;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Paint.Style;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Toast;

import com.wh.ws.R;

public class MySeekBar extends View {
   
    private OnTouchSeekBar ont;
    private int hight = 185;
    private int width = 880;
    private int eachW = 880 / 6;
    private int avgHight = (hight - 5) / 4;
    private int d1 = avgHight * 3;
    private int d2 = 5;
    private int d3 = avgHight;
    private Paint p;
    private Canvas canvas;
    private float x;

    private String time;

    private int max = 100;
    private long firstTime;
    private long lastTime;
    private long timeC;
    private SimpleDateFormat timeCFromat;
    private SimpleDateFormat sl;

    // 该变量记录每移动一个单位像素。走过多少时间
    private int avgPixForTime;

    public void setFirstTime(Long f) {
        this.firstTime = f;
    }

    public void setLastTime(Long f1) {

        this.lastTime = f1;
    }

    public void prepar() {
        timeCFromat = new SimpleDateFormat("hh:mm");
        sl = new SimpleDateFormat("yyyy-MM-dd  hh-mm-ss");
        time = sl.format(firstTime);
        timeC = (lastTime - firstTime) / 6;
        int avg = (int) ((lastTime - firstTime) / 1000 / width);
        avgPixForTime = avg;

    }

    public void moni() {
        this.setFirstTime(System.currentTimeMillis() - 30 * 60 * 1000);
        this.setLastTime(System.currentTimeMillis());
    }

    private String getTitleTime(float x) {

       

        return sl.format(firstTime + ((long) (x * avgPixForTime)) * 1000l);

    }

    public MySeekBar(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        getPaint();
    }

    public MySeekBar(Context context, AttributeSet attrs) {
        super(context, attrs);
        // TODO Auto-generated constructor stub

        getPaint();
    }

    public MySeekBar(Context context) {
        super(context);
        getPaint();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        // TODO Auto-generated method stub
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        this.hight = MeasureSpec.getSize(widthMeasureSpec);
      
    }

    
    
    
    
    
    
    
    
    
    
    private void getPaint() {
        canvas = new Canvas();
        p = new Paint();
        p.setAntiAlias(true);
        p.setColor(Color.RED);
        p.setStyle(Style.FILL);
        Log.d(this.getHeight() + "    ", this.getWidth() + "   ");

        this.moni();
        this.prepar();
        this.seekTo(1000000);

    }

    private Paint getPaint(int r) {

        p.setColor(getResources().getColor(r));

        return p;

    }

    private Paint g(int rgb) {
        p.setColor(rgb);
        p.setStrokeWidth(3);
        return p;
    }

    private Paint getTExtPaint() {
        p.setTextSize(20);
        p.setTextAlign(Align.CENTER);
        p.setColor(getResources().getColor(R.color.la_4));

        return p;
    }
    private Paint getRTExtPaint() {
        p.setTextSize(40);
        p.setTextAlign(Align.CENTER);
        p.setColor(Color.WHITE);

        return p;
    }

    private void DrawButtomTime(Canvas canvas) {
        p.setTextSize(20);
        p.setColor(Color.WHITE);

        for (int i = 0; i < 6; i++) {
            String s1 = timeCFromat.format(firstTime + i * timeC);
            canvas.drawText(s1, i * eachW + 40, d1 + d2 - 10 + 25, p);

        }

    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        // TODO Auto-generated method stub

        super.onSizeChanged(w, h, oldw, oldh);
        Toast.makeText(getContext(), h+" ", 1).show();
     
    }

    @Override
    protected void onDraw(Canvas canvas) {
        // TODO Auto-generated method stub
        super.onDraw(canvas);
       
        canvas.drawRect(0, 0, Const.base_w, d1, getPaint(R.color.la_1));
        canvas.drawText(getTitleTime(x), width / 2+50, 60, getRTExtPaint());
      
        canvas.drawRect(0, d1 - 10, Const.base_w, d1 + d2 - 10, getPaint(R.color.la_2));
        canvas.drawRect(0, d1 + d2 - 10, Const.base_w, d1 + d2 + d3, getPaint(R.color.la_3));
        // canvas.drawText("欢迎使用这个空间", 0, 20, new Paint());
        canvas.drawLine(x, 0, x, hight, getTExtPaint());
        DrawButtomTime(canvas);
 
    }

    // private float x,x1,;
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        // TODO Auto-generated method stub

        switch (event.getAction()) {
        case MotionEvent.ACTION_DOWN:
            x = event.getX();
            canvas.drawLine(x, 0, x, hight, g(Color.RED));
            DrawButtomTime(canvas);
            invalidate();
            if(null != ont){
            ont.touchSeekBar((long)x*1000*avgPixForTime);
            }
            break;
        case MotionEvent.ACTION_MOVE:
            x = event.getX();
            canvas.drawLine(x, 0, x, hight, g(Color.RED));
            canvas.drawText(getTitleTime(x), width / 2, 2, getTExtPaint());
            invalidate();
            break;
        case MotionEvent.ACTION_UP:
            break;
        default:
            break;
        }
        return true;
    }
    
    public void setOnTouchSeekBar (OnTouchSeekBar on){
        this.ont = on;
        
    }
    public void seekTo(long l){
       
        x = (int) (l/1000l/((long)avgPixForTime));
        canvas.drawText(sl.format(firstTime+l), width / 2, 2, getTExtPaint());
        canvas.drawLine(x, 0, x, hight, g(Color.RED));
        invalidate();
        
    }
    public interface OnTouchSeekBar{
        
        void touchSeekBar(long f);
        
        
    }
    
    
}
