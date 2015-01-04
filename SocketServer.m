//
//  SocketServer.m
//  Async
//
//  Created by fuchaowen on 14-8-8.
//  Copyright (c) 2014年 com.fuchaowen.www. All rights reserved.
//

#import "SocketServer.h"
#define A header.msgLen
#import "AlertLog.h"
#import "Getrules.h"
#import "saveIndex.h"
#include "time.h"
#import "yShi.h"
#import "NewViewController.h"
extern int isnetwork;
extern int isinterest;
extern int curnet;
extern int hand;
@interface SocketServer ()
{
    NSString *hostAddress;
    int       hostPort;
    BOOL needConnect;
    NSMutableData * restData;
    int i;
    UIButton * btn1;
    int length;
    NSMutableArray * chnames;
    NSMutableData *recdata;
    NSMutableData *senddata;
    NSMutableArray * indexarr;
    int flag;
    int temp_msglen;
    int temp_index;
    NSMutableArray *patharr;
    int pathcount;
    int sendTimes;
    NSDictionary * jsondict;
    NSDictionary * jsonstry;
    NSTimer * timers;
    AlertLog * log;
    NSString * picname;
    NSString * bigpicname;
    int jpic;
    int obj;
    NSMutableArray * widths;
    NSMutableArray * heights;
    int addcount;
    int clicknot;
    int packetscount;
    
}
@end

@implementation SocketServer
+ (SocketServer*)shareSocket
{
    static SocketServer * instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[SocketServer alloc]init];
     
    });
    return instance;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sendTimes=0;
        pathcount=1;
        addcount=0;
        jpic=0;
        packetscount=0;
        clicknot=0;
        recdata=[[NSMutableData alloc]init];
        senddata=[[NSMutableData alloc]init];
        self.patharry=[NSMutableArray arrayWithCapacity:1];
        self.numchannel=[NSMutableArray arrayWithCapacity:1];
        widths=[NSMutableArray arrayWithCapacity:1];
        heights=[NSMutableArray arrayWithCapacity:1];
        patharr=[NSMutableArray arrayWithCapacity:1];
        flag=0;
        temp_msglen=0;
        temp_index=0;
        chnames=[NSMutableArray arrayWithCapacity:1];
        self.timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(sendHeart) userInfo:nil repeats:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeidx:) name:@"traf" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isclicknot) name:@"clicknet" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isclickyes) name:@"netclick" object:nil];
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeview) name:@"changecontrol" object:nil];
     
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkconnect) userInfo:nil repeats:YES];
        self.newcontrol=[[NewViewController alloc]init];
        
       
    }
    return self;
}
- (void)takeidx:(NSNotification*)info
{
    obj=[[[info userInfo] valueForKey:@"idx"] intValue];
  

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
}

