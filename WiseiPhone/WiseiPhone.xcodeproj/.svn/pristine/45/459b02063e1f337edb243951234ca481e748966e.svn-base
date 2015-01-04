package com.wh.ws.ui;

import java.util.ArrayList;

import com.wh.ws.R;
import com.wh.ws.db.CameraInfo;
import com.wh.ws.db.CameraInfo.Item;
import com.wh.ws.ob.Imageinfo;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

public class ImgOrVideoManagerAct extends BaseAct implements OnClickListener {

    private ListView mlv;
    private GridView mgv;
    public ArrayList<String> mitemDatas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.img_orvideo_manager);
        init_title(R.drawable.img_title_left, "ÕºœÒπ‹¿Ì", R.drawable.img_titile_back);
        init();

    }

    private void init() {
        //initData();
        mitemDatas = (ArrayList<String>) CameraInfo.getDate(getApplicationContext());
        mlv = (ListView) findViewById(R.id.iomact_mylv);
        mlv.setAdapter(new MyLvAdapter(getApplicationContext()));
       

    }
//    private void initData() {
//        mitems = new ArrayList<Imageinfo>();
//        Imageinfo item;
//        for (int i = 0; i < 10; i++) {
//            item = new Imageinfo();
//            item.data = "2013-3-" + i + 1;
//           if(i==3)
//                item.ids = new int[] { R.drawable.item_default, R.drawable.item_default };
//           else
//               item.ids = new int[] {R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default,R.drawable.item_default, R.drawable.item_default, R.drawable.item_default };  
//            mitems.add(item);
//        }
//
//    }

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
            public void onClick(View v) {
                ImgOrVideoManagerAct.this.finish();

            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View v) {

    }

    class MyGvAdapter extends BaseAdapter {
        private Context mctxt = null;
        private ArrayList<CameraInfo.Item> cameraInfos;

        public MyGvAdapter(Context mct, ArrayList<CameraInfo.Item> cameraInfos) {
            mctxt = mct;
            this.cameraInfos = cameraInfos;
        }

        @Override
        public int getCount() {
            // TODO Auto-generated method stub
             int a = cameraInfos!=null?cameraInfos.size():0; 
             
            return a;
        }

        @Override
        public Object getItem(int arg0) {
            // TODO Auto-generated method stub
            return cameraInfos.get(arg0);
        }

        @Override
        public long getItemId(int arg0) {
            // TODO Auto-generated method stub
            return arg0;
        }

        @Override
        public View getView(int arg0, View con, ViewGroup arg2) {
            if (con == null) {
                con = LayoutInflater.from(mctxt).inflate(R.layout.item_gride, null);
            }
            ImageView iv = (ImageView) con.findViewById(R.id.gride_iv);
            if(cameraInfos.get(arg0).type == CameraInfo.TYPE_IMAGE){
                Bitmap bi =BitmapFactory.decodeFile(cameraInfos.get(arg0).url);
                iv.setImageBitmap(bi);
                
            }else if(cameraInfos.get(arg0).type == CameraInfo.TYPE_VIDEO){
                
                
                
            }
          
            return con;
       
        }

    }

    class MyLvAdapter extends BaseAdapter {
        private Context mctxt = null;

        public MyLvAdapter(Context mct) {
            mctxt = mct;
        }

        @Override
        public int getCount() {
            // TODO Auto-generated method stub
            return mitemDatas.size();
        }

        @Override
        public Object getItem(int arg0) {
            // TODO Auto-generated method stub
            return mitemDatas.get(arg0);
        }

        @Override
        public long getItemId(int arg0) {
            // TODO Auto-generated method stub
            return arg0;
        }

        @Override
        public View getView(int arg0, View con, ViewGroup arg2) {
            if (null == con) {
                con = LayoutInflater.from(mctxt).inflate(R.layout.item_iov, null);
            }
            TextView tv = (TextView) con.findViewById(R.id.iov_item_tv);
            MyGridview gv = (MyGridview) con.findViewById(R.id.iov_item_gv);
            ArrayList<CameraInfo.Item> cameraInfoItem = (ArrayList<Item>) CameraInfo.getAllByDate(mctxt, mitemDatas.get(arg0).toString());
            gv.setAdapter(new MyGvAdapter(mctxt, cameraInfoItem));
            
            gv.setOnItemClickListener(new OnItemClickListener() {

                @Override
                public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
                    
                         Toast.makeText(getApplicationContext(), arg2+"click", 1).show();
                    
                }
            });
            tv.setText(mitemDatas.get(arg0).toString());
            return con;

        }

    }

}
