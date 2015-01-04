#pragma  once

#ifndef __DATATYPE_SE
#define __DATATYPE_SE
typedef unsigned short U16;
typedef unsigned char U8;
typedef unsigned int U32;
typedef short S16;
typedef char S8;
typedef int S32;
#endif

#define MAXVANUM   1024
#define MAXSCENENUM 1
#define E_DEFAULT_DATALEN 1016
#define E_MAX_DATALEN 6000*1024
#define E_MAX_RULE_NUM 32

#define MAXSERVERNUM 8
#define MAXVACHNUM 64

//VA-------VA, VA- DM
enum msgVaKeyType
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
};

enum msgFlag
{
	msgflag_encrypted=1,
	msgflag_zlibed=2
};
#pragma pack(push, 1)

struct vaHeader {
    unsigned char  key;
	unsigned char  flag;
	char  serverIndex;
	char  chIndex;
	unsigned int msgLen;
};
typedef struct vaHeader VA_HEADER;

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


struct vaLogon {
    VA_HEADER header;
    unsigned short sessionkeylen;
	unsigned short usrnamelen;
	unsigned short usrpasslen;
	unsigned short pad;
	char  logonUsrName[E_MODULE_LEN];
	char  logonUsrPassSHA1[E_MODULE_LEN];
	char  sessionkey[E_MODULE_LEN];
};
typedef struct vaLogon VA_LOGON;


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

typedef enum
{
	serverstatus_online=1,
};

typedef enum
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
//typedef struct vaChInfo
//{
//	S32   chIndex;
//	U32   chStatus;
//	TCHAR chName[64];
//}	VA_CHINFO;

//typedef struct vaStatusServer
//{
//	VA_HEADER header;
//	U32		  serverstatus;
//	U32		  channelNum;	
//	U32       serverDeviceType;
//	TCHAR     serverDeviceID[E_MAX_NAMELEN];
//	VA_CHINFO chInfo[MAXVACHNUM];
//}   VA_STATUS_SERVER, *PVA_STATUS_SERVER;

typedef enum
{
	devicetype_hk
};

typedef enum
{
	channel_videoencoding_h264=1,
	channel_videoencoding_mpeg4=2,
	channel_audioencoding_mp3=4,
	channel_audioencoding_vorbis=8
};

typedef enum
{
	cameraType_qiangji,
	cameraType_kuaiqiu
};

typedef enum
{
	scenestatus_exist=1,
	scenestatus_smartguard=2,
	scenestatus_guardpaused=4,
	scenestatus_trainingmode=8
}   SCENESTATUS;

typedef enum
{
	sitestatus_hasviewarea=1,
	sitestatus_fastportseted=2,
	sitestatus_planenabled=4
}   SITESTATUS;


//typedef struct vaStatusSite
//{
//	int    siteIndex;
//	int    siteStatus;
//	int    smartMode;
//	TCHAR  siteName[64];
//	float  angelFrom;
//	float  angelTo;
//	float  axisFrom;
//	float  axisTo;
//	int    curSceneIndex;
//	int    curSceneState;
//}   VA_STATUS_SITE;



//typedef struct vaStatusChannel
//{
//	VA_HEADER header;
//	TCHAR  signalName[64];
//	U32    channelStatus;
//	U32    interestedFlag;
//	U32    cameraType;
//	double gps_lati;
//	double gps_long;
//	double gps_alt;           	
//	//gps
//	
//	U32  curRecordStatus;
//	S16  videoWidth;   //video width
//	S16  videoHeight;  //video height
//	S16  videoBitRate;
//	S16  videoFrameRate;
//	S16  audioBitRate;
//	S16  audioSampleRate;
//	U16  streamType;
//	U16  streamEncoding;
//	S32  propBright;
//	S32  propContrast;
//	S32  propHue;
//	S32  propSaturation;
//	//VA_STATUS_SITE sites[1];
//	//fast port status
//	//loop status
//}   VA_STATUS_CHANNEL, *PVA_STATUS_CHANNEL;  //loop info?
typedef struct vaContentSite
{
	VA_HEADER header;
	S16  curSiteIndex;
	S16  totalSites;
	S16  siteIndex;
	S16  hasSiteData;
	S8   siteData[0];   //schedule
}   VA_CONTENT_SITE, *PVA_CONTENT_SITE;
typedef struct vaContentSteam
{
	VA_HEADER header;
	U32  streamFlag;
	S8   formatdata[0];
}   VA_CONTENT_STREAM, *PVA_CONTENT_STREAM ;//

typedef enum
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

typedef enum
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
typedef enum
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


typedef enum
{
	interestedflag_content=1,
	interestedflag_recordstate=2,  //send record detail
	interestedflag_streamdata=4,   //send stream detail
	interestedflag_scene=8,        //send scene detail
	interestedflag_motiondata=16,  //send motion data
	interestedflag_alertdata=32,    //send alert state
	interestedflag_picture=64
};
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
	S8  cmdData[0];
}   VA_CMD_RULE, *PVA_CMD_RULE;

typedef enum
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
typedef enum
{
	cmdscene_addscene,
	cmdscene_delscene,
	cmdscene_setactive,
	cmdscene_updatescene
}  ;

//typedef struct vaCmdChannel
//{
//	VA_HEADER header;
//	U32    cmdType;
//	U32    cmdParam;
//	U32    cameraType;
//	TCHAR  signalName[64];
//	U32    channelStatus;
//	double gps_lati;
//	double gps_long;
//	double gps_alt;           
//	float viewArea_begin;
//	float viewArea_end;
//	float viewArea_axis;
//	float viewArea_axisTo;
//	S16  siteIndex;
//	//gps
//
//	S16  curSceneTrackMode;
//	U32  curRecordStatus;
//
//	S16  videoWidth;   //video width
//	S16  videoHeight;  //video height
//
//	S16  videoBitRate;
//
//	S16  videoFrameRate;
//
//	S16  audioBitRate;
//	S16  audioSampleRate;
//
//	U16  streamType;
//	U16  streamEncoding;
//
//	S32  propBright;
//	S32  propContrast;
//	S32  propHue;
//	S32  propSaturation;
//	S8   cmdData[0];
//}   VA_CMD_CHANNEL, *PVA_CMD_CHANNEL;
typedef enum
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
typedef enum
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

typedef enum
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
	long          ruleID;
	long          ruleFlag;
	time_t        m_firstViolatedTime;
	time_t        m_lastViolatedTime;
	time_t	      m_nTotalRunningTime;
	time_t        m_nLastStartTime;
	long          m_nViolatedCount;
	long          m_ruleParam[4];
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

//typedef struct vaDataAlert
//{
//	VA_HEADER	  header;
//	S16           siteIndex;
//	S16           sceneIndex;
//	S16           trackerIndex;
//	long          ruleID;
//	long          alertFlag;
//	time_t        alertTime;
//	long          objID;
//	long          eventType;
//	long          targeType;
//	int           objType;
//	int           processFlag;
//	long          level;
//	TCHAR         ruleName[64];
//	TCHAR         desc[64];
//	TCHAR         picFileName[64];
//}   VA_DATA_ALERT, *PVA_DATA_ALERT;

//typedef struct vaDataPicture
//{
//	VA_HEADER	  header;
//	S16           sceneIndex;
//	S16           trackerIndex;
//	TCHAR         picFileName[64];
//	S16           partIndex;
//	S16           totalParts;
//	S8            picData[0];
//}   VA_DATA_PICTURE, *PVA_DATA_PICTURE;
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
	long          globalEventType;
}  VA_EVENT_GLOBAL, *PVA_EVENT_GLOBAL;

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