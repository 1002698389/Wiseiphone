#pragma  once

#ifndef __DATATYPE_SE
#define __DATATYPE_SE
typedef unsigned short U16;//2
typedef unsigned char U8;//1
typedef unsigned int U32;//4
typedef short S16;//2
typedef char S8;//1
typedef int S32;//4
#endif

#define MAXVANUM   1024
#define MAXSCENENUM 1
#define E_DEFAULT_DATALEN 1016
#define E_MAX_DATALEN 6000*1024
#define E_MAX_RULE_NUM 32

#define MAXSERVERNUM 8
#define MAXVACHNUM 64

//VA-------VA, VA- DM
typedef  enum msgVaKeyType
{
	key_va_pubkey,
	key_va_logon,
	key_va_logon_result,
	
	key_va_status_server,
	key_va_status_channel,
	key_va_status_tracker,

	key_va_content_stream,
	key_va_content_site,
	key_va_content_scene,         
	key_va_content_recorder,
	
	key_va_cmd_getstatus,
	key_va_cmd_interested,

	key_va_cmd_channel,      
	key_va_cmd_scene,
	key_va_cmd_tracker,
	key_va_cmd_rule,
	key_va_cmd_stream,

	key_va_data_video,
	key_va_data_motiondata,
	key_va_data_alert,
	key_va_data_picture,
	key_va_event_global,
	key_va_data_channel,
	key_va_cmd_global,
	key_va_data_global,
	key_va_keeplive
} MsgVaKey;

enum msgFlag
{
	msgflag_encrypted=1,
	msgflag_zlibed=2
};
#pragma pack(push, 1)
typedef struct vaHeader
{
	U8  key;//1
	U8  flag;//1
	S8  serverIndex;//1
	S8  chIndex;//1
	U32 msgLen;//4
}   VA_HEADER, *PVA_HEADER;
#define E_MAX_RSA_MODULUS_BITS 1024
#define E_MAX_RSA_MODULUS_LEN 132
#define E_MAX_RSA_PRIME_BITS 516
#define E_MAX_RSA_PRIME_LEN 68
#define E_MAX_SESSION_KEYLEN 256
#define E_MAX_NAMELEN 128
#define E_MODULE_LEN 128
#define E_MAX_RSA_STR_LEN  56
typedef struct vaPubkey
{
	VA_HEADER header;
	U16 bits;
	U16 pad;
	S8  protol[E_MAX_NAMELEN];
	U8  modulo[E_MAX_RSA_MODULUS_LEN];
	U8  exponent[E_MAX_RSA_MODULUS_LEN];
}   VA_PUBKEY, *PVA_PUBKEY;

typedef struct vaLogon  //this will encrypted use pubkey.
{
	VA_HEADER header;
	U16 sessionkeylen;
	U16 usrnamelen;
	U16 usrpasslen;
	U16 pad;
	S8  logonUsrName[E_MODULE_LEN];
	S8  logonUsrPassSHA1[E_MODULE_LEN];
	S8  sessionkey[E_MODULE_LEN];
}   VA_LOGON, *PVA_LOGON;
typedef struct vaLogonResult
{
	VA_HEADER header;
	int       logonResult;  //0 success, 1 fail.
	U32       usrPermi;    //logon user permission.
}   VA_LOGON_RESULT, *PVA_LOGON_RESULT;


typedef struct vaKeepAlive
{
	VA_HEADER header;
	U32       ti;
	U32        unUsed;
}   VA_KEEPALIVE, *PVA_KEEPALIVE;

typedef struct vaDataChannel
{
	VA_HEADER header;
	char      data[0];       
}   VA_DATA_CHANNEL, *PVA_DATA_CHANNEL;

typedef struct vaDataGlobal
{
	VA_HEADER header;
	char      data[0];       
}   VA_DATA_GLOBAL, *PVA_DATA_GLOBAL;

typedef enum serveronline
{
	serverstatus_online=1,
};

