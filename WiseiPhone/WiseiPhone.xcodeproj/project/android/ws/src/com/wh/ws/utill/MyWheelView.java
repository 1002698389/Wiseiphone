package com.wh.ws.utill;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.wh.ws.R;
import com.wh.ws.ui.Const;
import com.ws.nwxc.wheelview.NumericWheelAdapter;
import com.ws.nwxc.wheelview.OnWheelScrollListener;
import com.ws.nwxc.wheelview.WheelView;

import android.content.Context;
import android.graphics.drawable.BitmapDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager.LayoutParams;
import android.widget.Button;
import android.widget.PopupWindow;
import android.widget.TextView;

public class MyWheelView {

    private Context mContext;
    private CallBack callBack;
    private WheelView mwlYear = null;
    private WheelView mwlMonth = null;
    private WheelView mwlDay = null;
    private WheelView mwlHour = null;
    private WheelView mwlm = null;

    private int curY;
    private int curMo;
    private int curD;
    private int curH;
    private int curM;

    private int poor;
    private int dayNum;

    private StringBuffer sb;

    SimpleDateFormat sp = null;

    private PopupWindow mpw;

    public MyWheelView(Context cont) {
        this.mContext = cont;
        initWheel();
        init_wheeldata();
    }

    private void initWheel() {
        View my = LayoutInflater.from(mContext).inflate(R.layout.dialog_wheelview, null);
        mwlYear = (WheelView) my.findViewById(R.id.wheel_1);
        mwlMonth = (WheelView) my.findViewById(R.id.wheel_2);
        mwlDay = (WheelView) my.findViewById(R.id.wheel_3);
        mwlHour = (WheelView) my.findViewById(R.id.wheel_4);
        mwlm = (WheelView) my.findViewById(R.id.wheel_5);
        sp = new SimpleDateFormat("%02d");
        sb = new StringBuffer();
        mpw = new PopupWindow(my,Const.WIGHT,LayoutParams.WRAP_CONTENT);
        mpw.setBackgroundDrawable(new BitmapDrawable());
        mpw.setOutsideTouchable(true);
        mpw.setFocusable(true);
    }
    
    public void show(View v){
        if(mpw.isShowing()){
            mpw.dismiss();
        }
        mpw.showAsDropDown(v);
        
        
    }

