package com.wh.ws.ui;

import java.util.ArrayList;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.wh.ws.R;
import com.wh.ws.db.WarnInfo;
import com.wh.ws.db.WarnInfo.Item;

public class WarnInfoAct extends BaseAct {
    private ArrayList<Item> mList = null;
    private ListView mlv = null;
    private LinearLayout mDelet = null;
    private MyAdapter myd;
    private boolean isEidt = false;
    private ImageButton mEdit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_warninfo);
        ViewPager v = new ViewPager(getBaseContext());
        init_title(R.drawable.img_title_left, "报警信息", R.drawable.img_edit);
        initList();
    }

    public void initList() {
        mDelet =(LinearLayout)findViewById(R.id.act_warn_ll);
        mlv = (ListView) findViewById(R.id.act_warn_lv);
        mList = (ArrayList<Item>) WarnInfo.getAllWarnInfo(getApplicationContext());
        mlv.setAdapter(new MyAdapter(WarnInfoAct.this));

    }

    private void init_title(int id, String name, int id1) {

        ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView title_tv = (TextView) findViewById(R.id.title_tv_center);

        title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);
        mEdit =title_right;
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

                if (arg0.isSelected()) {
                    arg0.setSelected(false);
                    mDelet.setVisibility(View.INVISIBLE);
                } else {
                    arg0.setSelected(true);
                    mDelet.setVisibility(View.VISIBLE);
                }

                ((BaseAdapter) mlv.getAdapter()).notifyDataSetChanged();
            }
        });

        title_tv.setText(name);
    }

    
    public void click(View v) {
        switch (v.getId()) {
        case R.id.act_warn_ll:
            mList = (ArrayList<Item>) WarnInfo.deleteByData(getApplicationContext(), mList);
            ((BaseAdapter) mlv.getAdapter()).notifyDataSetChanged();
            Toast.makeText(getApplicationContext(), "删除成功", Toast.LENGTH_SHORT).show();
            break;

        default:
            break;
        }
      

    }
    
    
    class MyAdapter extends BaseAdapter {
        private Context context;

        public MyAdapter(Context mct) {
            this.context = mct;

        }

        @Override
        public int getCount() {
            // TODO Auto-generated method stub
            return mList.size();
        }

        @Override
        public Object getItem(int arg0) {
            // TODO Auto-generated method stub
            return mList.get(arg0);
        }

        @Override
        public long getItemId(int arg0) {
            // TODO Auto-generated method stub
            return arg0;
        }

        @Override
        public View getView(int arg0, View contentView, ViewGroup arg2) {
            if (contentView == null) {
                contentView = LayoutInflater.from(context).inflate(R.layout.waring_item, null);
            }

            final WarnInfo.Item item = mList.get(arg0);
            final ImageView iv_edit = (ImageView) contentView.findViewById(R.id.info_item_iv_edit);
            ImageView tv_icon = (ImageView) contentView.findViewById(R.id.info_item_iv);
            TextView tv_source = (TextView) contentView.findViewById(R.id.info_item_tv_address);
            TextView tv_data = (TextView) contentView.findViewById(R.id.info_item_tv_date);
            TextView tv_type = (TextView) contentView.findViewById(R.id.info_item_tv_name);

            iv_edit.setOnClickListener(new OnClickListener() {

                @Override
                public void onClick(View arg0) {
                    if (iv_edit.isSelected()) {
                        item.isDelete = false;
                        iv_edit.setSelected(false);
                        
                    } else {
                        item.isDelete = true;
                        iv_edit.setSelected(true);
                        // Toast.makeText(getApplicationContext(), "选中",
                        // 1).show();
                    }

                }
            });
            if (mEdit.isSelected()) {
                iv_edit.setVisibility(View.VISIBLE);
                if (item.isDelete) {
                    iv_edit.setSelected(true);
                } else {
                    iv_edit.setSelected(false);
                }

            } else {
                iv_edit.setVisibility(View.INVISIBLE);
            }
       
           // tv_icon.setImageDrawable(getResources().getDrawable(R.drawable.item_default));
            tv_source.setText(item.source);
            tv_data.setText(item.time);
            tv_type.setText(item.type + arg0);
            return contentView;
        }

    }

}
