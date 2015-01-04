package com.wh.ws.utill;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.wh.ws.db.CameraInfo;
import com.wh.ws.ui.Const;


import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.DownloadManager;
import android.app.DownloadManager.Request;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Rect;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Environment;
import android.view.View;
import android.widget.SimpleAdapter;
import android.widget.Toast;

@SuppressLint("SimpleDateFormat")
public class UtillTool {
    private static UtillTool mUtillTool;
    private Context mContext;
    long id;
    private UtillTool(Context ct) {
        this.mContext = ct;
        mContext.registerReceiver(bro, in);
        getDir();
    }

    public static UtillTool getInstace(Context ct) {
        if (mUtillTool == null) {
            mUtillTool = new UtillTool(ct);
            
        }
        return mUtillTool;
    }
    
    @SuppressLint("NewApi")
    public void downloadImg(String url,String str){
        url = "http://count.liqucn.com/d.php?id=194062&ArticleOS=Android&content_url=http://www.liqucn.com/yx/194062.shtml&down_url=kpa.uqil_kpa.slewejpop/ihziy/3102/daolpu/moc.ncuqil.elif//:ptth&is_cp=1&Pink=2&from_type=web";
               
        DownloadManager dm = (DownloadManager)mContext.getSystemService(Context.DOWNLOAD_SERVICE);
        
        DownloadManager.Request request = new Request(Uri.parse(url));
        
        request.setDestinationInExternalPublicDir("/wanghui", "img.jpg");
       // request.setDestinationUri(uri)
        
        request.setTitle("下载中");
        request.setDescription("zhengzhaixiazai");
        
        
         id = dm.enqueue(request);
        
    }
    
    IntentFilter in = new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE);
    BroadcastReceiver bro = new BroadcastReceiver() {
        
        @Override
        public void onReceive(Context context, Intent intent) {
            // TODO Auto-generated method stub
            long a = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1);
            if(a==id){
             
                Toast.makeText(mContext, "xiazaiwanc", 1).show();
            }
            
        }
    };
    
//    public Bitmap getBitmapByScreen(Activity ac){
//        Rect re = new Rect();
//        ac.getWindow().getDecorView().getWindowVisibleDisplayFrame(re);
//        View v = ac.getWindow().getDecorView();
//        v.setDrawingCacheEnabled(true);
//        Bitmap bi = v.getDrawingCache();
//        Bitmap bit =Bitmap.createBitmap(bi, 0,re.top, Const.width,Const.HIGHT-re.top);
//        return bit;
//    }
    public void saveBitmap(String dec,Bitmap bit,String name){
        try {
            if(name == null){
                Date date = new Date(System.currentTimeMillis());
                SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd:hh:mm:ss");
                name = sp.format(date);
            }
           String path = Const.sdCardPath+File.separator+name+".jpg";
           File f = new File(path);
           if(!f.exists()){
               f.createNewFile();
           }
           BufferedOutputStream bout = new BufferedOutputStream(new FileOutputStream(f));
           bit.compress(Bitmap.CompressFormat.JPEG, 60, bout);
           bout.flush();
           bout.close();
           
           CameraInfo.Item item = new CameraInfo.Item();
           item.data = name.substring(0,name.indexOf(":"));
           
           item.url = path;
           
           item.type =CameraInfo.TYPE_IMAGE;
           
           CameraInfo.AddCameraInfo(mContext, item);
           Toast.makeText(mContext, "保存成功,位置"+f.getPath(), 1).show();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public void getDir(){
        if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
            File f = new File(Environment.getExternalStorageDirectory().getPath()+File.separator+"wanghui");
            if(!f.exists() || !f.isDirectory()){
                f.mkdirs();
            }
            Const.sdCardPath = f.getPath();
        }
    }

}