- (void)checkconnect{
   // NSLog(@"执行检查");
 
    addcount++;
    NSLog(@"addcount=%d",addcount);
    NSLog(@"clicknot=%d",clicknot);
    if (clicknot==1) {
        if (packetscount==0&&addcount==3) {
            packetscount=0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clicknet" object:self];
            [self disconnectAlert];
            
        }
    }
    
   
  //  NSLog(@"isconnect=%@",self.isConnect);
}
- (void)disconnectAlert{
    NSLog(@"clicknot=%d",clicknot);
    if (clicknot==0) {
        
        addcount=31;
        
    }else{
        
        addcount=0;
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logfail" object:self];
    //[self.iview setImage:[UIImage imageNamed:@"tiker_img_2 .png"]];
    [[SocketServer shareSocket] disConnect];
    [SocketServer shareSocket].isConnect=@"失败";
    [SocketServer shareSocket].iaddress=nil;
    [[Getrules shareRules]deleteurlinfo];
    [[Getrules shareRules]updatelinkall];
    [[Getrules shareRules]deleteoriginfo];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"连接断开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
   // hand=0;
    isnetwork=0;
    isinterest=0;
}
- (void)isclicknot{

    clicknot=0;
    
}
- (void)isclickyes{

   clicknot=1;
    addcount=0;
   NSLog(@"click1");
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.iview removeFromSuperview];

}
-(NSError *)setupConnection:(NSString*)address port:(int)port
{
    
    if (nil == socket)
        socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *err = nil;
    hostAddress=address;
    hostPort=port;
   // NSLog(@"IP: %@, port:%i",hostAddress,hostPort);
    if (![socket connectToHost:hostAddress onPort:hostPort error:&err])
    {
       
        err = nil;
    } else
    {
        
      
       
    }
    needConnect = YES;
    //发送登录请求信息
    self.isinterest=@"no";
    [socket readDataWithTimeout:5 tag:0];

    return err;
}
- (void)sendLogon:(NSString*)username
{
   // NSLog(@"登录成功");
    VA_LOGON logon;
    logon.header.chIndex=1;
    logon.header.flag=4;
    logon.header.key=1;
    logon.header.msgLen=400;
    logon.header.serverIndex=0;
    logon.pad=0;
    strcpy(logon.logonUsrName,"admin");
    strcpy(logon.logonUsrPassSHA1, "da39a3ee5e6b4b0d3255bfef95601890afd80709");
    strcpy(logon.sessionkey, "se5993965237389393754key");
    logon.usrnamelen=strlen(logon.logonUsrName);
    logon.usrpasslen=strlen(logon.logonUsrPassSHA1);
    logon.sessionkeylen=strlen(logon.sessionkey);
    NSData *data=[NSData dataWithBytes:&logon length:sizeof(logon)];
    [socket writeData:data withTimeout:-1 tag:0];
}
- (void)sendHeart
{
   // NSLog(@"心跳包");
    VA_KEEPALIVE heart;
    heart.header.chIndex=-1;
    heart.header.serverIndex=0;
    heart.header.msgLen=16;
    heart.header.flag=1;
    heart.header.key=25;
    heart.ti=time(nil);
    heart.unUsed=0;
    NSData * heartdata=[NSData dataWithBytes:&heart length:sizeof(heart)];
    [socket writeData:heartdata withTimeout:-1 tag:0];
}
- (void)sendStatus
{
    VA_CMD_GETSTATUS serverstatus;
    serverstatus.header.chIndex=-1;
    serverstatus.header.flag=4;
    serverstatus.header.serverIndex=0;
    serverstatus.header.msgLen=12;
    serverstatus.header.key=10;
    serverstatus.statusFlag=0;
    serverstatus.statusType=1;

    NSData * statusdata=[NSData dataWithBytes:&serverstatus length:sizeof(serverstatus)];
    [socket writeData:statusdata withTimeout:-1 tag:0];
   
}
//- (void)sendInterestRule
//{
//  
//    VA_CMD_INTERESTED interest;
//    interest.header.chIndex=0;
//    interest.header.flag=0;
//    interest.header.msgLen=12;
//    interest.header.serverIndex=0;
//    interest.header.key=11;
//    // interest.interestedFlag=1|128;
//    interest.interestedFlag=1|32|64;
//    NSData * data=[[NSData alloc]initWithBytes:&interest length:sizeof(interest)];
//    [socket writeData:data withTimeout:-1 tag:0];
//
//
//}
- (void)sendInterest:(NSMutableArray*)channel
{
    [SocketServer shareSocket].isinterest=@"yes";
    NSLog(@"getchannel=%@",channel);
    for (int k=0; k<channel.count; k++) {
        //sendTimes++;
        VA_CMD_INTERESTED interest;
        interest.header.chIndex=[[channel objectAtIndex:k] intValue];
        interest.header.flag=0;
        interest.header.msgLen=12;
        interest.header.serverIndex=0;
        interest.header.key=11;
       // interest.interestedFlag=1|128;
        interest.interestedFlag=1|32|64;
        NSData * data=[[NSData alloc]initWithBytes:&interest length:sizeof(interest)];
        [socket writeData:data withTimeout:-1 tag:0];
    }

}
- (NSMutableArray*)getpoint:(Rules*)rule
{
    Rules * rl=rule;
   
    NSString * points=rl.points;
    NSMutableArray * stg=[NSMutableArray arrayWithCapacity:1];
    NSArray * xy1=[points componentsSeparatedByString:@","];
    for (int k=0; k<xy1.count/2; k++) {
        CGPoint p1=CGPointMake([[xy1 objectAtIndex:2*k]floatValue], [[xy1 objectAtIndex:2*k+1]floatValue]);
        
        NSLog(@"转换前=%f,%f",p1.x,p1.y);
        
        int w=rl.width;
        int h=rl.height;
        if (IS_IPHONE_5_SCREEN) {
            p1.x=p1.x*w/320;
            p1.y=p1.y*h/300;
        }else{
            
            p1.x=p1.x*w/320;
            p1.y=p1.y*h/297;
            
        }
        
        NSNumber * n1=[NSNumber numberWithFloat:p1.x];
        NSNumber * n2=[NSNumber numberWithFloat:p1.y];
        [stg addObject:n1];
        [stg addObject:n2];
        NSLog(@"转换后x=%f,y=%f",p1.x,p1.y);
    }
    return stg;
}
- (NSMutableDictionary*)getSharpPoly:(int)sharptype rule:(Rules*)rule
{
    Rules * ruls=[saveIndex shareindex].sendRule;
  //  NSMutableArray * width=widths;
    //NSMutableArray * hight=heights;
    //[widths removeAllObjects];
    //[heights removeAllObjects];
    NSMutableArray * point=[self getpoint:rule];
    
    CGFloat p1x=[[point objectAtIndex:0] floatValue];
    CGFloat p1y=[[point objectAtIndex:1]floatValue];
    CGFloat p2x=[[point objectAtIndex:2]floatValue];
    CGFloat p2y=[[point objectAtIndex:3]floatValue];
    NSMutableDictionary * basesharp;
    //  NSNumber * type=[NSNumber numberWithInt:sharptype];
    NSNumber * num0=[NSNumber numberWithInt:ruls.shapetype];
    NSNumber * num1=[NSNumber numberWithInt:4];
    NSNumber * num2=[NSNumber numberWithInt:0];
    NSNumber * num3=[NSNumber numberWithInt:5];
    NSNumber * num4=[NSNumber numberWithInt:10];
    NSNumber * num5=[NSNumber numberWithLong:16711680];
    NSNumber * num6=[NSNumber numberWithUnsignedLong:3452816845];
    NSNumber * num7=[NSNumber numberWithFloat:p1x];//left
    NSNumber * num8=[NSNumber numberWithFloat:p2x];//right
    NSNumber * num9=[NSNumber numberWithFloat:p1y];//top
    NSNumber * num10=[NSNumber numberWithFloat:p2y];//bottom
    NSNumber * num11=[NSNumber numberWithInt:278];
    NSNumber * num12=[NSNumber numberWithInt:114];
    NSNumber * num13=[NSNumber numberWithInt:279];
    NSNumber * num14=[NSNumber numberWithInt:64];
    NSNumber * num15=[NSNumber numberWithInt:369];
    NSNumber * num16=[NSNumber numberWithInt:402];
    NSNumber * num17=[NSNumber numberWithInt:533];
    NSNumber * num18=[NSNumber numberWithInt:585];
    NSNumber * num19=[NSNumber numberWithInt:215];
    //   NSNumber * bool1=[NSNumber numberWithBool:true];
    NSNumber * bool2=[NSNumber numberWithBool:false];
    if (sharptype==1) {
        basesharp =[[NSMutableDictionary alloc]initWithObjectsAndKeys:num0,@"ShapeType",bool2,@"Fill",num1,@"LineWidth",num5,@"LineColor",num6,@"FrameCounter",num5,@"FillColor",num0,@"Ref",num2,@"ShapeIndex",bool2,@"Selected",num7,@"ShapeBoundLeft",num8,@"ShapeBoundRight",num9,@"ShapeBoundTop",num10,@"ShapeBoundBottom",num2,@"ShapeDirectionX",num2,@"ShapeDirectionY",num4,@"AllocPoints",num3,@"Points",num2,@"FrameCounter",num11,@"Point0_X",num12,@"Point0_Y",num13,@"Point1_X",num12,@"Point1_Y",num14,@"Point2_X",num15,@"Point2_Y",num16,@"Point3_X",num17,@"Point3_Y",num18,@"Point4_X",num19,@"Point4_Y",nil];
    }else{
        
        basesharp =[[NSMutableDictionary alloc]initWithObjectsAndKeys:num0,@"ShapeType",bool2,@"Fill",num1,@"LineWidth",num5,@"LineColor",num6,@"FrameCounter",num5,@"FillColor",num0,@"Ref",num2,@"ShapeIndex",bool2,@"Selected",num7,@"ShapeBoundLeft",num8,@"ShapeBoundRight",num9,@"ShapeBoundTop",num10,@"ShapeBoundBottom",num2,@"ShapeDirectionX",num2,@"ShapeDirectionY",nil];
        
        
    }
    
    return basesharp;
}
- (void)sendRule
{
    Rules * rss=[saveIndex shareindex].sendRule;
    NSLog(@"point=%@",rss.points);
    VA_CMD_RULE rule;
    rule.header.flag=0;
    rule.header.serverIndex=0;
    rule.header.chIndex=rss.channlid;
    NSLog(@"rss.=%d",rss.channlid);
    rule.header.key=15;
    rule.header.msgLen=sizeof(rule);
    rule.sceneIndex=0;
    rule.trackerIndex=0;
    rule.cmdParam=0;
    rule.cmdType=0;
    rule.ruleID=0;
    
    NSMutableArray * sharparr=[NSMutableArray arrayWithCapacity:1];
    Rules * rls=[saveIndex shareindex].sendRule;
    [sharparr addObject:[self getSharpPoly:0 rule:rls]];
    //NSString *sharpstring=[sharparr JSONString];
    NSNumber * num0=[NSNumber numberWithInt:1];
    NSNumber * num1=[NSNumber numberWithInt:rls.eventtype];
    NSNumber * num2=[NSNumber numberWithInt:7];
    NSNumber * num3=[NSNumber numberWithInt:rls.ruleid];
    NSNumber * num4=[NSNumber numberWithInt:5];
    NSNumber * num5=[NSNumber numberWithInt:-1];
    NSNumber * num6=[NSNumber numberWithInt:30];
    NSNumber * num7=[NSNumber numberWithInt:29];
    NSNumber * num8=[NSNumber numberWithInt:3];
    NSNumber * bool1=[NSNumber numberWithBool:true];
    NSNumber * bool2=[NSNumber numberWithBool:false];
    NSNumber * cur=[NSNumber numberWithLong:0];
    NSDictionary * event=[NSDictionary dictionaryWithObjectsAndKeys:num1,@"EventType",num2,@"TargetType",num3,@"EventID",@"",@"EventName",num0,@"EventRef",num2,@"CheckBottomViolatedOnly",num4,@"AlertTimeLimit",bool1,@"KeepAlert",num5,@"CrowdThreshHold",num5,@"BrowseTimeLimit",bool1,@"CheckSequence",num5,@"EventLostFrameLimit",num5,@"MaxTimeInterval",num6,@"OffTimeDelay",sharparr,@"Shape", nil];
    
    NSDictionary * Rule=[NSDictionary dictionaryWithObjectsAndKeys:num3,@"RuleID",num0,@"ProhiLevel",cur,@"CreateTime",cur,@"ModifyTime",rls.rulename,@"RuleName",rls.rulename,@"Description",@"警戒",@"CreatorName",@"",@"ModifyName",@"",@"OffExeFileName",@"",@"OnExeFileName",@"",@"Email",@"",@"CopyTo",@"",@"Topic",@"",@"Content",num5,@"FirstViolatedTime",num5,@"LastViolatedTime",num3,@"TotalRunningTime",cur,@"LastStartTime",num3,@"ViolatedCount",bool1,@"Enabled",bool1,@"InTime",bool2,@"Violated",bool2,@"Trigger",num7,@"EventProcessFlag",num5,@"OffExeRestartInterval",num5,@"AttachPic",num6,@"TrackTime",num8,@"TrackStopType",num8,@"TrackStyle",num4,@"TrackZoomSpeed",num4,@"TrackMoveSpeed",event,@"Event", nil];
    
    //NSString * jsonstring=[Rule JSONString];
    NSData * jsonRule=[NSJSONSerialization dataWithJSONObject:Rule options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonstring=[[NSString alloc]initWithData:jsonRule encoding:NSUTF8StringEncoding];
    
    
    const char * json=[jsonstring cStringUsingEncoding:NSUTF8StringEncoding];
    strcpy(rule.cmdData,json);
    
    NSData * data=[[NSData alloc]initWithBytes:&rule length:sizeof(rule)];
    
    [socket writeData:data withTimeout:-1 tag:0];
}
- (void)enablerule:(int)channelid ruleid:(int)ruleid
{
    VA_CMD_NEWRULE rule;
    rule.header.flag=0;
    rule.header.serverIndex=0;
    rule.header.chIndex=channelid;
    rule.header.key=15;
    rule.header.msgLen=sizeof(rule);
    rule.sceneIndex=0;
    rule.trackerIndex=0;
    rule.cmdParam=0;
    rule.cmdType=2;
    rule.ruleID=ruleid;
    NSData * data=[[NSData alloc]initWithBytes:&rule length:sizeof(rule)];
    [socket writeData:data withTimeout:-1 tag:0];

}
- (void)disablerule:(int)channelid ruleid:(int)ruleid
{
    VA_CMD_NEWRULE rule;
    rule.header.flag=0;
    rule.header.serverIndex=0;
    rule.header.chIndex=channelid;
    rule.header.key=15;
    rule.header.msgLen=sizeof(rule);
    rule.sceneIndex=0;
    rule.trackerIndex=0;
    rule.cmdParam=0;
    rule.cmdType=3;
    rule.ruleID=ruleid;
    NSData * data=[[NSData alloc]initWithBytes:&rule length:sizeof(rule)];
    [socket writeData:data withTimeout:-1 tag:0];
   

}
- (void)deleterule:(int)channelid ruleid:(int)ruleid
{
    VA_CMD_NEWRULE rule;
    rule.header.flag=0;
    rule.header.serverIndex=0;
    rule.header.chIndex=channelid;
    rule.header.key=15;
    rule.header.msgLen=sizeof(rule);
    rule.sceneIndex=0;
    rule.trackerIndex=0;
    rule.cmdParam=0;
    rule.cmdType=1;
    rule.ruleID=ruleid;
    NSData * data=[[NSData alloc]initWithBytes:&rule length:sizeof(rule)];
    [socket writeData:data withTimeout:-1 tag:0];
}
//判断是否是连接的状态
-(BOOL)isConnected
{
  
    return socket.isConnected;
} //断开连接
-(void)disConnect
{   packetscount=0;
    needConnect = NO;
    [socket disconnect];
    [SocketServer shareSocket].iaddress=nil;
} //取得连接

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
  
    
    
    self.iaddress=host;
  //  [self sendLogon:@"admin"];
 
    [[NSNotificationCenter defaultCenter]postNotificationName:@"online" object:self];
   
    [socket readDataWithTimeout:-1 tag:0];

}
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
    NSLog(@"hand=%d",hand);
    if (hand==0) {
     
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            [[SocketServer shareSocket] disConnect];
            [SocketServer shareSocket].isConnect=@"失败";
            [SocketServer shareSocket].iaddress=nil;
            [[Getrules shareRules]deleteurlinfo];
            [[Getrules shareRules]updatelinkall];
            [[Getrules shareRules]deleteoriginfo];
        
    }
    
  
    
}