    private void init_wheeldata() {

        final Calendar c1 = Calendar.getInstance();

        Calendar c = Calendar.getInstance();
        curY = c.get(Calendar.YEAR);
        curMo = c.get(Calendar.MONTH);
        curD = c.get(Calendar.DAY_OF_MONTH);
        curH = c.get(Calendar.HOUR);
        curM = c.get(Calendar.MINUTE);

        poor = curY - 10;

        mwlYear.setAdapter(new NumericWheelAdapter(2003, c1.get(Calendar.YEAR)));
        mwlYear.setLabel("年");
        mwlYear.setCyclic(true);
        mwlYear.setCurrentItem(curY);

        mwlMonth.setAdapter(new NumericWheelAdapter(1, 12, "%02d"));
        mwlMonth.setLabel("月");
        mwlMonth.setCyclic(true);

        mwlDay.setAdapter(new NumericWheelAdapter(1, 12, "%02d"));
        mwlDay.setLabel("日");
        mwlDay.setCyclic(true);

        mwlHour.setAdapter(new NumericWheelAdapter(0, 23, "%02d"));
        mwlHour.setLabel("时");
        mwlHour.setCyclic(true);

        mwlm.setAdapter(new NumericWheelAdapter(1, 59, "%02d"));
        mwlm.setLabel("分");
        mwlm.setCyclic(true);

        mwlYear.setCurrentItem(curY + 10);
        mwlMonth.setCurrentItem(curMo - 1);
        mwlDay.setCurrentItem(curD - 1);
        mwlDay.setCurrentItem(curH - 1);
        mwlDay.setCurrentItem(curM - 1);

        OnWheelScrollListener scrollListener = new OnWheelScrollListener() {
            public void onScrollingStarted(WheelView wheel) {
                // timeScrolled = true;
            }

            public void onScrollingFinished(WheelView wheel) {
                // timeScrolled = false;
                if (wheel.getId() == R.id.wheel_1) {

                    sb.setLength(0);
                    sb.append(mwlYear.getCurrentItem() + poor).append("-")
                            .append(String.format("%02d", mwlMonth.getCurrentItem() + 1)).append("-")
                            .append(String.format("%02d", mwlDay.getCurrentItem() + 1)).append(" ")
                            .append(String.format("%02d", mwlHour.getCurrentItem() + 1)).append(":")
                            .append(String.format("%02d", mwlm.getCurrentItem() + 1));
                    dayNum = setwheelDay(mwlYear.getCurrentItem() + poor, mwlMonth.getCurrentItem() + 1);
                    mwlDay.setAdapter(new NumericWheelAdapter(1, dayNum, "%02d"));
                } else if (wheel.getId() == R.id.wheel_2) {
                    sb.setLength(0);
                    sb.append(mwlYear.getCurrentItem() + poor).append("-")
                            .append(String.format("%02d", mwlMonth.getCurrentItem() + 1)).append("-")
                            .append(String.format("%02d", mwlDay.getCurrentItem() + 1)).append(" ")
                            .append(String.format("%02d", mwlHour.getCurrentItem() + 1)).append(":")
                            .append(String.format("%02d", mwlm.getCurrentItem() + 1));
                    dayNum = setwheelDay(mwlYear.getCurrentItem() + poor, mwlMonth.getCurrentItem() + 1);
                    System.out.println("dddddddddddddddddddddddd" + dayNum);
                    mwlDay.setAdapter(new NumericWheelAdapter(1, dayNum, "%02d"));
                } else if (wheel.getId() == R.id.wheel_3) {
                    sb.setLength(0);
                    sb.append(mwlYear.getCurrentItem() + poor).append("-")
                            .append(String.format("%02d", mwlMonth.getCurrentItem() + 1)).append("-")
                            .append(String.format("%02d", mwlDay.getCurrentItem() + 1)).append(" ")
                            .append(String.format("%02d", mwlHour.getCurrentItem() + 1)).append(":")
                            .append(String.format("%02d", mwlm.getCurrentItem() + 1));
                    dayNum = setwheelDay(mwlYear.getCurrentItem() + poor, mwlMonth.getCurrentItem() + 1);
                    curD = mwlDay.getCurrentItem();
                } else if (wheel.getId() == R.id.wheel_4) {
                    sb.setLength(0);
                    sb.append(mwlYear.getCurrentItem() + poor).append("-")
                            .append(String.format("%02d", mwlMonth.getCurrentItem() + 1)).append("-")
                            .append(String.format("%02d", mwlDay.getCurrentItem() + 1)).append(" ")
                            .append(String.format("%02d", mwlHour.getCurrentItem() + 1)).append(":")
                            .append(String.format("%02d", mwlm.getCurrentItem() + 1));
                    dayNum = setwheelDay(mwlYear.getCurrentItem() + poor, mwlMonth.getCurrentItem() + 1);
                    curH = mwlHour.getCurrentItem();
                } else if (wheel.getId() == R.id.wheel_5) {
                    curM = mwlm.getCurrentItem();
                    sb.setLength(0);
                    sb.append(mwlYear.getCurrentItem() + poor).append("-")
                            .append(String.format("%02d", mwlMonth.getCurrentItem() + 1)).append("-")
                            .append(String.format("%02d", mwlDay.getCurrentItem() + 1)).append(" ")
                            .append(String.format("%02d", mwlHour.getCurrentItem() + 1)).append(":")
                            .append(String.format("%02d", mwlm.getCurrentItem() + 1));
                    dayNum = setwheelDay(mwlYear.getCurrentItem() + poor, mwlMonth.getCurrentItem() + 1);
                    curH = mwlHour.getCurrentItem();
                }
                callBack.setTime(sb.toString());
            }
        };

        mwlYear.addScrollingListener(scrollListener);
        mwlMonth.addScrollingListener(scrollListener);
        mwlDay.addScrollingListener(scrollListener);
        mwlHour.addScrollingListener(scrollListener);
        mwlm.addScrollingListener(scrollListener);
    }

    private int setwheelDay(int year, int month) {
        int day = 31;
        if (month == 2) {
            if ((year % 4 == 0) && ((year % 100 != 0) | (year % 400 == 0))) {
                day = 29;
            } else {
                day = 28;
            }
        }
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            day = 30;
        }
        return day;
    }

    public void addCallBack(CallBack ca) {

        this.callBack = ca;

    }

    public interface CallBack {
        void setTime(String s);
    }
}
