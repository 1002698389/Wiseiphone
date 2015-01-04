package com.wh.ws.ui;

import java.util.ArrayList;

import android.R.interpolator;
import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.ScaleAnimation;
import android.widget.Toast;

import com.wh.ws.R;

public class DrawX extends View {

    public static final int DRAW_TYPE_LINE = 0;
    public static final int DRAW_TYPE_DLINE = 1;
    public static final int DRAW_TYPE_RECT = 2;
    public static final int DRAW_TYPE_LRREGULAR = 3;
    public boolean isrun;
    public boolean isfu = false;
    // 画双线
    private float mov_tx1 = 0, mov_ty1 = 0, mov_tx2 = 0, mov_ty2 = 0;
    private boolean lineSuccess = false;
    public int type = 0;//

    private Paint paint;
    public Canvas canvas;
    // private Bitmap bitmap;//位图
    private int ViewWidth = 10;
    private int ViewHeight = 10;
    private float mov_x1 = 0, mov_y1 = 0, mov_x2 = 0, mov_y2 = 0;
    private long clickcount = 0, firClick = 0, secClick = 0;
    private boolean bScale = false;
    private DrawX thisView;
    public int nDrawType = 0;

    private PointManger pm;

    Bitmap bit = null;

    // DrawOri drawori = null;

    public DrawX(Context context) {
        super(context);

        InitView();

    }

    public DrawX(Context context, AttributeSet paramAttributeSet) {
        super(context, paramAttributeSet);
        InitView();
    }

    public DrawX(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        // TODO Auto-generated constructor stub
        InitView();
    }

    //
    // public void setDrawOri(DrawOri dor){
    // this.drawori = dor;
    // drawori.setOne(getContext(), 1, this);
    //
    //
    // }
    public int setDrawType(int n) {
        if (n == 1 || n == 9) {
            this.nDrawType = 0;
        } else if (n == 2) {
            this.nDrawType = 1;
        } else if (n == 3 || n == 4) {

            this.nDrawType = 3;
        } else {
            this.nDrawType = 2;
        }
        return nDrawType;
    }

    // @Override
    // protected void onLayout(boolean changed, int left, int top, int right,
    // int bottom) {
    // // TODO Auto-generated method stub
    // super.onLayout(changed, left, top, right, bottom);
    // GridLayout gl = (GridLayout)getRootView().findViewById(R.id.gridLayout);
    // if(gl.bMaxGrid){
    // // ScaleAnimation s = new ScaleAnimation(0.5f,1f,0.5f,1f);
    // // s.setDuration(0);
    // // s.setFillAfter(true);
    // // this.startAnimation(s);
    // this.clearAnimation();
    //
    //
    //
    // }else{
    // ScaleAnimation s = new ScaleAnimation(1.5f,1f,1f,1f);
    // s.setDuration(0);
    // s.setFillAfter(true);
    // this.startAnimation(s);
    // invalidate();
    //
    // }

    public String positionSave() {
        StringBuffer sb = new StringBuffer();
        switch (nDrawType) {
        case DRAW_TYPE_LINE:
            sb.append(mov_x1).append(",").append(mov_y1).append(",").append(mov_x2).append(",").append(mov_y2);

            break;
        case DRAW_TYPE_DLINE:
            sb.append(mov_x1).append(",").append(mov_y1).append(",").append(mov_x2).append(",").append(mov_y2)
                    .append(",");
            sb.append(mov_tx1).append(",").append(mov_ty1).append(",").append(mov_tx2).append(",").append(mov_ty2);

            break;
        case DRAW_TYPE_RECT:
            sb.append(mov_x1).append(",").append(mov_y1).append(",").append(mov_x2).append(",").append(mov_y2)
                    .append(",");

            break;
        case DRAW_TYPE_LRREGULAR:
            ArrayList<Point> mm = pm.getArray();
            for (int i = 0; i < mm.size(); i++) {
                if (i == mm.size() - 1)
                    sb.append(mm.get(i).x).append(",").append(mm.get(i).y);
                else
                    sb.append(mm.get(i).x).append(",").append(mm.get(i).y).append(",");
            }
            break;
        }

        return sb.toString();
    }

