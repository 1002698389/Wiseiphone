package com.wh.ws.ui;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.ExpandableListView.OnChildClickListener;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wh.ws.R;
import com.wh.ws.ob.VdManager;
import com.wh.ws.ob.VdManager.ChiooseItem;
import com.wh.ws.ob.VdManager.RadioChiid;
import com.wh.ws.ob.VdManager.RadioPrent;
import com.wh.ws.utill.MyWheelView;
import com.wh.ws.utill.MyWheelView.CallBack;
import com.wh.ws.utill.UtillView;


public class VideoManagerAct extends BaseAct implements OnClickListener {
    private ExpandableListView myEList = null;
    private MyExpandable myElistAdapter = null;
    private VdManager vd;
    private LinearLayout mBtnL = null;
    private RelativeLayout mrl_star;
    private RelativeLayout mrl_end;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_videomanager);
        init_title(R.drawable.img_title_left, "频道列表", R.drawable.img_titile_back);
        initTime();
        init();

    }

    private void initTime() {

        mrl_star = (RelativeLayout) findViewById(R.id.act_video_rl_time_star);
        mrl_star.setOnClickListener(this);

        mrl_end = (RelativeLayout) findViewById(R.id.act_video_rl_time_end);
        mrl_end.setOnClickListener(this);

    }

    private void init() {
        mBtnL = (LinearLayout) findViewById(R.id.act_item_ll);
        mBtnL.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                Intent in = new Intent();
                in.setClass(VideoManagerAct.this, LuyVideoAct.class);
                startActivity(in);
      

            }
        });
        ;
        initVdManage();
        myEList = (ExpandableListView) findViewById(R.id.act_item_epd);
        myElistAdapter = new MyExpandable(getApplicationContext());

        myEList.setGroupIndicator(null);
        myEList.setAdapter(myElistAdapter);
        myEList.setFocusable(true);
        myEList.setOnChildClickListener(new OnChildClickListener() {

            @Override
            public boolean onChildClick(ExpandableListView arg0, View v, int g, int c, long arg4) {
                ImageView iv = (ImageView) ((RelativeLayout) v).getChildAt(2);
                iv.setSelected(iv.isSelected() ? false : true);

                return false;
            }
        });

    }

    private void init_title(int id, String name, int id1) {

        // ImageButton title_left = (ImageButton)
        // findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView title_tv = (TextView) findViewById(R.id.title_tv_center);

        // title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);

        // title_left.setOnClickListener(new OnClickListener() {
        //
        // @Override
        // public void onClick(View arg0) {
        // if(!getPw().isShowing()){
        // getPw().showAsDropDown(arg0, 0, 0);
        // }else{
        // getPw().dismiss();
        // }
        //
        // }
        // });
        title_right.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                VideoManagerAct.this.finish();
            }
        });

        title_tv.setText(name);
    }

    public void initVdManage() {

        vd = new VdManager();
        VdManager.RadioPrent p = new VdManager.RadioPrent();
        p.asName = "我的视频";
        vd.addParent(p);
        p = new VdManager.RadioPrent();
        p.asName = "我的服务器1";
        vd.addParent(p);
        p = new VdManager.RadioPrent();
        p.asName = "我的服务器2";
        vd.addParent(p);

        VdManager.RadioChiid p1 = new VdManager.RadioChiid();
        p1.asName = "视频1";
        p1.url = Const.V_DOOR;
        vd.addChild("我的视频", p1);

        p1 = new VdManager.RadioChiid();
        p1.asName = "视频2";
        p1.url = Const.V_DOOR;
        vd.addChild("我的视频", p1);

        p1 = new VdManager.RadioChiid();
        p1.asName = "视频3";
        p1.url = Const.V_DOOR;
        vd.addChild("我的视频", p1);

        p1 = new VdManager.RadioChiid();
        p1.asName = "视频4";
        p1.url = Const.V_DOOR;
        vd.addChild("我的视频", p1);

        p1 = new VdManager.RadioChiid();
        p1.asName = "视频1";
        p1.url = Const.V_DOOR;
        vd.addChild("我的服务器1", p1);
        p1 = new VdManager.RadioChiid();
        p1.asName = "视频2";
        p1.url = Const.V_DOOR;
        vd.addChild("我的服务器1", p1);

        p1 = new VdManager.RadioChiid();
        p1.asName = "视频1";
        p1.url = Const.V_DOOR;
        vd.addChild("我的服务器2", p1);
        p1 = new VdManager.RadioChiid();
        p1.asName = "视频2";
        p1.url = Const.V_DOOR;
        vd.addChild("我的服务器2", p1);
    }

    public class MyExpandable extends BaseExpandableListAdapter {
        Context mctx;

        public MyExpandable(Context mctx) {
            this.mctx = mctx;
        }

        @Override
        public Object getChild(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return vd.getchild(arg0, arg1);
        }

        @Override
        public long getChildId(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return arg1;
        }

        @Override
        public View getChildView(int arg0, int arg1, boolean arg2, View con, ViewGroup con1) {
            if (con == null) {
                con = LayoutInflater.from(mctx).inflate(R.layout.my_childitem, null);
            }
            TextView my_tv = (TextView) con.findViewById(R.id.item_my_tv);

            my_tv.setText(((RadioChiid) getChild(arg0, arg1)).asName.toString());
            con.setClickable(false);
            return con;
        }

        @Override
        public View getGroupView(int arg0, boolean arg1, View con, ViewGroup arg3) {
            if (con == null) {
                con = LayoutInflater.from(mctx).inflate(R.layout.my_parent, null);
            }
            ImageView my_iv = (ImageView) con.findViewById(R.id.item_parent_my_iv);
            TextView my_tv = (TextView) con.findViewById(R.id.item_parent_my_tv);
            if (arg1)
                my_iv.setSelected(false);
            else
                my_iv.setSelected(true);

            my_tv.setText(((RadioPrent) this.getGroup(arg0)).asName.toString());

            return con;
        }

        @Override
        public int getChildrenCount(int arg0) {

            return vd.getChildList(arg0).size();
        }

        @Override
        public Object getGroup(int arg0) {
            // TODO Auto-generated method stub
            return vd.getP().get(arg0);
        }

        @Override
        public int getGroupCount() {
            // TODO Auto-generated method stub
            return vd.getP().size();
        }

        @Override
        public long getGroupId(int arg0) {
            // TODO Auto-generated method stub
            return arg0;
        }

        @Override
        public boolean hasStableIds() {
            // TODO Auto-generated method stub
            return true;
        }

        @Override
        public boolean isChildSelectable(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return true;
        }

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
        case R.id.act_video_rl_time_star:
            
            MyWheelView my = new MyWheelView(VideoManagerAct.this);
            my.addCallBack(new CallBack() {
                
                public void setTime(String s) {
                    ((TextView)mrl_star.getChildAt(1)).setText(s);
                }
            });
            my.show(mrl_star);
            
            
            break;
        case R.id.act_video_rl_time_end:
            my = new MyWheelView(VideoManagerAct.this);
            my.addCallBack(new CallBack() {
                
                public void setTime(String s) {
                    ((TextView)mrl_end.getChildAt(1)).setText(s);
                }
            });
            my.show(mrl_end);
            
            break;
        }

    }
}
