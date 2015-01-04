package com.wh.ws.ui;

import com.wh.ws.R;
import com.wh.ws.db.RuleInfo;
import com.wh.ws.db.RuleInfo.Item;
import com.wh.ws.ob.VdManager.ChiooseItem;
import com.wh.ws.utill.UtillViewRule;
import com.wh.ws.utill.UtillViewRule.OnChioose;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.Toast;
import android.widget.LinearLayout.LayoutParams;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class RulePraAct extends BaseAct implements OnClickListener,OnChioose{
    private VideoFgt mVfgt;
    private RuleInfo.Item mItem;
    private LinearLayout mRule,mLlCenter;
    private ImageButton edit, play, delete;
    

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_rulepre);
        Intent in = getIntent();
        int tag = in.getIntExtra("ruleid", -1);
        init_title(R.drawable.img_title_left, "规则管理", R.drawable.img_titile_back);
        init(tag);

    }

    private void init(int ta) {
        mItem = RuleInfo.findItemByid(getApplicationContext(), ta);
        mRule = (LinearLayout) findViewById(R.id.rulepre_rule);
        mLlCenter = (LinearLayout) findViewById(R.id.rulepre_ll);

        edit = (ImageButton) findViewById(R.id.rulepre_ibtn_eidt);
        edit.setOnClickListener(this);

        play = (ImageButton) findViewById(R.id.rulepre_ibtn_play);
        play.setOnClickListener(this);

        delete = (ImageButton) findViewById(R.id.rulepre_ibtn_delete);
        delete.setOnClickListener(this);

        initFgt();
        initButtom();
        //initRule();

    }

    private void initRule() {
        UtillViewRule ut = new UtillViewRule(getApplicationContext());
        View v = ut.getRuleView(RulePraAct.this);
        ((TextView)((RelativeLayout)v.findViewById(R.id.rule_item_step3)).getChildAt(0)).setText("保存并更新");
        
        ut.setOnChooiseLinsener(this);
        ut.setClfa(mItem.ques.toString());
        ut.setSaveType(Integer.parseInt(mItem.type));
        
        LayoutParams la = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
        mRule.addView(v, la);
    }

    private void initButtom() {

        
        
    }
    
    

    private void initFgt() {
        mVfgt = (VideoFgt) getFragmentManager().findFragmentById(R.id.rulepre_fgt);
        ChiooseItem item = new ChiooseItem();
        item.name = mItem.source;
        item.url = mItem.url;
        mVfgt.setVideoUrl(item);
        mVfgt.play();
        updateOrRefreshUi();
    }
    
    
    private void updateOrRefreshUi(){
        mVfgt.positionDraw(mItem.location, Integer.parseInt(mItem.type));
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
                RulePraAct.this.finish();

            }
        });

        title_tv.setText(name);
    }

    @Override
    public void onClick(View btn) {
        switch (btn.getId()) {
        case R.id.rulepre_ibtn_eidt:
            if(btn.isSelected()){
                btn.setSelected(false);
                mRule.removeAllViews();
             updateOrRefreshUi();
                
            }else{
                btn.setSelected(true);
                initRule();
            }
            
            
        
            break;
        case R.id.rulepre_ibtn_play:
            mRule.removeAllViews();
            if(btn.isSelected()){
                btn.setSelected(false);
                mVfgt.stop();
            }else{
                btn.setSelected(true);
                mVfgt.play();
            }
            break;
        case R.id.rulepre_ibtn_delete:
            mRule.removeAllViews();
            
            break;

        default:
            break;
        }

    }
    
    

    @Override
    public void onChiooseType(int id) {
        mLlCenter.getChildAt(0).setSelected(true);
        DrawX drawx = mVfgt.getDrawX();
        drawx.type = -1;
        drawx.init();
        drawx.setDrawType(id);
    }

    @Override
    public void onLLBtn(int id, boolean[] bools) {
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

        
        //创建对象为对象赋值
        RuleInfo.Item it = new Item();
        it.id = mItem.id;
        it.url = mItem.url;
        it.type = id+"";
        it.source =mItem.source;
        it.ques = sb.toString();
        it.location = mVfgt.positionSave();
        int a= RuleInfo.updateDateByid(getApplicationContext(), it);
        showNotice(a>0?"更新成功":"更新失败");
        mItem = RuleInfo.findItemByid(getApplicationContext(), it.id);
        
        
        
    }

}
