package com.wh.ws.db;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.provider.BaseColumns;

public class RuleInfo {
    private static final String TAG = "RuleInfo ";
    public static final String TB_RULEINFO = "tb_ruleinfo";

    public static class Cols implements BaseColumns {
        public static final String URL = "url";
        public static final String SOURCE = "source";
        public static final String TYPE = "type";
        public static final String QUES = "ques";
        public static final String LOCATION = "location";
    }

    public static final class Item {
        public int id;
        public String url;
        public String source;
        public String type;
        public String location;
        public String ques;
    }

    public static void addWarnInfo(Context context, RuleInfo.Item item) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || item == null) {
            return;
        }
        ContentValues values = new ContentValues();
        values.put(Cols.URL, item.url);
        values.put(Cols.SOURCE, item.source);
        values.put(Cols.TYPE, item.type);
        values.put(Cols.LOCATION, item.location);
        values.put(Cols.QUES, item.ques);
        db.insert(TB_RULEINFO, null, values);

    }

    public static void deleteByid(Context context, RuleInfo.Item item) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || item == null) {
            return;
        }
        String sql = "delete from " + RuleInfo.TB_RULEINFO + " where " + RuleInfo.Cols._ID + "=" + item.id;

        db.execSQL(sql);
    }

    public static RuleInfo.Item findItemByid(Context context, int id) {

        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null) {
            return null;
        }

        String sql = "select * from " + TB_RULEINFO + " where " + RuleInfo.Cols._ID + "=" + id;

        Cursor cur = db.rawQuery(sql, null);
        if (cur == null) {

            return null;
        }
        RuleInfo.Item item1 = null;
        while (cur.moveToNext()) {
            item1 = new Item();
            item1.url = cur.getString(cur.getColumnIndex(RuleInfo.Cols.URL));
            item1.source = cur.getString(cur.getColumnIndex(RuleInfo.Cols.SOURCE));
            item1.type = cur.getString(cur.getColumnIndex(RuleInfo.Cols.TYPE));
            item1.ques = cur.getString(cur.getColumnIndex(RuleInfo.Cols.QUES));
            item1.id = cur.getInt(cur.getColumnIndex(RuleInfo.Cols._ID));
            item1.location = cur.getString(cur.getColumnIndex(RuleInfo.Cols.LOCATION));
        }
        return item1;

    }

    public static int updateDateByid(Context context,Item item){
       
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null) {
            return -1;
        }
        ContentValues values = new ContentValues();
        values.put(Cols.URL, item.url);
        values.put(Cols.SOURCE, item.source);
        values.put(Cols.TYPE, item.type);
        values.put(Cols.LOCATION, item.location);
        values.put(Cols.QUES, item.ques);
        int a = db.update(TB_RULEINFO, values, Cols._ID +" = "+ item.id+"", null);
        return a;
    }
    
    
    public static List<RuleInfo.Item> getAllWarnInfo(Context context) {

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
        String sql = "select * from " + RuleInfo.TB_RULEINFO;
        Cursor cur = db.rawQuery(sql, null);
        if (cur == null) {
            return null;
        }
        ArrayList<RuleInfo.Item> items = new ArrayList<RuleInfo.Item>();
        Item item = null;
        while (cur.moveToNext()) {
            item = new Item();
            item.url = cur.getString(cur.getColumnIndex(RuleInfo.Cols.URL));
            item.source = cur.getString(cur.getColumnIndex(RuleInfo.Cols.SOURCE));
            item.type = cur.getString(cur.getColumnIndex(RuleInfo.Cols.TYPE));
            item.ques = cur.getString(cur.getColumnIndex(RuleInfo.Cols.QUES));
            item.id = cur.getInt(cur.getColumnIndex(RuleInfo.Cols._ID));
            item.location = cur.getString(cur.getColumnIndex(RuleInfo.Cols.LOCATION));
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
