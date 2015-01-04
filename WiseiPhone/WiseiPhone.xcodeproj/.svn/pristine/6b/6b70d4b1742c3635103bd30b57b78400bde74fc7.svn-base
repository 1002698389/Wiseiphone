package com.wh.ws.ui;

import java.util.ArrayList;

import com.wh.ws.R;
import com.wh.ws.db.CameraInfo;
import com.wh.ws.db.RuleInfo;
import com.wh.ws.ob.VdManager;
import com.wh.ws.ob.VdManager.ChiooseItem;
import com.wh.ws.utill.UtillTool;
import com.wh.ws.utill.UtillViewRule;
import com.wh.ws.utill.UtillViewRule.OnChioose;

import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Bundle;
import android.app.Dialog;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager.LayoutParams;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.PopupWindow;
import android.widget.Toast;

public class MainActivity extends BaseAct implements OnClickListener, OnChioose {
    private int curS;
    static final int RE_OK = 1;
    private LinearLayout btn_ll_contral;
    private LinearLayout main_contral;
    private BaseFragmentManager main_center;
    private android.app.FragmentManager mFm;
    private VideoFgt[] vFgt;
    private static OnChangeOritation onCh;
    private ArrayList<ChiooseItem> list = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        init_title(R.drawable.img_title_left, "实时预览", R.drawable.img_titile_right);
        init_layout();
        init_layout_btns();

    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        // TODO Auto-generated method stub
        if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            // Intent in = new Intent();
            // in.setClass(MainActivity.this, FeelAct.class);
            // startActivity(in);

        } else {

            // onCh.onChanOri(v);
        }
        super.onConfigurationChanged(newConfig);
    }

    private void init_title(int id, String name, int id1) {

        ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView title_tv = (TextView) findViewById(R.id.title_tv_center);

        title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);

        title_left.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                if (!getPw().isShowing()) {
                    getPw().showAsDropDown(arg0, 0, 0);
                } else {
                    getPw().dismiss();
                }

            }
        });
        title_right.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {

                Intent in = new Intent();
                in.setClass(MainActivity.this, ItemAct.class);
                in.putExtra("tiao", 1);
                startActivityForResult(in, 1);
            }
        });

        title_tv.setText(name);
    }

    private void init_layout() {
        mFm = getFragmentManager();
        main_contral = (LinearLayout) findViewById(R.id.main_buttom_ll_contral);
        main_center = (BaseFragmentManager) findViewById(R.id.main_center);
        curS = 4;
        if (curS == Const.JK_1S) {
            VideoFgt vi = new VideoFgt();
            FragmentTransaction ft = mFm.beginTransaction();
            ft.add(main_center.getChildAt(0).getId(), vi);
            ft.commit();
        } else if (curS == Const.JK_4S) {

            for (int i = 0; i < main_center.getChildCount(); i++) {
                VideoFgt vi = new VideoFgt();
                FragmentTransaction ft = mFm.beginTransaction();
                ft.add(main_center.getChildAt(i).getId(), vi, "s" + i);
                ft.commit();
            }
            main_center.setPageScroller(new OnPageScroller() {

                @Override
                public void pageScroller(View v, int curPage) {

                    v.setSelected(true);

                }
            });

        }
        restBtn(0);

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // TODO Auto-generated method stub
        super.onActivityResult(requestCode, resultCode, data);
        switch (resultCode) {
        case 1:
            list = (ArrayList<ChiooseItem>) data.getSerializableExtra("list");
            if (vFgt == null) {
                VideoFgt vf = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 0);
                VideoFgt vf1 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 1);
                VideoFgt vf2 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 2);
                VideoFgt vf3 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 3);
                vFgt = new VideoFgt[] { vf, vf1, vf2, vf3 };
            }
            for (int i = 0; i < list.size(); i++) {
                vFgt[i].setVideoUrl(list.get(i));
                vFgt[i].play();
            }
            if (list != null && list.size() > 0) {
                btn_ll_contral.getChildAt(0).setSelected(true);
            } else {
                btn_ll_contral.getChildAt(0).setSelected(false);
            }
            break;
        case 2:
            Toast.makeText(getApplicationContext(), "dao", 1).show();
            break;
        }

    }

    public void big() {
        main_center.setPadding(0, 0, 0, 0);
        main_center.invalidate();
    }

    public void bigs() {
        main_center.setPadding(0, 0, 200, 200);
        main_center.invalidate();
    }

    private void init_layout_btns() {
        btn_ll_contral = (LinearLayout) findViewById(R.id.button_ll_btns);
        for (int i = 0; i < btn_ll_contral.getChildCount(); i++) {
            btn_ll_contral.getChildAt(i).setOnClickListener(this);
        }

    }

    private void rest_btns() {
        for (int i = 1; i < btn_ll_contral.getChildCount(); i++) {
            btn_ll_contral.getChildAt(i).setSelected(false);
        }
        // Const.SCROOL =false;
    }

    @Override
    public void onClick(View arg0) {

        if (arg0 == btn_ll_contral.getChildAt(0)) {
            if (vFgt == null) {
                VideoFgt vf = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 0);
                VideoFgt vf1 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 1);
                VideoFgt vf2 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 2);
                VideoFgt vf3 = (VideoFgt) getFragmentManager().findFragmentByTag("s" + 3);
                vFgt = new VideoFgt[] { vf, vf1, vf2, vf3 };
            }
            int a = 0;
            for (int i = 0; i < vFgt.length; i++) {
                if (vFgt[i].isNull()) {
                    a = 1;
                }
            }
            if (a != 1) {
                showNotice("没有存在视频播放");
                return;
            }

            if (arg0.isSelected()) {
                arg0.setSelected(false);
                for (int i = 0; i < vFgt.length; i++) {
                    vFgt[i].stop();
                }

            } else {
                arg0.setSelected(true);
                for (int i = 0; i < vFgt.length; i++) {
                    vFgt[i].play();
                }

            }
        } else if (arg0 == btn_ll_contral.getChildAt(1)) {
            View v = main_center.getSelcted();
            if (v == null) {
                return;
            }
            ImageButton iv = (ImageButton) v.findViewById(R.id.fgt_ib_add);
            if (iv.getVisibility() == View.VISIBLE) {
                return;
            }
            rest_btns();
            btn_ll_contral.getChildAt(1).setSelected(true);
            big();
            
            MyVideo myv = (MyVideo) v.findViewById(R.id.fgt_video);
            myv.setDrawingCacheEnabled(true);
            Bitmap b =myv.getDrawingCache();
           
            
//            MediaMetadataRetriever rev = new MediaMetadataRetriever();
//
//            rev.setDataSource(this, Uri.parse(Const.V_DOOR));   //这里第一个参数需要Context，传this指针
//                             
//            Bitmap bitmap = rev.getFrameAtTime();
           
          
            
            UtillTool.getInstace(getApplicationContext()).saveBitmap("wa", b, null);
            
            
            

        } else if (arg0 == btn_ll_contral.getChildAt(2)) {
            View v = main_center.getSelcted();
            if (v == null) {
                return;
            }
            ImageButton iv = (ImageButton) v.findViewById(R.id.fgt_ib_add);
            if (iv.getVisibility() == View.VISIBLE) {
                return;
            }
            rest_btns();
            btn_ll_contral.getChildAt(2).setSelected(true);
            main_contral.removeAllViews();
            TextView tv = new TextView(getApplicationContext());
            tv.setText("......");
            tv.setTextColor(Color.WHITE);
            tv.setTextSize(40);
            tv.setX(Const.WIGHT / 2 - 100);
            main_contral.addView(tv);
            // bigs();
            //gongneng
            
           
            

        } else if (arg0 == btn_ll_contral.getChildAt(3)) {

            View v = main_center.getSelcted();
            if (v == null) {
                return;
            }
            ImageButton iv = (ImageButton) v.findViewById(R.id.fgt_ib_add);
            if (iv.getVisibility() == View.VISIBLE) {
                return;
            }
            RelativeLayout rlcontral = (RelativeLayout) v.findViewById(R.id.fgt_contrals);
            if (arg0.isSelected()) {
                rlcontral.setVisibility(View.INVISIBLE);
                btn_ll_contral.getChildAt(3).setSelected(false);
                main_contral.removeAllViews();

                if (!main_center.isFullScreen) {
                    main_center.isFull(false);
                } else {

                    Const.SCROOL = true;
                }
                main_center.getDrawX().big(false);

            } else {
                rlcontral.setVisibility(View.VISIBLE);
                rest_btns();
                main_contral.removeAllViews();
                btn_ll_contral.getChildAt(3).setSelected(true);
                getUtillview();
                main_contral.addView(getUtillview().getMainButtom());
                if (!main_center.isFullScreen) {
                    main_center.isFull(true);
                } else {

                    Const.SCROOL = false;
                }
                main_center.getDrawX().big(true);

                // 启动动画
                main_center.getDrawX().isrun = true;
                // DrawOri dra = new DrawOri();
                // main_center.getDrawX().setDrawOri(dra);
                // dra.star();
                // dra.start();
            }

            // View v = main_center.getSelcted();
            // if(v!=null){
            // RelativeLayout rlcontral =
            // (RelativeLayout)v.findViewById(R.id.fgt_contrals);
            // if(rlcontral.getVisibility() == View.GONE){
            // rlcontral.setVisibility(View.VISIBLE);
            // }else{
            // rlcontral.setVisibility(View.GONE);
            // }
            //
            //
            // }

        } else if (arg0 == btn_ll_contral.getChildAt(4)) {
            View v = main_center.getSelcted();
            if (v == null) {
                return;
            }
            ImageButton iv = (ImageButton) v.findViewById(R.id.fgt_ib_add);
            if (iv.getVisibility() == View.VISIBLE) {
                return;
            }
            main_contral.removeAllViews();
            if (arg0.isSelected()) {
                btn_ll_contral.getChildAt(4).setSelected(false);
                TextView tv = new TextView(getApplicationContext());
                tv.setText("......");
                tv.setTextColor(Color.WHITE);
                tv.setTextSize(40);
                tv.setX(Const.WIGHT / 2 - 100);
                main_contral.addView(tv);
                BaseFragmentManager.isButton = true;
                main_center.getDrawX().big(false);
                main_center.isFull(false);
            } else {

                rest_btns();
                btn_ll_contral.getChildAt(4).setSelected(true);
                UtillViewRule ru = UtillViewRule.getInstance(MainActivity.this);
                LayoutParams lp = new LayoutParams();
                lp.height = LayoutParams.MATCH_PARENT;
                ru.setOnChooiseLinsener(this);
                main_contral.addView(ru.getRuleView(MainActivity.this), lp);
                BaseFragmentManager.isButton = false;
            }

        } else if (arg0 == btn_ll_contral.getChildAt(5)) {
            View v = main_center.getSelcted();
            if (v == null) {
                return;
            }
            ImageButton iv = (ImageButton) v.findViewById(R.id.fgt_ib_add);
            if (iv.getVisibility() == View.VISIBLE) {
                return;
            }
            rest_btns();
            btn_ll_contral.getChildAt(5).setSelected(true);
            main_contral.removeAllViews();
            LayoutParams lp = new LayoutParams();
            lp.gravity = Gravity.BOTTOM;
            main_contral.addView(getUtillviewqx().getQx(), lp);
        }

    }

    @Override
    protected void onDestroy() {
        main_contral.removeAllViews();
        getUtillviewqx().clear();
        super.onDestroy();
    }

    @Override
    protected void onStop() {
        super.onStop();

        // if(main_contral.getChildAt(0).isSelected()){
        // btn_ll_contral.getChildAt(0).setSelected(false);
        // }
    }

    private boolean mBackPressed = false;
    private long time = 0;

    @Override
    public boolean dispatchKeyEvent(KeyEvent event) {

        if (KeyEvent.KEYCODE_BACK == event.getKeyCode() && event.getAction() == KeyEvent.ACTION_DOWN) {
            if (System.currentTimeMillis() - time > 2000) {
                mBackPressed = false;

            }
            if (mBackPressed) {
                this.des();
                finish();

                return true;
            } else {
                Toast t = Toast.makeText(this, "再按一次，退出应用。", Toast.LENGTH_SHORT);
                t.show();
                mBackPressed = true;

                time = System.currentTimeMillis();
                return true;
            }
        }

        return super.dispatchKeyEvent(event);
    }

    @Override
    public void onChiooseType(int id) {

        if (!main_center.isFullScreen) {
            main_center.isFull(true);
            Const.SCROOL = false;
        }
        DrawX drawx = main_center.getDrawX();
        drawx.type = -1;
        drawx.init();
        drawx.setDrawType(id);
        if (main_center.isButton == false)
            drawx.big(true);
    }

    @Override
    public void onLLBtn(int id, boolean[] bools) {
        RuleInfo.Item item = new RuleInfo.Item();
        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < bools.length; i++) {
            if (i < bools.length - 1) {
                if (bools[i]) {
                    sb.append(1).append(".");
                } else {
                    sb.append(-1).append(".");
                }

            } else {
                if (bools[i]) {
                    sb.append(1);
                } else {
                    sb.append(-1);
                }
            }
        }

        VideoFgt vtemp = (VideoFgt) getFragmentManager().findFragmentByTag("s" + main_center.getSelectedIndex());
        item.url = vtemp.getChiooseItem().url;
        item.type = id+"";
        item.source = "大门口";
        item.ques = sb.toString();
        item.location = vtemp.positionSave();
        RuleInfo.addWarnInfo(getApplicationContext(), item);
        showNotice("保存成功");
        main_center.getDrawX().type = -1;

    }

    interface OnChangeOritation {

        void onChanOri(Fragment[] fra);

    }

    public static void setOnChangeOritation(OnChangeOritation on) {
        MainActivity.onCh = on;

    }

}
