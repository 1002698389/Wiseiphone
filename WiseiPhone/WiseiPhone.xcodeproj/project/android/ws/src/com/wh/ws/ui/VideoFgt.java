package com.wh.ws.ui;

import java.util.ArrayList;

import com.wh.ws.R;
import com.wh.ws.ob.VdManager.ChiooseItem;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.VideoView;

public class VideoFgt extends Fragment implements OnClickListener {
    private RelativeLayout mContral;
    private MyVideo mVideo;
    private ImageButton mIbAdd;
    private TextView mTvName;
    private ImageButton mib_top, mib_buttom, mib_left, mib_right;
    public DrawX drawx;
    private ChiooseItem ch;

    public VideoFgt() {
        super();
        // TODO Auto-generated constructor stub
    }

    public static Fragment newFragment() {
        VideoFgt v = new VideoFgt();

        return (Fragment) v;
    }

    @Override
    public void onAttach(Activity activity) {
        // TODO Auto-generated method stub
        super.onAttach(activity);
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View fgt = inflater.inflate(R.layout.fgt_v, null);

        initUi(fgt);

        return fgt;

    }

    public boolean isNull(){
        if(ch == null)
            return false;
        else 
            return true;
    }
    
    private void initUi(View fgt) {
        // 控制面板
        mContral = (RelativeLayout) fgt.findViewById(R.id.fgt_contrals);
        mib_left = (ImageButton) fgt.findViewById(R.id.fgt_left);
        mib_top = (ImageButton) fgt.findViewById(R.id.fgt_top);
        mib_right = (ImageButton) fgt.findViewById(R.id.fgt_right);
        mib_buttom = (ImageButton) fgt.findViewById(R.id.fgt_buttom);
        drawx = (DrawX) fgt.findViewById(R.id.fgt_drawx);
        Bitmap b = BitmapFactory.decodeResource(getResources(), R.drawable.img_left);
        mib_left.setImageBitmap(b);
        Matrix ma = new Matrix();

        ma.setScale(0.5f, 0.5f);
        mib_left.setImageMatrix(ma);

        mib_left.setOnClickListener(this);
        mib_top.setOnClickListener(this);
        mib_right.setOnClickListener(this);
        mib_buttom.setOnClickListener(this);
        //
        mContral.setVisibility(View.INVISIBLE);

        mTvName = (TextView) fgt.findViewById(R.id.fgt_tv);
        mVideo = (MyVideo) fgt.findViewById(R.id.fgt_video);

        mVideo.measure(500, 500);
        // mVideo.start();

        mIbAdd = (ImageButton) fgt.findViewById(R.id.fgt_ib_add);
        mIbAdd.setOnClickListener(this);
        mIbAdd.setVisibility(View.VISIBLE);
 
        if(ch == null){
            mTvName.setText("点击加入视频");
        }
//        fgt.setOnTouchListener(new OnTouchListener() {
//
//            float fx = 0;
//            float fy = 0;
//            DrawOri dr = drawx.getDrawOri();
//            
//            
//            @Override
//            public boolean onTouch(View arg0, MotionEvent arg1) {
//                if(dr == null){
//                    dr = drawx.getDrawOri();
//                 }
//                if(dr == null){
//                    return false;
//                }
//                switch (arg1.getAction()) {
//             
//                case MotionEvent.ACTION_DOWN:
//                    fx = arg1.getX();
//                    fy = arg1.getY();
//
//                    break;
//                case MotionEvent.ACTION_MOVE:
//                    float ex = arg1.getX();
//                    float ey = arg1.getY();
//                    int ffx = (int) Math.abs(ex - fx);
//                    int ffy = (int) Math.abs(fx - fy);
//                  
//                    if(ex-fx<=0 && ffx>ffy){
//                           dr.setDraxType(DrawOri.ORI_8, true); 
//                    } else if( ffx<ffy && ey-fy<0){
//                        dr.setDraxType(DrawOri.ORI_2, true);
//                    }else if(ex-fx>=0 && ffx>ffy){
//                        
//                        dr.setDraxType(DrawOri.ORI_4, true);   
//                        
//                    }else if(ffx<ffy && ey-fy>0){
//                        
//                        dr.setDraxType(DrawOri.ORI_6, true); 
//                        
//                    }
//                    
//                    
////                    if (ex - fx <= 0 && ey - fy <= 0 && ffx > 3) {
////                        int du = (int) Math.toDegrees(Math.atan((double) ffy / ffx));
////                        if (du >= 0 && du < 30) {
////
////                            Toast.makeText(getActivity(), du + "", 1).show();
////
////                            dr.setDraxType(DrawOri.ORI_8, true);
////
////                        } else if (du >= 30 && du < 60) {
////                            Toast.makeText(getActivity(), du + "", 1).show();
////                            dr.setDraxType(DrawOri.ORI_1, true);
////                            // dr.setPara(drawx.canvas, true);
////                        } else if (du >= 60 && du < 90) {
////                            Toast.makeText(getActivity(), du + "", 1).show();
////                            dr.setDraxType(DrawOri.ORI_2, true);
////                            // dr.setPara(drawx.canvas, true);
////
////                        }
////                    } else if (ex - fx <= 0 && ey - fy <= 0 && ffx > 3) {
////                        int du = (int) Math.toDegrees(Math.atan((double) ffy / ffx));
////                        if (du >= 0 && du < 30) {
////
////                            Toast.makeText(getActivity(), du + "", 1).show();
////
////                            dr.setDraxType(DrawOri.ORI_8, true);
////
////                        } else if (du >= 30 && du < 60) {
////                            Toast.makeText(getActivity(), du + "", 1).show();
////                            dr.setDraxType(DrawOri.ORI_1, true);
////                            // dr.setPara(drawx.canvas, true);
////                        } else if (du >= 60 && du < 90) {
////                            Toast.makeText(getActivity(), du + "", 1).show();
////                            dr.setDraxType(DrawOri.ORI_2, true);
////                            // dr.setPara(drawx.canvas, true);
////
////                        }
////
////                    }
//                    break;
//                case MotionEvent.ACTION_UP:
//                    dr.stopt();
//
//                    break;
//
//                default:
//                    break;
//                }
//
//                return true;
//            }
//        });
    }