- (void)retryconnect{
    NSUserDefaults * usdf=[NSUserDefaults standardUserDefaults];
    NSString * username=[usdf valueForKey:@"address"];
    int port=[[usdf valueForKey:@"port"] intValue];
    [[SocketServer shareSocket] setupConnection:username port:port];


}

- (void)dealdata:(VA_HEADER)header
{
    NSLog(@"heardkey=%d",header.key);
   
    if (header.key==2) {
       // NSLog(@"clicknot=%d",clicknot);
        VA_LOGON_RESULT result;
        [senddata getBytes:&result length:header.msgLen];
        NSLog(@"登录状态%d",result.logonResult);
        NSLog(@"clicknot=%d",clicknot);
//        if (result.logonResult!=0) {
//          
//            [SocketServer shareSocket].isConnect=@"失败";
//            [self disconnectAlert];
//            
//        }else{
            hand=0;
            isnetwork=1;
            [SocketServer shareSocket].isConnect=@"成功";
            [[Getrules shareRules]deleteurlinfo];
            [[Getrules shareRules]deleteoriginfo];
            NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
            NSString * add=[def valueForKey:@"address"];
            NSLog(@"add=%@",add);
            [[Getrules shareRules] updatelinkall];
            [[Getrules shareRules] updatell:add];
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"连接成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logsuccess" object:self];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"online" object:self];
            
       
       // }
    
        temp_index=temp_index+header.msgLen;
    }
    
    if (header.key==25) {
        NSLog(@"接收心跳包");
        [self.timer fire];
        addcount=0;
        //NSRange range=NSMakeRange(temp_index, header.msgLen);
        temp_index=temp_index+header.msgLen;
        if (pathcount>1) {
            NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:self.patharry,@"pathforurl",widths,@"wid",heights,@"hig", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pathurl" object:self userInfo:dict];
            [widths removeAllObjects];
            [heights removeAllObjects];
            pathcount=1;
        }else{
         
            pathcount=1;
        }
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[Getrules shareRules]removepicture];
            [[Getrules shareRules]deletelog];
       // });
    
      
    }
    if (header.key==0) {
        NSLog(@"sendlogon_____________________________");
        [self sendLogon:@"admin"];
        temp_index=temp_index+header.msgLen;
    }
    if (header.key==3) {
        [self.numchannel removeAllObjects];
        VA_STATUS_SERVER server;
        NSRange range=NSMakeRange(temp_index, header.msgLen);
        [recdata getBytes:&server range:range];
        for (int j=0; j<server.channelNum; j++) {
    
            NSString * str=[NSString stringWithCString:server.chInfo[j].chName encoding:NSUTF16LittleEndianStringEncoding];
            NSRange range=[str rangeOfString:@"路" options:NSCaseInsensitiveSearch];
            if (range.length<=0) {
                str=[NSString stringWithFormat:@"%@一路",str];
            }
            int status=server.chInfo[j].chStatus;
            int index=j;
            NSString *nsi=[NSString stringWithFormat:@"%@.%d.%d",str,index,status];
         
                [self.numchannel addObject:nsi];
            
            
        }
       // NSLog(@"收到数据包");
        NSDictionary * dic=[NSDictionary dictionaryWithObjectsAndKeys:self.numchannel,@"status", nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"serverstatus" object:nil userInfo:dic];
        temp_index=temp_index+header.msgLen;
    }
    if (header.key==4) {
        VA_STATUS_CHANNEL channel;
        memset(&channel, 0, sizeof(channel));
        NSRange curange=NSMakeRange(temp_index,sizeof(VA_STATUS_CHANNEL));
        [recdata getBytes:&channel range:curange];
        int cid=channel.header.chIndex;
        NSNumber * nb=[NSNumber numberWithInt:cid];
        [[saveIndex shareindex].indexsarray addObject:nb];
        NSNumber * wid=[NSNumber numberWithInt:channel.videoWidth];
        NSNumber * hig=[NSNumber numberWithInt:channel.videoHeight];
        isinterest=1;
        [widths addObject:wid];
        [heights addObject:hig];
        char url[header.msgLen];
        memset(url, 0, header.msgLen);
       // NSLog(@"header.msglen=%d",header.msgLen);
        NSRange range=NSMakeRange(temp_index+sizeof(VA_STATUS_CHANNEL), header.msgLen-sizeof(VA_STATUS_CHANNEL));
        [recdata getBytes:&url range:range];

        NSData *data=[NSData dataWithBytes:url length:header.msgLen-sizeof(VA_STATUS_CHANNEL)];
     
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ismovie" object:self];
        jsondict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString * path=[jsondict objectForKey:@"RTSPURL"];
        path=@"rtsp://218.204.223.237:554/live/1/66251FC11353191F/e7ooqwcfbqjoo80j.sdp";
        if (path.length!=0) {
            urlinfo * urlif=[[urlinfo alloc]init];
            urlif.path=path;
            urlif.index=cid;
            urlif.width=channel.videoWidth;
            urlif.height=channel.videoHeight;
           // NSLog(@"cid=%d",urlif.index);
            //NSLog(@"pathurl=%@",urlif.path);
            NSMutableArray * pathss=[[Getrules shareRules]takeoriginfo];
            [[Getrules shareRules] addSelectinfo:urlif];
            if (![pathss containsObject:urlif]) {
                [[Getrules shareRules] addoriginfo:urlif];
            }
        }
        
       
       

        
        pathcount++;
        
        
        temp_index=temp_index+header.msgLen;
    }
    
    
    if (header.key==7) {
//        VA_CONTENT_SITE rulechange;
//        NSRange curange=NSMakeRange(temp_index,16);
//        [recdata getBytes:&rulechange range:curange];
//        char jsn[header.msgLen-16];
//        NSLog(@"header.msglen=%d",header.msgLen);
//        NSRange range=NSMakeRange(temp_index+16, header.msgLen-16);
//        [recdata getBytes:&jsn range:range];
//        NSData *data=[NSData dataWithBytes:jsn length:strlen(jsn)];
//        jsonstry=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
       // NSLog(@"jsonstry=%@",jsonstry);
        temp_index=temp_index+header.msgLen;
     //   pathcount++;
        
    }
    if(header.key==19){
        
        VA_DATA_ALERT alert;
        [recdata getBytes:&alert length:sizeof(alert)];
        log=[[AlertLog alloc]init];
        log.serverindex=alert.header.serverIndex;
        log.chindex=alert.header.chIndex;
        log.sceneindex=alert.sceneIndex;
        log.siteindex=alert.siteIndex;
        log.trackerindex=alert.trackerIndex;
        log.ruleid=alert.ruleID;
        log.alertflag=alert.alertFlag;
        char buffer[90]={0};
        time_t tempAlerttime =(time_t)alert.alertTime;
        struct tm * timer=gmtime(&tempAlerttime);
        NSString *year=[NSString stringWithFormat:@"%d",timer->tm_year+1900];
        NSString *month;
        NSString *day;
        NSString *hour;
        NSString *minu;
        NSString *secn;
        if (timer->tm_mon<9) {
            month=[NSString stringWithFormat:@"0%d",timer->tm_mon+1];
        }else{
            month=[NSString stringWithFormat:@"%d",timer->tm_mon+1];
        }
        if (timer->tm_mday<10) {
            day=[NSString stringWithFormat:@"0%d",timer->tm_mday];
        }else{
            day=[NSString stringWithFormat:@"%d",timer->tm_mday];
        }
        if (timer->tm_hour<2) {
            hour=[NSString stringWithFormat:@"0%d",timer->tm_hour+8];
        }else{
            hour=[NSString stringWithFormat:@"%d",timer->tm_hour+8];
        }
        if (timer->tm_min<10) {
            minu=[NSString stringWithFormat:@"0%d",timer->tm_min];
        }else{
            minu=[NSString stringWithFormat:@"%d",timer->tm_min];
        }
        if (timer->tm_sec<10) {
            secn=[NSString stringWithFormat:@"0%d",timer->tm_sec];
        }else{
            secn=[NSString stringWithFormat:@"%d",timer->tm_sec];
        }
        sprintf(buffer,"%d-%d-%d %d:%d:%d\n", timer->tm_year+1900,timer->tm_mon+1,timer->tm_mday, timer->tm_hour+8, timer->tm_min, timer->tm_sec);
        NSString *alertime=[NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,minu,secn];
        //        NSArray * alertarray=[alertime componentsSeparatedByString:@":"];
        //        NSString * second=[alertarray objectAtIndex:2];
        //        int sec=[second intValue];
        //        if (sec<10) {
        //            second=[NSString stringWithFormat:@"0%@",second];
        //        }
        log.alerttime=alertime;
        log.objid=alert.objID;
        log.eventtype=alert.eventType;
        log.targetype=alert.targeType;
        log.objtype=alert.objType;
        log.processflag=alert.processFlag;
        log.level=alert.level;
        log.rulename=@"警戒线";
        log.descript=@"警戒线";
        log.picturename=[NSString stringWithCString:alert.picFileName encoding:NSUTF8StringEncoding];
        picname=[NSString stringWithFormat:@"%dsmall.png",alert.ruleID];
        bigpicname=[NSString stringWithFormat:@"%dbig.png",alert.ruleID];
        log.picpath=picname;
        log.bigpicpath=bigpicname;
      
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
           
            [[Getrules shareRules] addalert:log];

      //  });
        
            temp_index=temp_index+header.msgLen;
            
//            if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
//                self.iview.transform=CGAffineTransformMakeRotation((-90.0f * M_PI) / 180.0f);
//            }

       [[NSNotificationCenter defaultCenter] postNotificationName:@"ialert" object:self];
        
        
        
    }
    if (header.key==20) {
    
        VA_DATA_PICTURE picture;
        NSRange range=NSMakeRange(temp_index, 144);
        [recdata getBytes:&picture range:range];
        NSRange range2=NSMakeRange(temp_index+144, picture.header.msgLen-144);
        char pic[picture.header.msgLen];
        memset(pic, 0, picture.header.msgLen);
        [recdata getBytes:&pic range:range2];
        NSData * imgdata=[[NSData alloc]initWithBytes:pic length:sizeof(pic)];
        self.alertimg =[[UIImage alloc]initWithData:imgdata];
      // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          
            [self readpicture];
           
           
      //  });
        
        temp_index=temp_index+header.msgLen;
    }

}

