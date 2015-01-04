package com.wh.ws.utill;

import com.wh.ws.R;
import com.wh.ws.ui.MainActivity;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.opengl.Visibility;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebView.FindListener;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

public class UtillViewRule implements OnClickListener {
    private static UtillViewRule myUtill;
    private Context mContext;
    private static LayoutInflater mInflater;
    private RelativeLayout rl1, rl2, rl3;
    private LinearLayout mImgs;
    private Builder mD1, mD2;
    private AlertDialog md1, md2;
    public static final String[] mS = new String[] { "������", "˫�ؾ�����", "����ָ������", "�뿪ָ������", "����������ʧ��", "��������������", "����ֹͣ",
            "�����뿪", "�˶��������", };
    public static final String[] mF = new String[] { "ʵʱ��־", "��ͼ", "��������¼��", "��������" };
    private View rule;
    private int cur = 0;
    private boolean[] bools;
    private OnChioose onch;

    public UtillViewRule(Context context) {
        this.mContext = context;
        mInflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        // initDialog();

    }

    public static UtillViewRule getInstance(Context context) {
        myUtill = new UtillViewRule(context);

        return myUtill;
    }

    private void initDialog(Activity ac) {

        mD1 = null;
        mD2 = null;

        mD1 = new AlertDialog.Builder(ac).setTitle("ѡ������").setIcon(android.R.drawable.ic_dialog_info)
                .setSingleChoiceItems(mS, 0, new android.content.DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // TODO Auto-generated method stub

                        cur = which;
                    }
                }).setPositiveButton("ȷ��", new android.content.DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        ((TextView) rl1.getChildAt(0)).setText(mS[cur]);
                        if (onch != null) {
                            onch.onChiooseType(cur + 1);
                        }

                    }
                });
        md1 = mD1.create();

        bools = new boolean[] { false, false, false, false };

        mD2 = new AlertDialog.Builder(ac).setTitle("ѡ������").setIcon(android.R.drawable.ic_dialog_info)
                .setMultiChoiceItems(mF, bools, new android.content.DialogInterface.OnMultiChoiceClickListener() {

                    @Override
                    public void onClick(DialogInterface arg0, int arg1, boolean arg2) {
                        bools[arg1] = arg2;

                    }
                }).setPositiveButton("ȷ��", new android.content.DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        for (int i = 0; i < mImgs.getChildCount(); i++) {
                            mImgs.getChildAt(i).setVisibility(bools[i] ? View.VISIBLE : View.GONE);
                        }
                        md2.cancel();
                    }
                });
        md2 = mD2.create();
    }

    private void init() {
        rule = mInflater.inflate(R.layout.rule_item, null);

        rl1 = (RelativeLayout) rule.findViewById(R.id.rule_item_step1);
        rl2 = (RelativeLayout) rule.findViewById(R.id.rule_item_step2);
        rl3 = (RelativeLayout) rule.findViewById(R.id.rule_item_step3);
        rl1.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {

                md1.show();
            }
        });
        rl2.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                // TODO Auto-generated method stub
                md2.show();
                //

            }
        });
        rl3.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View arg0) {
                if (cur < 0 || cur > 9) {
                    Toast.makeText(mContext, "��ѡ������", 1).show();
                    return;
                }
                if (bools[0] || bools[1] || bools[2] || bools[3]) {

                    onch.onLLBtn(cur, bools);
                } else {
                    Toast.makeText(mContext, "��ѡ������", 1).show();
                    return;
                }

            }
        });

        mImgs = (LinearLayout) rl2.getChildAt(0);

    }

    @Override
    public void onClick(View arg0) {
        // TODO Auto-generated method stub

    }

    public void setOnChooiseLinsener(OnChioose on) {
        this.onch = on;

    }

    public View getRuleView(Activity ac) {
        init();
        initDialog(ac);
        return rule;
    }

    public interface OnChioose {

        public void onChiooseType(int id);

        void onLLBtn(int id, boolean[] bools);
    }

    // ��Թ���������ṩһЩ���÷���
    //��һ�㣬���ݱ���ı���״̬ˢ�½���
    public void setClfa(String s) {
        boolean[] bo = new boolean[4];
        String[] sbs = s.split("\\.");
        for(int i =0;i<sbs.length;i++){
            bo[i] = sbs[i].equals("1")?true:false;
        }
         for (int i = 0; i < mImgs.getChildCount(); i++) {
            mImgs.getChildAt(i).setVisibility(bo[i] ? View.VISIBLE : View.GONE);
        }
    }
    
    //�ڶ��㣬���ݱ���Ĺ�������ʹ���Ӧ��ʾ�Ѿ����������
    public void setSaveType(int type){
        ((TextView) rl1.getChildAt(0)).setText(mS[type]);
    }

}
