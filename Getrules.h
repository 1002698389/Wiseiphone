//
//  Getrules.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dbcon.h"
#import "Rules.h"
#import "linker.h"
#import "AlertLog.h"
#import "urlinfo.h"
#import "PointsObj.h"
@interface Getrules : NSObject
@property(nonatomic,retain)NSMutableArray * indexarr;
+ (Getrules*)shareRules;
- (void)addRules:(Rules*)rule;
- (NSMutableArray*)getRules;
- (void)deleteRules:(int)rid;
- (void)updateRules:(Rules*)rule;
- (Rules*)selectData:(int)iid;
- (void)addlink:(linker*)linker;
- (NSMutableArray*)listlinks;
- (void)addalert:(AlertLog*)alert;
- (NSMutableArray*)getalert;
- (void)deletelog;
- (void)removepicture;
- (NSMutableArray*)takeruleid:(int)channelid;
- (NSMutableArray*)takepoints:(int)channelid;
- (void)deletealert;
- (void)addSelectinfo:(urlinfo*)url;
- (void)addoriginfo:(urlinfo*)url;
- (NSMutableArray*)takeurlinfo;
- (void)deleteurlinfo;
- (void)deleteoriginfo;
- (NSString*)takelocalurl:(int)index;
- (void)deleteurlinfo:(int)channel;
- (NSMutableArray*)takeoriginfo;
- (int)checkorigininfo:(int)channel;
- (int)checkselectinfo:(int)channel;
- (void)appendinfo:(int)channel;
- (void)deleteruleall;
- (void)deletealertlogs;
- (void)removeallpictures:(NSString*)picpath;
- (void)updatelinkall;
- (void)updatelinkfrom:(linker*)linker;
- (void)updatelink:(NSString*)name;
- (void)deletelinker:(NSString*)name;
- (void)updatell:(NSString*)address;
- (void)updateused:(Rules*)rule isused:(int)isused;
- (NSMutableArray*)takeselectchanel;
- (NSMutableArray*)getroutharray;
- (NSMutableArray*)getRules:(int)channel;
- (NSMutableArray*)getused:(int)channelid;
- (void)updateusedall:(int)channelid isused:(int)isused;
- (void)deletelogbyindex:(NSString*)idxs;
- (void)addcurlink:(linker*)link;
- (linker*)querycurlink;
- (void)deletecurlink;
- (int)takeurlinfocount;
@end