typedef enum channelstatus
{
	channelstatus_inited=1,
	channelstatus_started=2,
	channelstatus_recording=4,
	channelstatus_smartguarded=8,
	channelstatus_yuntanenbaled=16,
	channelstatus_multiscene=32,
	channelstatus_livestarted=64,
	channelstatus_hasgps=128,
	channelstatus_hasviewarea=256,
	channelstatus_signalok=512
};
typedef struct vaChInfo
{
	S32   chIndex;
	U32   chStatus;
	char chName[128];
}	VA_CHINFO;

typedef struct vaStatusServer
{
	VA_HEADER header;
	U32		  serverstatus;
	U32		  channelNum;	
	U32       serverDeviceType;
	char     serverDeviceID[E_MAX_NAMELEN*2];
	VA_CHINFO chInfo[MAXVACHNUM];
}   VA_STATUS_SERVER, *PVA_STATUS_SERVER;

typedef enum devicetype
{
	devicetype_hk
};

typedef enum channelvideo
{
	channel_videoencoding_h264=1,
	channel_videoencoding_mpeg4=2,
	channel_audioencoding_mp3=4,
	channel_audioencoding_vorbis=8
};

typedef enum cameratype
{
	cameraType_qiangji,
	cameraType_kuaiqiu
};

typedef enum scencestatus
{
	scenestatus_exist=1,
	scenestatus_smartguard=2,
	scenestatus_guardpaused=4,
	scenestatus_trainingmode=8
}   SCENESTATUS;

typedef enum sitestatus
{
	sitestatus_hasviewarea=1,
	sitestatus_fastportseted=2,
	sitestatus_planenabled=4
}   SITESTATUS;


typedef struct vaStatusSite
{
	int    siteIndex;
	int    siteStatus;
	int    smartMode;
	char  siteName[128];
	float  angelFrom;
	float  angelTo;
	float  axisFrom;
	float  axisTo;
	int    curSceneIndex;
	int    curSceneState;
}   VA_STATUS_SITE;



typedef struct vaStatusChannel
{
	VA_HEADER header;
	char  signalName[128];
	U32    channelStatus;
	U32    interestedFlag;
	U32    cameraType;
	double gps_lati;
	double gps_long;
	double gps_alt;           	
	//gps
	
	U32  curRecordStatus;
	S16  videoWidth;   //video width
	S16  videoHeight;  //video height
	S16  videoBitRate;
	S16  videoFrameRate;
	S16  audioBitRate;
	S16  audioSampleRate;
	U16  streamType;
	U16  streamEncoding;
	S32  propBright;
	S32  propContrast;
	S32  propHue;
	S32  propSaturation;
	//VA_STATUS_SITE sites[1];
	//fast port status
	//loop status
}   VA_STATUS_CHANNEL, *PVA_STATUS_CHANNEL;  //loop info?
typedef struct vaContentSite
{
	VA_HEADER header;//8
	S16  curSiteIndex;//2
	S16  totalSites;//2
	S16  siteIndex;//2
	S16  hasSiteData;//2
	S8   siteData[0];   //schedule
}   VA_CONTENT_SITE, *PVA_CONTENT_SITE;
typedef struct vaContentSteam
{
	VA_HEADER header;
	U32  streamFlag;
	S8   formatdata[0];
}   VA_CONTENT_STREAM, *PVA_CONTENT_STREAM ;//

typedef enum streamflag
{
	streamflag_h264=1,
	streamflag_h264_audio=2,
	streamflag_video_dx=4,
	streamfalg_audio_dx=8,
	streamflag_ffmpeg_video=16,
	streamflag_ffmepg_audio=32
};

typedef struct vaContentScene
{
	VA_HEADER header;
	S16 sceneIndex;
	S16 pad;
	S8  sceneData[0];
}   VA_CONTENT_SCENE, *PVA_CONTENT_SCENE ;//
typedef struct vaContentRecord
{
	VA_HEADER header;
	S8		  recordData[0];
}  VA_CONTENT_RECORD, *PVA_CONTENT_RECORD ;//

typedef enum rtpvided
{
	RTPVIDEOFLAG_SYNC=1<<1,
	RTPVIDEOFLAG_PREROLL=1<<2,
	RTPVIDEOFLAG_DISCON=1<<3,
	RTPVIDEOFLAG_VIDEO=1<<4,
	RTPVIDEOFLAG_AUDIO=1<<5,
	RTPVIDEOFLAG_DX=1<<20
}   ENUM_VIDEOFLAG;


