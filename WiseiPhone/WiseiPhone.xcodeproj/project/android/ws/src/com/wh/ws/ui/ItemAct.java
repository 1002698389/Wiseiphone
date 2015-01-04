package com.wh.ws.ui;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
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

public class ItemAct extends BaseAct {
    private ExpandableListView myEList = null;
    private MyExpandable myElistAdapter = null;
    private VdManager vd;
    private LinearLayout mBtnL =null;
    public  ArrayList<ChiooseItem> mList = null;
    private int tag;
 @Override
protected void onCreate(Bundle savedInstanceState) {
    // TODO Auto-generated method stub
    super.onCreate(savedInstanceState);
    setContentView(R.layout.act_item);
    init_title(R.drawable.img_title_left,"频道列表", R.drawable.img_titile_back);
    init();
}
 
 
 
 private void init(){
     Intent in = getIntent();
     
     tag = in.getIntExtra("tiao", 3);
     
     mList = new ArrayList<VdManager.ChiooseItem>();
     mBtnL = (LinearLayout)findViewById(R.id.act_item_ll);
     mBtnL.setOnClickListener(new OnClickListener() {
        
        @Override
        public void onClick(View arg0) {
            Intent in = new Intent();
            in.setClass(ItemAct.this, MainActivity.class);
            Bundle bun = new Bundle();
//            ArrayList<ChiooseItem> li = new ArrayList<ChiooseItem>();
//            ChiooseItem ch = new ChiooseItem();
//            ch.name ="wa";
//            ch.url=Const.V_DOOR;
//            li.add(ch);
//            ch = new ChiooseItem();
//            ch.name ="ww";
//            li.add(ch);
            if(tag ==1){
                in.putExtra("list", (Serializable)mList);
                setResult(1, in); 
            }else if(tag==2){
                in.putExtra("list", (Serializable)mList);
                setResult(2, in); 
            }
          
            finish();
            
        }
    });;
     initVdManage();
     myEList = (ExpandableListView)findViewById(R.id.act_item_epd);
     myElistAdapter = new MyExpandable(getApplicationContext());

     myEList.setGroupIndicator(null);
     myEList.setAdapter(myElistAdapter);
     myEList.setFocusable(true);
     myEList.setOnChildClickListener(new OnChildClickListener() {
        
        @Override
        public boolean onChildClick(ExpandableListView arg0, View v, int g, int c, long arg4) {
               ImageView iv = (ImageView)((RelativeLayout)v).getChildAt(2);
               if(mList.size()>=4 && !iv.isSelected()){
                   showNotice("选择条目已经最大");
                   return true;
               }
               RadioChiid rc = vd.getchild(g, c);
               ChiooseItem ch = new ChiooseItem();
               ch.name = vd.getP().get(g).asName+"."+rc.asName;
               ch.url =rc.url;
               
               if(iv.isSelected()){
                   iv.setSelected(false);
                   remove(ch.name);
               }else{
                   iv.setSelected(true);
                   mList.add(ch);
               }
            return false;
        }
    });
     
     
 }
 @Override
 public void onConfigurationChanged(Configuration newConfig) {
     // TODO Auto-generated method stub
   
     if(newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE){
         Intent in = new Intent();
         in.setClass(ItemAct.this, FeelAct.class);
         startActivity(in);
         
     }
     super.onConfigurationChanged(newConfig);
 }
 
 
 
 private void remove(String s){
     int cur = -1;
     for(int i =0;i<mList.size();i++){
         if(mList.get(i).name.equals(s)){
             cur = i;
             mList.remove(cur);
             cur = -1;
            break;
         }
        
         
     }
     
     
     
 }
 
 private void init_title(int id, String name, int id1) {

     //ImageButton title_left = (ImageButton) findViewById(R.id.title_ib_left);
     ImageButton title_right = (ImageButton) findViewById(R.id.title_ib_rights);
     TextView  title_tv = (TextView) findViewById(R.id.title_tv_center);

   //  title_left.setBackgroundResource(id);
     title_right.setBackgroundResource(id1);

//     title_left.setOnClickListener(new OnClickListener() {
//         
//         @Override
//         public void onClick(View arg0) {
//             if(!getPw().isShowing()){
//                 getPw().showAsDropDown(arg0, 0, 0);
//             }else{
//                 getPw().dismiss();
//             }
//             
//         }
//     });
     title_right.setOnClickListener(new OnClickListener() {
         
         @Override
         public void onClick(View v) {
             ItemAct.this.finish();
             
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


}
