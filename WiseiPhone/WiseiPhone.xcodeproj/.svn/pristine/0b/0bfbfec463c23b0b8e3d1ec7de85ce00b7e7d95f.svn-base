package com.wh.ws.ui;

import java.util.ArrayList;

import com.wh.ws.R;
import com.wh.ws.db.RuleInfo;
import com.wh.ws.db.RuleInfo.Item;
import com.wh.ws.utill.UtillViewRule;


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

public class MarktSetAct extends BaseAct implements OnClickListener {
   private ExpandableListView myEList = null;  
   private myElistAdapter myElistAdapter = null;
   ArrayList<RuleInfo.Item> items=null;
   
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_marketset);
        init_title(R.drawable.img_title_left, "智能设置", R.drawable.img_titile_back);
     
        
    }
    
    private void init(){
        items =  (ArrayList<Item>) RuleInfo.getAllWarnInfo(getApplicationContext());
        myEList = (ExpandableListView)findViewById(R.id.rule_expandablelistview);        
        myEList.setGroupIndicator(null);
        myElistAdapter = new myElistAdapter(getApplicationContext());
        myEList.setAdapter(myElistAdapter);
    }
    
    @Override
        protected void onResume() {
            // TODO Auto-generated method stub
            super.onResume();
            init();
            
            
            
            
            
        }
    

    
    
    private void init_title(int id, String name, int id1) {

        ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
        ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
        TextView  title_tv = (TextView) findViewById(R.id.title_tv_center);

        title_left.setBackgroundResource(id);
        title_right.setBackgroundResource(id1);

        title_left.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View arg0) {
                if(!getPw().isShowing()){
                    getPw().showAsDropDown(arg0, 0, 0);
                }else{
                    getPw().dismiss();
                }
                
            }
        });
        title_right.setOnClickListener(new OnClickListener() {
            
            @Override
            public void onClick(View v) {
                MarktSetAct.this.finish();
                
            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View arg0) {
        // TODO Auto-generated method stub
        
    }


    class myElistAdapter extends BaseExpandableListAdapter {
        private Context mContext;
        public myElistAdapter(Context mctx) {
            this.mContext =mctx;
        }

        String[] group = { "我的摄像头", "服务器1", "服务器2" };
        String[][] child = { { "摄像头1" }, { "摄像头1" }, { "摄像头1" } };

        @Override
        public Object getChild(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return child[arg0][arg1];
        }

        @Override
        public long getChildId(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return arg1;
        }

        @Override
        public View getChildView(final int ar, final int arg1, boolean arg2, View con, ViewGroup con1) {
            if (con == null) {
                con = LayoutInflater.from(mContext).inflate(R.layout.rule_my_child, null);
            }
            ImageButton my_btn1 = (ImageButton) con.findViewById(R.id.rule_child_imgbtn1);
            ImageButton my_btn2 = (ImageButton) con.findViewById(R.id.rule_child_imgbtn2);
            ImageButton my_btn3 = (ImageButton) con.findViewById(R.id.rule_child_imgbtn3);
            my_btn1.setOnClickListener(new OnClickListener() {

                @Override
                public void onClick(View arg0) {
                   Intent in = new Intent();
                   in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                   in.setClass(MarktSetAct.this, RulePraAct.class);
                   in.putExtra("ruleid", items.get(ar).id);
                   startActivity(in);
                }
            });
            my_btn2.setOnClickListener(new OnClickListener() {

                @Override
                public void onClick(View arg0) {
                    // TODO Auto-generated method stub
//                    mRecordList.remove(ar);
//                    UtillView.this.upgradeAdapter();
//                    UtillView.this.notifacation();
                      RuleInfo.deleteByid(mContext,items.get(ar));
                      items.remove(ar);
                      myElistAdapter.notifyDataSetChanged();
                      Toast.makeText(mContext,"成功删除规则", 1).show(); 
                }
            });

            my_btn3.setOnClickListener(new OnClickListener() {

                @Override
                public void onClick(View arg0) {
         
                }
            });

            return con;
        }

        @SuppressWarnings("static-access")
        @Override
        public View getGroupView(int arg0, boolean arg1, View con, ViewGroup arg3) {
            if (con == null) {
                con = LayoutInflater.from(mContext).inflate(R.layout.rule_my_parent, null);
            }
            ImageView my_iv = (ImageView) con.findViewById(R.id.rule_parent_imgbtn);
            TextView my_tv = (TextView) con.findViewById(R.id.rule_parent_tv);
            if (arg1)
                my_iv.setSelected(false);
            else {
                my_iv.setSelected(true);
            }
            my_tv.setText(((RuleInfo.Item)this.getGroup(arg0)).source+UtillViewRule.mS[Integer.parseInt(((RuleInfo.Item)this.getGroup(arg0)).type)]);

            return con;
        }

        @Override
        public int getChildrenCount(int arg0) {

            return 1;
        }

        @Override
        public Object getGroup(int arg0) {
            // TODO Auto-generated method stub
            return items.get(arg0);
        }

        @Override
        public int getGroupCount() {
            // TODO Auto-generated method stub
            int i = items.size();
            return i;
        }

        @Override
        public long getGroupId(int arg0) {
            // TODO Auto-generated method stub
            return arg0;
        }

        @Override
        public boolean hasStableIds() {
            return true;
        }

        @Override
        public boolean isChildSelectable(int arg0, int arg1) {
            // TODO Auto-generated method stub
            return true;
        }
    }
        
    }

    
    
    
    