    public void positionDraw(String s, int tag) {
        nDrawType = setDrawType(tag);
        String[] ss = s.split(",");
        switch (tag) {
        case DRAW_TYPE_LINE:
            mov_x1 = Float.parseFloat(ss[0]);
            mov_y1 = Float.parseFloat(ss[1]);
            mov_x2 = Float.parseFloat(ss[2]);
            mov_y2 = Float.parseFloat(ss[3]);
            canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
            invalidate();
            break;
        case DRAW_TYPE_DLINE:
            mov_x1 = Float.parseFloat(ss[0]);
            mov_y1 = Float.parseFloat(ss[1]);
            mov_x2 = Float.parseFloat(ss[2]);
            mov_y2 = Float.parseFloat(ss[3]);

            mov_tx1 = Float.parseFloat(ss[4]);
            mov_ty1 = Float.parseFloat(ss[5]);
            mov_tx2 = Float.parseFloat(ss[6]);
            mov_ty2 = Float.parseFloat(ss[7]);

            canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
            canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);
            invalidate();
            break;
        case DRAW_TYPE_RECT:

            mov_x1 = Float.parseFloat(ss[0]);
            mov_y1 = Float.parseFloat(ss[1]);
            mov_x2 = Float.parseFloat(ss[2]);
            mov_y2 = Float.parseFloat(ss[3]);
            canvas.drawRect(mov_x1, mov_y1, mov_x2, mov_y2, paint);
            invalidate();
            break;
        case DRAW_TYPE_LRREGULAR:
            pm.clear();
            for (int i = 0; i < ss.length; i++) {
                if (i % 2 == 1) {
                    pm.addPoint(new Point((int)Float.parseFloat(ss[i - 1]), (int)Float.parseFloat(ss[i])));
                }
            }
            pm.draw(canvas, paint);
            invalidate();

            break;
        }
    }

    public void init() {
        Toast.makeText(getContext(), mov_ty2 + "dianla", 0).show();
        mov_x1 = mov_x2 = 0;
        mov_y1 = mov_y2 = 0;
        mov_tx1 = mov_tx2 = 0;
        mov_ty1 = mov_ty2 = 0;
        pm.clear();
        canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
        canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);
        if (lineSuccess) {
            lineSuccess = false;
        }
        invalidate();

    }

    private void InitView() {
        thisView = this;
        paint = new Paint(Paint.DITHER_FLAG);// 创建一个画笔
        // bitmap = Bitmap.createBitmap(ViewWidth, ViewHeight,
        // Bitmap.Config.ARGB_8888); //设置位图的宽高
        canvas = new Canvas();
        // canvas.setBitmap(bitmap);

        paint.setStyle(Style.STROKE);// 设置非填充
        paint.setStrokeWidth(3);// 笔宽5像素
        paint.setColor(Color.RED);// 设置为红笔
        paint.setAntiAlias(true);// 锯齿不显示
        if (pm == null) {
            pm = new PointManger();
        }

    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        ViewWidth = w;
        ViewHeight = h;
        // Toast.makeText(getContext(), w+""+h, 1).show();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        // TODO Auto-generated method stub
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        setMeasuredDimension(Const.base_w, Const.base_h);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        // if(drawori !=null && isrun){
        // drawori.setPara(canvas);
        // drawori.setDraxType(DrawOri.ORI_7,drawori.isDraw);
        // drawori.star();
        // }

        if (nDrawType == DrawX.DRAW_TYPE_LINE) {
            canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);

        } else if (nDrawType == DrawX.DRAW_TYPE_DLINE) {
            canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
            canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);

        } else if (nDrawType == DrawX.DRAW_TYPE_RECT) {

            canvas.drawRect(mov_x1, mov_y1, mov_x2, mov_y2, paint);
        } else if (nDrawType == DrawX.DRAW_TYPE_LRREGULAR) {
            pm.draw(canvas, paint);
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (type == 0)
            return false;

        if (event.getAction() == MotionEvent.ACTION_MOVE) {// 如果拖动
            if (nDrawType == DrawX.DRAW_TYPE_LINE) {
                mov_x2 = (int) event.getX();
                mov_y2 = (int) event.getY();
                canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);

            } else if (nDrawType == DrawX.DRAW_TYPE_DLINE) {
                if (!lineSuccess) {
                    mov_x2 = (int) event.getX();
                    mov_y2 = (int) event.getY();
                    canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
                } else {
                    mov_tx2 = (int) event.getX();
                    mov_ty2 = (int) event.getY();
                    canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
                    canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);
                }

            } else if (nDrawType == DrawX.DRAW_TYPE_RECT) {
                mov_x2 = (int) event.getX();
                mov_y2 = (int) event.getY();
                canvas.drawRect(mov_x1, mov_y1, mov_x2, mov_y2, paint);

            }

            invalidate();
        } else if (event.getAction() == MotionEvent.ACTION_DOWN) {// 如果点击

            if (nDrawType == DrawX.DRAW_TYPE_LINE) {
                mov_x1 = mov_x2 = (int) event.getX();
                mov_y1 = mov_y2 = (int) event.getY();
                canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);

            } else if (nDrawType == DrawX.DRAW_TYPE_DLINE) {
                if (!lineSuccess) {
                    mov_x1 = mov_x2 = (int) event.getX();
                    mov_y1 = mov_y2 = (int) event.getY();
                    canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
                } else {
                    mov_tx1 = mov_tx2 = (int) event.getX();
                    mov_ty1 = mov_ty2 = (int) event.getY();
                    canvas.drawLine(mov_x1, mov_y1, mov_x2, mov_y2, paint);
                    canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);
                }
            } else if (nDrawType == DrawX.DRAW_TYPE_RECT) {
                mov_x1 = mov_x2 = (int) event.getX();
                mov_y1 = mov_y2 = (int) event.getY();
                canvas.drawRect(mov_x1, mov_y1, mov_x2, mov_y2, paint);
            } else if (nDrawType == DrawX.DRAW_TYPE_LRREGULAR) {
                pm.addPoint(new Point((int) event.getX(), (int) event.getY()));
                pm.draw(canvas, paint);
            }
            invalidate();
        } else if (event.getAction() == MotionEvent.ACTION_UP) {//
            if (nDrawType == DrawX.DRAW_TYPE_DLINE) {
                if (mov_x2 - mov_x1 >= 10 || mov_y2 - mov_y1 >= 10) {
                    lineSuccess = true;
                }
            } else if (nDrawType == DrawX.DRAW_TYPE_LRREGULAR) {
                mov_tx2 = (int) event.getX();
                mov_ty2 = (int) event.getY();
                invalidate();
                canvas.drawLine(mov_tx1, mov_ty1, mov_tx2, mov_ty2, paint);
            }
        }
        return true;
    }

    private class PointManger {
        public ArrayList<Point> mList = null;
        private Canvas mCanvas;

        public PointManger() {
            this.mCanvas = canvas;
            if (mList == null) {
                mList = new ArrayList<DrawX.Point>();
            }

        }

        public ArrayList<Point> getArray() {
            if (mList == null) {
                return null;
            }
            return mList;
        }

        public void addPoint(Point p) {
            mList.add(p);
        }

        public void clear() {
            mList.clear();
        }

        public void draw(Canvas canvas, Paint p) {
            for (int i = 0; i < mList.size(); i++) {
                canvas.drawPoint(mList.get(i).x, mList.get(i).y, p);
                if (mList.size() >= 4) {
                    canvas.drawLine(mList.get(1).x, mList.get(1).y, mList.get(2).x, mList.get(2).y, p);

                }
                if (i == 1) {
                    canvas.drawLine(mList.get(0).x, mList.get(0).y, mList.get(1).x, mList.get(1).y, p);
                } else if (i > 1 && i < mList.size() - 2) {
                    canvas.drawLine(mList.get(i).x, mList.get(i).y, mList.get(i + 1).x, mList.get(i + 1).y, p);
                }

                else if (i > 1 && i == mList.size() - 1) {

                    canvas.drawLine(mList.get(0).x, mList.get(0).y, mList.get(mList.size() - 1).x,
                            mList.get(mList.size() - 1).y, p);
                    canvas.drawLine(mList.get(mList.size() - 2).x, mList.get(mList.size() - 2).y,
                            mList.get(mList.size() - 1).x, mList.get(mList.size() - 1).y, p);
                }
            }

        }
    }

    @SuppressLint("WrongCall")
    public void big(boolean bool) {
        // this.measure(MeasureSpec.makeMeasureSpec(Const.base_w,
        // MeasureSpec.EXACTLY),
        // MeasureSpec.makeMeasureSpec(Const.base_h, MeasureSpec.EXACTLY));
        // // setMeasuredDimension(Const.base_w, Const.base_h);
        // this.clearAnimation();
        if (bool && !isfu) {
            ScaleAnimation sca = new ScaleAnimation(0.5f, 1f, 0.5f, 1f);
            sca.setFillAfter(true);
            this.startAnimation(sca);
            isfu = true;
        } else if (bool == false && isfu) {
            ScaleAnimation sca = new ScaleAnimation(1f, 0.5f, 1f, 0.5f);
            sca.setFillAfter(true);
            isfu = false;
            this.startAnimation(sca);
        }
    }

    private class Point {
        public int x;
        public int y;

        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }

    }

    // public DrawOri getDrawOri() {
    // return drawori;
    // }

}
