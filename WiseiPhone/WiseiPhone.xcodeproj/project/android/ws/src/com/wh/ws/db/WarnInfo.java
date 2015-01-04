package com.wh.ws.db;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.provider.BaseColumns;

public class WarnInfo {
    private static final String TAG = "WarnInfo ";
    public static final String TB_WARNINFO = "tb_warninfo";

    public static class Cols implements BaseColumns {
        public static final String IMGURL = "imgurl";
        public static final String SOURCE = "source";
        public static final String TIME = "time";
        public static final String TYPE = "type";
    }

    public static final class Item {
        public String imgurl;
        public String source;
        public String time;
        public String type;
        public boolean isDelete = false;
    }

    public static void addWarnInfo(Context context, WarnInfo.Item item) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || item == null) {
            return;
        }
        ContentValues values = new ContentValues();
        values.put(Cols.IMGURL, item.imgurl);
        values.put(Cols.SOURCE, item.source);
        values.put(Cols.TIME, item.time);
        values.put(Cols.TYPE, item.type);
        db.insert(TB_WARNINFO, null, values);

    }

    public static List<WarnInfo.Item> getAllWarnInfo(Context context) {

        ArrayList<WarnInfo.Item> items = new ArrayList<WarnInfo.Item>();
        Item item;
        for (int i = 0; i < 30; i++) {
            item = new Item();
            item.source = "大门口";
            item.time = "2020240204";
            item.type = "你好中国";
            items.add(item);
        }
        return items;

        // SQLiteDatabase db =
        // DbHelper.getInstance(context).getWritableDatabase();
        // if (db == null) {
        // return null;
        // }
        // String sql = "select * from " + WarnInfo.TB_WARNINFO;
        // Cursor cur = db.rawQuery(sql, null);
        // if (cur == null) {
        // return null;
        // }
        // ArrayList<WarnInfo.Item> items = new ArrayList<WarnInfo.Item>();
        // Item item = null;
        // while (cur.moveToNext()) {
        // item = new Item();
        // item.imgurl =
        // cur.getString(cur.getColumnIndex(WarnInfo.Cols.IMGURL));
        // item.source =
        // cur.getString(cur.getColumnIndex(WarnInfo.Cols.SOURCE));
        // item.time = cur.getString(cur.getColumnIndex(WarnInfo.Cols.TIME));
        // item.type = cur.getString(cur.getColumnIndex(WarnInfo.Cols.TYPE));
        // items.add(item);
        // }
        // return items;
    }

    public static List<WarnInfo.Item> deleteByData(Context context, ArrayList<Item> items) {
        SQLiteDatabase db = DbHelper.getInstance(context).getWritableDatabase();
        if (db == null || items == null) {
            return null;
        }
        if (items.size() == 0) {
            return null;
        }
        ArrayList<Item> item1 = new ArrayList<Item>();
        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).isDelete) {

                item1.add(items.get(i));
            }

        }
        items.removeAll(item1);

        return items;
        // for (int i = 0; i < items.size(); i++) {
        //
        // if (items.get(i).isDelete) {
        // db.execSQL(" delete from tb_warninfo where time = " +
        // items.get(i).time);
        // }
        //
        // }
    }
}