typedef struct vaDataVideo
{
	VA_HEADER header;
	S32       frameType;
	S8        frameData[0];
}   VA_DATA_VIDEO, *PVA_DATA_VIDEO;
 enum statustype
{
	statustype_server=1,
	statustype_stream=2,
	statustype_channel=4,
	statustype_scene=8,
	statustype_recorder=16
};
typedef struct vaCmdGetStatus
{
	VA_HEADER header;
	U16       statusType;
	U16       statusFlag;
}   VA_CMD_GETSTATUS, *PVA_CMD_GETSTATUS; 


 enum interestedflag
{
	interestedflag_content=1,
	interestedflag_recordstate=2,  //send record detail
	interestedflag_streamdata=4,   //send stream detail
	interestedflag_scene=8,        //send scene detail
	interestedflag_motiondata=16,  //send motion data
	interestedflag_alertdata=32,    //send alert state
	interestedflag_picture=64,
    interestedflag_android=128
};
typedef enum interestedflag interetflag;
typedef struct vaCmdInterested
{
	VA_HEADER header;
	U32   interestedFlag;
}   VA_CMD_INTERESTED, *PVA_CMD_INTERESTED;
  
typedef struct vaCmdRule
{
	VA_HEADER header;
	S16 sceneIndex;
	S16 trackerIndex;
	S32 ruleID;
	S32 cmdType;
	S32 cmdParam;
	S8  cmdData[2048];
}   VA_CMD_RULE, *PVA_CMD_RULE;
typedef struct  vaCmdNewRule
{
    VA_HEADER header;
    S16 sceneIndex;
    S16 trackerIndex;
    S32 ruleID;
    S32 cmdType;
    S32 cmdParam;

}VA_CMD_NEWRULE,PVA_CMD_NEWRULE;

typedef enum cmdrule
{
	cmdrule_addrule,
	cmdrule_delrule,
	cmdrule_enablerule,
	cmdrule_disablerule,
	cmdrule_updaterule
};

typedef struct vaCmdScene
{
	VA_HEADER header;
	S16 siteIndex;
	S16 sceneIndex;

	S32 cmdType;
	S32 cmdParam;
	S8  cmdData[0];
}   VA_CMD_SCENE, *PVA_CMD_SCENE;

typedef struct vaCmdGlobal
{
	VA_HEADER header;
	S8  cmdData[0];
}   VA_CMD_GLOBAL, *PVA_CMD_GLOBAL;
typedef enum cmdscene
{
	cmdscene_addscene,
	cmdscene_delscene,
	cmdscene_setactive,
	cmdscene_updatescene
}  ;

typedef struct vaCmdChannel
{
	VA_HEADER header;//8 header.key=key_va_cmd_rule;header.flag=0;header.serverindex=0;header.chindex=0;header.msglen=sizeof(va_cmd_rule)
	U32    cmdType;//4 cmdrule_addrule
	U32    cmdParam;//4 cmdparam=0;
	U32    cameraType;//4
	char  signalName[128];//128
	U32    channelStatus;//4
	double gps_lati;//4
	double gps_long;//4
	double gps_alt; //4
	float viewArea_begin;//4
	float viewArea_end;//4
	float viewArea_axis;//4
	float viewArea_axisTo;//4
	S16  siteIndex;//4
	//gps

	S16  curSceneTrackMode;//4
	U32  curRecordStatus;//4

	S16  videoWidth;   //video width//4
	S16  videoHeight;  //video height//4

	S16  videoBitRate;//4

	S16  videoFrameRate;//4

	S16  audioBitRate;//4
	S16  audioSampleRate;//4

	U16  streamType;//4
	U16  streamEncoding;//4

	S32  propBright;//4
	S32  propContrast;//4
	S32  propHue;//4
	S32  propSaturation;//4
	//S8   cmdData[512];
  
}   VA_CMD_CHANNEL, *PVA_CMD_CHANNEL;
 enum cmdchannel
{
	cmdchannel_start,
	cmdchannel_stop,
	cmdchannel_updateparam,
	cmdchannel_startrecord,
	cmdchannel_updaterecord,
	cmdchannel_stoprecord,
	cmdchannel_callfastport,
	cmdchannel_delfastport,
	cmdchannel_savefastport,
	cmdchannel_addfastport,
	cmdchannel_setloopindex,
	cmdchannel_addloop,
	cmdchannel_delloop,
	cmdchannel_smartschedule_start,
	cmdchannel_smartschedule_stop,
	cmdchannel_smart_start,
	cmdchannel_smart_stop,
	cmdchannel_yuntai_start,
	cmdchannel_yuntai_stop,
	cmdchannel_yuntai_command,
	cmdchannel_smartschedule_update,
	cmdchannel_recordparam_change,
	cmdchannel_ptzsetmode,
	cmdchannel_ptzsettarget,
	cmdchannel_ptzsetparam,
	cmdchannel_setvideomaprelat
} ;
typedef enum cmdchannelparam
{
	cmdchannel_param_chname=1,
	cmdchannel_param_gps=  (1<<1),
	cmdchannel_param_viewarea=(1<<2),
	cmdchannel_param_cameratype=(1<<3),
	cmdchannel_param_prop=(1<<4)
};