    public void setVideoUrl(ChiooseItem item){
        
        this.ch = item;
        
    }
    
    public void positionDraw(String s,int tag){
        drawx.positionDraw(s, tag);
        
    }
    
    public String positionSave(){
       return  drawx.positionSave();
    }
    
    public DrawX getDrawX(){
        if(drawx != null){
            return drawx;
        }
        return null;
    }
    
    
    public ChiooseItem getChiooseItem(){
        if(ch == null){
           return null;
        }
        return ch;
    }
    
    public void stop() {

        // if(mVideo.isPlaying()){
        //
        // mVideo.pause();
        // }
        if(ch == null){
            return ;
        }
        mIbAdd.setVisibility(View.VISIBLE);
        mVideo.pause();
        mTvName.setText(ch.name+"(已经暂停)");

    }

    public void play() {
        if(ch == null){
            return ;
        }
        mIbAdd.setVisibility(View.INVISIBLE);
        mVideo.setVideoURI(Uri.parse(ch.url));
        mVideo.requestFocus();
        mVideo.start();
        if(ch != null){
            mTvName.setText(ch.name+"(播放中...)");
        }
        // new Thread(new Runnable() {
        //
        // @Override
        // public void run() {
        //
        // }
        // }).start();

    }

    @Override
    public void onClick(View v) {
        if (v == mib_left) {
            Toast.makeText(getActivity(), "left", 1).show();

        } else if (v == mib_top) {

            Toast.makeText(getActivity(), "top", 1).show();

        } else if (v == mib_right) {

            Toast.makeText(getActivity(), "right", 1).show();

        } else if (v == mib_buttom) {

            Toast.makeText(getActivity(), "buttom", 1).show();

        } else if (v == mIbAdd) {
            Intent in = new Intent();
            in.putExtra("tiao", 2);
            in.setClass(getActivity(), ItemAct.class);
            startActivityForResult(in, 2);

        }

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        // TODO Auto-generated method stub
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == 2) {

            ArrayList<ChiooseItem> list = (ArrayList<ChiooseItem>) data.getSerializableExtra("list");
            this.setVideoUrl(list.get(0));
            this.play();
        }

    }

}
