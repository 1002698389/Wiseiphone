//
//  SocketServer.h
//  Async
//
//  Created by fuchaowen on 14-8-8.
//  Copyright (c) 2014年 com.fuchaowen.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "NetProtocal.h"
#import "urlinfo.h"
#import "MoveView.h"
@class NewViewController;
@interface SocketServer : UIViewController<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * socket;
    
}
@property(nonatomic,strong)NSString * isConnect;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)NSMutableArray *numchannel;
@property(nonatomic,retain)NSIndexPath * index;
@property(nonatomic,retain)NSMutableArray * patharry;
@property(nonatomic,retain)NSString *urlstring;
@property(nonatomic,retain)UIImage * alertimg;
@property(nonatomic,retain)MoveView *iview;
@property(nonatomic,retain)NSString * iaddress;
@property(nonatomic,retain)NSString * isinterest;
@property(nonatomic,retain)NewViewController * newcontrol;
//@property(nonatomic,assign)int clicknot;
//@property(nonatomic,retain)NSString * isinterest;
+ (SocketServer*)shareSocket;
-(NSError *)setupConnection:(NSString*)address port:(int)port;
- (void)sendLogon:(NSString*)username;
- (void)sendStatus;
- (void)sendInterest:(NSMutableArray*)channel;
- (void)sendRule;
- (void)deleterule:(int)channelid ruleid:(int)ruleid;
- (void)enablerule:(int)channelid ruleid:(int)ruleid;
- (void)disablerule:(int)channelid ruleid:(int)ruleid;
-(void)disConnect;
- (void)disconnectAlert;
@end