typedef struct vaCmdStream
{
	VA_HEADER header;
	S32 cmdType;
	S32 cmdParam;
	S32 cmdParam2;
	S32 cmdParam3;
}  VA_CMD_STREAM, PVA_CMD_STREAM;

typedef enum cmdstream
{
	cmdstream_sendkeyframe=1,
	cmdstream_setbitrate=2,
	cmdstream_setframerate=4
} ;
//tracker.
typedef struct vaCmdTracker
{
	VA_HEADER header;
	S32 cmdType;
	S32 cmdParam;
	S8  cmdData[0];
}   VA_CMD_TRACKER, *PVA_CMD_TRACKER;


typedef enum seRuleFlag
{
	ruleflag_disable=1,
	ruleflag_voilated=2
}   seRuleFlag;
typedef struct _ruleInfo
{
	int          ruleID;
	int          ruleFlag;
	int        m_firstViolatedTime;
	int        m_lastViolatedTime;
	int	      m_nTotalRunningTime;
	int        m_nLastStartTime;
	int          m_nViolatedCount;
	int          m_ruleParam[4];
}	VA_RULEINFO;

typedef struct vaTrackTargetRect
{
	float x;
	float y;
	float w;
	float h;
} vaTrackTargetRect;
typedef struct vaPtzTrackStatus
{
	float  x;
	float  y;
	float  w;
	float  h;
	float  confidence;

	vaTrackTargetRect   trackObjRect;
	double   mats[6];

	short    trackTargetSeted;
	short    trackObjID;

	short    trackType;   //track mode
	short    trackState;      
	short    trackRunStage;
	short    objType;
	
	short    trackFrameProcessed;
	short    stopType;      //stop type
	
	short    stopTimeLimit; //in seconds
	short    trackStyle;

	short    trackZoomSpeed;
	short    trackMoveSpeed;
}   VA_PTZTRACK_STATUS;
typedef struct vaStatusTracker   //if in 
{
	VA_HEADER header;
	S16 sceneIndex;
	S16 trackerIndex;
	U32 trackerStatus;
	int linMinDuSize;
	int linMinDuBrightNess;
	int ruleCount;
	VA_PTZTRACK_STATUS ptzStatus;
	U8  ruleStatus[E_MAX_RULE_NUM];
	VA_RULEINFO rInfo[0];
}   VA_STATUS_TRACKER, *PVA_STATUS_TRACKER;

typedef struct vaDataAlert
{
  
	VA_HEADER	  header;
	S16           siteIndex;
	S16           sceneIndex;
	S16           trackerIndex;
	int           ruleID;
	int          alertFlag;
	int         alertTime;
	int          objID;
	int          eventType;
	int          targeType;
	int           objType;
	int           processFlag;
	int          level;
	char         ruleName[128];
	char         desc[128];
	char         picFileName[128];
}   VA_DATA_ALERT, *PVA_DATA_ALERT;

