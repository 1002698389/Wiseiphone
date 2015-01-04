
package com.wh.ws.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DbHelper extends SQLiteOpenHelper {

    private static final String DB_NAME = "db_myjk";
    private static final int DB_VER = 1;

    private static DbHelper sInstance;
    
    private static Context mContext;
    
    public synchronized static DbHelper getInstance(Context context) {
        if (sInstance == null) {
            DbHelper.mContext = context;
            sInstance = new DbHelper(context);
        }
        return sInstance;
    }

    private DbHelper(Context context) {
        super(context, DB_NAME, null, DB_VER);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
    
        createWarnInfoTable(db);
        createRuleInfoTable(db);
        createCameraTable(db);
    }
    
	@Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL("delete from"+WarnInfo.TB_WARNINFO);
		db.execSQL("delete from"+RuleInfo.TB_RULEINFO);
		  db.execSQL("delete from"+CameraInfo.TB_CAMERAINFO);
    }



	private void createWarnInfoTable(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE " + WarnInfo.TB_WARNINFO + " ("
                + WarnInfo.Cols._ID + " INTEGER PRIMARY KEY,"
                + WarnInfo.Cols.IMGURL + " TEXT,"
                + WarnInfo.Cols.SOURCE + " TEXT,"
                + WarnInfo.Cols.TIME + " TEXT,"
                + WarnInfo.Cols.TYPE + " TEXT"
                + ");");
	}
	private void createCameraTable(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE " + CameraInfo.TB_CAMERAINFO + " ("
                + WarnInfo.Cols._ID + " INTEGER PRIMARY KEY,"
                + CameraInfo.Cols.DATA + " TEXT,"
                + CameraInfo.Cols.TYPE + " TEXT,"
                + CameraInfo.Cols.URL + " TEXT "
                + ");");
    }
	
	   private void createRuleInfoTable(SQLiteDatabase db) {
	        db.execSQL("CREATE TABLE " + RuleInfo.TB_RULEINFO + " ("
	                + RuleInfo.Cols._ID + " INTEGER PRIMARY KEY,"
	                + RuleInfo.Cols.URL + " TEXT,"
	                + RuleInfo.Cols.SOURCE + " TEXT,"
	                + RuleInfo.Cols.LOCATION + " TEXT,"
	                + RuleInfo.Cols.QUES + " TEXT,"
	                + RuleInfo.Cols.TYPE + " TEXT"
	                + ");");
	    }

  
}