- (NSString*)picpath:(NSString*)imageName
{
    NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *filepath=[directorypath stringByAppendingPathComponent:imageName];
   // NSLog(@"filepath=%@",filepath);
    
    return filepath;
}

-(NSString *)dateInFormat:(time_t)dateTime format:(NSString*) stringFormat
{
    char buffer[80];
    memset(buffer, 0, 80);
    const char *format = [stringFormat UTF8String];
   // NSLog(@"format=%s",format);
    struct tm * timeinfo;
    timeinfo = localtime(&dateTime);
    
    strftime(buffer, 80, format, timeinfo);
    
    return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

- (void)readpicture
{
    
  
    
    CGSize littlesize=CGSizeMake(150, 100);
    UIImage * result=[self imageWithImageSimple:self.alertimg scaledToSize:littlesize];
    CGSize bigsize=CGSizeMake(560, 560);
    UIImage * result1=[self imageWithImageSimple:self.alertimg scaledToSize:bigsize];
    [self saveImage:result WithName:picname ];
    [self saveBigpic:result1 WithName:bigpicname];
   
    
    
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (void)saveImage:(UIImage *)img WithName:(NSString *)imageName
{
    NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   // NSLog(@"directorypath=%@",directorypath);
    NSString *fullpath=[directorypath stringByAppendingPathComponent:imageName];
    //NSLog(@"fullpath=%@",fullpath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:directorypath];
    if (result==NO) {
        [UIImagePNGRepresentation(img) writeToFile:fullpath atomically:NO];
    }else{
     
        [fileManager removeItemAtPath:fullpath error:nil];
        [UIImagePNGRepresentation(img) writeToFile:fullpath atomically:NO];
    }
    
    
    
}
- (void)saveBigpic:(UIImage *)img WithName:(NSString *)imageName
{
    NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *fullpath=[directorypath stringByAppendingPathComponent:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:directorypath];
    if (result==NO) {
        [UIImagePNGRepresentation(img) writeToFile:fullpath atomically:NO];
    }else{
        
        [fileManager removeItemAtPath:fullpath error:nil];
        [UIImagePNGRepresentation(img) writeToFile:fullpath atomically:NO];
    }


}
//- (void)dataPath:(NSString*)filename
//{
//    
//    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:filename];
//    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    
//    
//   // NSString *result = [path stringByAppendingPathComponent:file];
//    
//   // return result;
//    
//}
- (void)documentFolderPath:(NSString*)pictype
{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Caches/%@", NSHomeDirectory(), pictype];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
   
}

- (void)readPacket
{
    while (1) {
        VA_HEADER header;
        if (flag==0) {
            
            NSRange range=NSMakeRange(temp_index, sizeof(header));
            [recdata getBytes:&header range:range];
            
            temp_msglen=header.msgLen;
        }

        if (temp_msglen<[recdata length]-temp_index) {
            [self dealdata:header];
           
            continue;
        }
        if (temp_msglen==([recdata length]-temp_index)) {
            [self dealdata:header];
            temp_msglen=0;
            temp_index=0;
            recdata=nil;
            recdata=[[NSMutableData alloc]init];
           
            return;
        }
        if (temp_msglen>[recdata length]-temp_index) {
          
            return;
        }
    }
}


-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    packetscount++;
    VA_HEADER header;
    [data getBytes:&header length:sizeof(header)];
    [recdata appendData:data];
    [self readPacket];
   
  
    
    [socket readDataWithTimeout:-1 tag:0];
}
-(void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
  

   
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
  
    [socket readDataWithTimeout:-1 tag:0];

 }
 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



@end