typedef struct vaDataPicture
{
	VA_HEADER	  header;
	S16           sceneIndex;
	S16           trackerIndex;
	char         picFileName[128];
	S16           partIndex;
	S16           totalParts;
	//S8            picData[0];
}   VA_DATA_PICTURE, *PVA_DATA_PICTURE;
//status 
typedef struct _objInfo
{
	U8    objID;
	U8    objType;
	U8    createSource;
	U8    frameStatus;
	U8   objTypeDetect;
	U8   sailence;
	U16  alertState;
	float confi;
	float x;
	float y;
	float w;
	float h;
	float velocityX;
	float velocityY;
}	VAOBJ_INFO, *PVAOBJ_INFO;
typedef struct vaDataMotionObj
{
	VA_HEADER	  header;
	S16           sceneIndex;
	S8            trackerIndex;
	U8   		  objectNum;
	VAOBJ_INFO    objInfos[0];
}   VA_DATA_MOTIONOBJ, *PVA_DATA_MOTIONOBJ;

typedef struct vaEventGlobal
{
	VA_HEADER	  header;
	S16           siteIndex;
	S16           sceneIndex;
	S16           trackerIndex;
	S16           ruleID;
	int          globalEventType;
}  VA_EVENT_GLOBAL, *PVA_EVENT_GLOBAL;
typedef struct cmdRoute
{
    VA_HEADER header;
    int cmdType;
    int cmdParam;
    int siteIndex;
//    cmdChannel={0};
//    cmdChannel.header.chIndex=iSignalIndex;
//    cmdChannel.header.serverIndex=0;
//    cmdChannel.header.flag=0;
//    cmdChannel.header.key=key_va_cmd_channel;
//    cmdChannel.header.msgLen=sizeof(VA_CMD_CHANNEL);
//    cmdChannel.cmdType=cmdchannel_smart_start/cmdchannel_smart_stop;
//    cmdChannel.cmdParam=0;
//    cmdChannel.siteIndex=siteIndex;
    
    
} VA_ROUTE_OPEN,*PVA_EVENT_OPEN;
typedef enum
{
	globalevent_signal_lost=0,
	globalevent_signal_restore=1,
	globalevent_signal_scenechange=2
}  EnumGlobalEvent;
typedef union vaUnion
{
	VA_HEADER header;
	

	VA_KEEPALIVE keepalive;
	VA_STATUS_CHANNEL status_channel;
	VA_STATUS_SERVER status_server;
	VA_STATUS_TRACKER status_tracker;
	
	VA_CONTENT_SITE content_site;
	VA_CONTENT_SCENE content_scene;
	VA_CONTENT_RECORD content_record;
	VA_CONTENT_STREAM content_stream;

	VA_CMD_GETSTATUS cmd_getstatus;
	VA_CMD_INTERESTED cmd_interested;
	VA_CMD_TRACKER cmd_tracker;
	VA_CMD_RULE cmd_rule;
	VA_CMD_SCENE cmd_scene;
	VA_CMD_CHANNEL cmd_channel;
	VA_CMD_STREAM  cmd_stream;
	VA_CMD_GLOBAL  cmd_global;

	VA_PUBKEY pubkey;
	VA_LOGON logon;
	VA_LOGON_RESULT   logonresult;
	VA_DATA_CHANNEL   data_channel;
	VA_DATA_GLOBAL    data_global;
	VA_DATA_VIDEO     data_video;
	VA_DATA_ALERT     data_alert;
	VA_DATA_MOTIONOBJ data_motionobj;
	VA_DATA_PICTURE   data_picture;
	VA_EVENT_GLOBAL   event_global;
}   VA_MSG, *PVA_MSG;



//DM-- CP, DM-- DP
typedef struct ccHeader
{
	U16 key;
	U16 flag;
	U32 msgLen;
} CC_HEADER, *PCC_HEADER;

typedef union ccMsg
{
	CC_HEADER header;

}  CC_MSG, *PCC_MSG;


//RC
typedef struct rcHeader
{
	U16 key;
	U16 flag;
	U32 msgLen;
} RC_HEADER, *PRC_HEADER;

typedef union rcMsg
{
	RC_HEADER header;
}  RC_MSG, *PRC_MSG;
#pragma pack(pop)