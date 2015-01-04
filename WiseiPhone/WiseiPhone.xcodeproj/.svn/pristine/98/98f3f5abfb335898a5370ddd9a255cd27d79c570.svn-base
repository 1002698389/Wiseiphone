package com.wh.ws.ui;

import java.util.ArrayList;

import com.wh.ws.R;
import com.wh.ws.db.RuleInfo;
import com.wh.ws.db.RuleInfo.Item;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.BaseExpandableListAdapter;
import android.widget.Button;
import android.widget.ExpandableListView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

public class SetAct extends BaseAct implements OnClickListener {
    private LinearLayout mLitem = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_set);
        init_title(R.drawable.img_title_left, "…Ë÷√", R.drawable.img_titile_back);
        init();

    }

    private void init() {
        mLitem = (LinearLayout) findViewById(R.id.act_set_item);
        for (int i = 0; i < mLitem.getChildCount(); i++) {
            mLitem.getChildAt(i).setOnClickListener(this);
        }

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
            public void onClick(View v) {
                SetAct.this.finish();

            }
        });

        title_tv.setText(name);
    }

    
    
    @Override
    public void onClick(View v) {
        // TODO Auto-generated method stub
        if(v == mLitem.getChildAt(0)){
            Intent intent = new Intent();
            intent.setClass(SetAct.this, DvdMangerAct.class);
            startActivity(intent);
            
        }else if(v == mLitem.getChildAt(1)){
            
        }else if(v == mLitem.getChildAt(2)){
            
        }else if(v == mLitem.getChildAt(3)){
            
        }else if(v == mLitem.getChildAt(4)){
            
        }

    }

}
