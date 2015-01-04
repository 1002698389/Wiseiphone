package com.wh.ws.ob;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;

public class VdManager {
    public List<RadioPrent> parent = null;
    public Map<String, List<RadioChiid>> child = null;
    public List<RadioChiid> childList = null;

    public VdManager() {
        parent = new ArrayList<RadioPrent>();
        child = new HashMap<String, List<RadioChiid>>();
    }

    public void addParent(RadioPrent s) {
        parent.add(s);
        childList = new ArrayList<VdManager.RadioChiid>();
        child.put(s.asName, childList);
        
    }

    public void addChild(String p, RadioChiid c) {
        boolean bool = false;
        for (RadioPrent pq : parent) {
            if (p.equals(pq.asName)) {
                bool = true;
                break;
            }
        }
        if (bool) {
            bool=false;
            List<RadioChiid> clist = (List<RadioChiid>) child.get(p);
            clist.add(c);
        } else {
            Log.d("ERRER", "无效的父节点");
        }
    }

    public List<RadioPrent> getP() {
        return parent;
    }

    public Map<String, List<RadioChiid>> getC() {

        return child;
    }

   public RadioChiid getchild(int p1,int c1){
       
       String id = parent.get(p1).asName;
       List<RadioChiid> clist = (List<RadioChiid>)child.get(id);
       
       return  clist.get(c1);
       
   }
   
   public List<RadioChiid> getChildList(int pos){
       
       String id = parent.get(pos).asName;
       List<RadioChiid> clist = (List<RadioChiid>)child.get(id);
       return clist;
       
   }
   
    
    
    public static class RadioChiid {
      public  String asName;
      public  String type;
      public  int port;
      public  String name;
      public  String password;
      public  String url;
      public  boolean isPlay;
      public  int vdPos;
    }

    public static class RadioPrent {
        public String asName;
        public String ip;

    }
    
    public static class ChiooseItem implements Serializable{
        /**
         * 
         */
        public String name;
        public String url;
        

      
        
    }
    
    
}
