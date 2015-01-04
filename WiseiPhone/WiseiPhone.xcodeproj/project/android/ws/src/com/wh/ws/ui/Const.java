package com.wh.ws.ui;

//该类记录一些全局变量
public class Const {
   //屏幕规格常量
    public static final int JK_4S= 4 ;
    public static final int JK_1S= 1 ;
   
   //播放流地址
    public static final String V_V1 = "rtsp://218.204.223.237:554/live/1/66251FC11353191F/e7ooqwcfbqjoo80j.sdp";
    public static final String V_OFFICE = "rtsp://192.168.1.161/1.sdp"; 
    public static final String V_DOOR   = "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?";
    //储存卡地址                                                     
    public static String sdCardPath="";
    //屏幕的宽高
    public static int WIGHT = 0;
    public static int HIGHT = 0;
    //屏幕分布有三个布局。通常只显示两个
    public static int base_w = 0;
    public static int base_h = 0;
 
    
    //activity id
    public static final String ACT_0 = "act_y1";
    public static final String ACT_1 = "act_y2";
    public static final String ACT_2 = "act_y3";
    public static final String ACT_3 = "act_y4";
    public static final String ACT_5 = "act_y5";
    
    //密码开关
    public static boolean KG = false;
    
    public static boolean SCROOL = false;
    
}
