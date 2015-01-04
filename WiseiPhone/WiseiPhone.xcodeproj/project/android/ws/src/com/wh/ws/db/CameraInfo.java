package com.wh.ws.db;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.provider.BaseColumns;
import android.widget.Toast;

public class CameraInfo {
    private static final String TAG = "CameraInfo ";
    public static final String TB_CAMERAINFO = "tb_camerainfo";
    
    public static final String TYPE_IMAGE = "1";
    public static final String TYPE_VIDEO = "2";

    public static class Cols implements BaseColumns {
        public static final String URL = "url";
        public static final String DATA = "data";
        public static final String TYPE = "type";
    }

    public static final class Item {
        public int id;
        public String url;
        public String type;
        public String data;
    }

    public static void AddCameraInfo(Context context, CameraInfo.Item item) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || item == null) {
            return;
        }
        ContentValues values = new ContentValues();
        values.put(Cols.URL, item.url);
        values.put(Cols.TYPE, item.type);
        values.put(Cols.DATA, item.data);
        db.insert(TB_CAMERAINFO, null, values);
        Toast.makeText(context, "一行数据更新", 1).show();
    }

    public static void deleteByid(Context context, CameraInfo.Item item) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || item == null) {
            return;
        }
        String sql = "delete from " + CameraInfo.TB_CAMERAINFO + " where " + CameraInfo.Cols._ID + "=" + item.id;

        db.execSQL(sql);
    }

    public static CameraInfo.Item findItemByid(Context context, int id) {

        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null) {
            return null;
        }

        String sql = "select * from " + TB_CAMERAINFO + " where " + CameraInfo.Cols._ID + "=" + id;

        Cursor cur = db.rawQuery(sql, null);
        if (cur == null) {

            return null;
        }
        CameraInfo.Item item1 = null;
        while (cur.moveToNext()) {
            item1 = new Item();
            item1.url = cur.getString(cur.getColumnIndex(CameraInfo.Cols.URL));
            item1.type = cur.getString(cur.getColumnIndex(CameraInfo.Cols.TYPE));
            item1.id = cur.getInt(cur.getColumnIndex(CameraInfo.Cols._ID));
            item1.data = cur.getString(cur.getColumnIndex(CameraInfo.Cols.DATA));
        }
        return item1;

    }

//    public static int updateDateByid(Context context,Item item){
//       
//        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
//        if (db == null) {
//            return -1;
//        }
//        ContentValues values = new ContentValues();
//        values.put(Cols.URL, item.url);
//        values.put(Cols.SOURCE, item.source);
//        values.put(Cols.TYPE, item.type);
//        values.put(Cols.LOCATION, item.location);
//        values.put(Cols.QUES, item.ques);
//        int a = db.update(TB_RULEINFO, values, Cols._ID +" = "+ item.id+"", null);
//        return a;
//    }
    
    public static List<String> getDate(Context context) {

        // ArrayList<RuleInfo.Item> items = new ArrayList<RuleInfo.Item>();
        // Item item;
        // for (int i = 0; i < 30; i++) {
        // item = new Item();
        // item.source = "大门口";
        // item.time = "2020240204";
        // item.type = "你好中国";
        // items.add(item);
        // }
        // return items;

        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null) {
            return null;
        }
        String sql = "select "+CameraInfo.Cols.DATA+" from " + CameraInfo.TB_CAMERAINFO + " group by "+CameraInfo.Cols.DATA
                      +" order by "+ CameraInfo.Cols._ID+" desc";
        Cursor cur = db.rawQuery(sql, null);
        if (cur == null) {
            return null;
        }
        ArrayList<String> items = new ArrayList<String>();
       String it;
        while (cur.moveToNext()) {
            it = cur.getString(cur.getColumnIndex(CameraInfo.Cols.DATA));
            items.add(it);
        }
        
        return items;
    }

    // public static List<RuleInfo.Item> deleteByData(Context context,
    // ArrayList<Item> items) {
    // SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
    // if (db == null || items == null) {
    // return null;
    // }
    // if (items.size() == 0) {
    // return null;
    // }
    // ArrayList<Item> item1 = new ArrayList<Item>();
    // for (int i = 0; i < items.size(); i++) {
    // if (items.get(i).isDelete) {
    //
    // item1.add(items.get(i));
    // }
    //
    // }
    // items.removeAll(item1);
    //
    // return items;
    // // for (int i = 0; i < items.size(); i++) {
    // //
    // // if (items.get(i).isDelete) {
    // // db.execSQL(" delete from tb_warninfo where time = " +
    // // items.get(i).time);
    // // }
    // //
    // // }
    // }

    
    
    
    public static List<CameraInfo.Item> getAllByDate(Context context,String data) {

        // ArrayList<RuleInfo.Item> items = new ArrayList<RuleInfo.Item>();
        // Item item;
        // for (int i = 0; i < 30; i++) {
        // item = new Item();
        // item.source = "大门口";
        // item.time = "2020240204";
        // item.type = "你好中国";
        // items.add(item);
        // }
        // return items;

        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null) {
            return null;
        }
        String sql = "select * from " + CameraInfo.TB_CAMERAINFO +
                     " where " +CameraInfo.Cols.DATA +" like '%"+ data+"%'";
        Cursor cur = db.rawQuery(sql, null);
        if (cur == null) {
            return null;
        }
        ArrayList<CameraInfo.Item> items = new ArrayList<CameraInfo.Item>();
        Item item = null;
        while (cur.moveToNext()) {
            item = new Item();
            item.url = cur.getString(cur.getColumnIndex(CameraInfo.Cols.URL));
            item.type = cur.getString(cur.getColumnIndex(CameraInfo.Cols.TYPE));
            item.id = cur.getInt(cur.getColumnIndex(CameraInfo.Cols._ID));
            item.data = cur.getString(cur.getColumnIndex(CameraInfo.Cols.DATA));
            items.add(item);
        }
        return items;
    }

    // public static List<RuleInfo.Item> deleteByData(Context context,
    // ArrayList<Item> items) {
    // SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
    // if (db == null || items == null) {
    // return null;
    // }
    // if (items.size() == 0) {
    // return null;
    // }
    // ArrayList<Item> item1 = new ArrayList<Item>();
    // for (int i = 0; i < items.size(); i++) {
    // if (items.get(i).isDelete) {
    //
    // item1.add(items.get(i));
    // }
    //
    // }
    // items.removeAll(item1);
    //
    // return items;
    // // for (int i = 0; i < items.size(); i++) {
    // //
    // // if (items.get(i).isDelete) {
    // // db.execSQL(" delete from tb_warninfo where time = " +
    // // items.get(i).time);
    // // }
    // //
    // // }
    // }
}
