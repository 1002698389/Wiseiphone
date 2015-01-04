//
//  Rules.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rules : NSObject
@property(nonatomic,retain) NSString *rulename;
@property(nonatomic,retain) NSString *points;
@property(nonatomic,retain)NSString *precept;
@property(nonatomic,retain)NSString *path;
@property(nonatomic,assign) int Rid;
@property(nonatomic,retain)NSString *descript;
@property(nonatomic,assign)int channlid;
@property(nonatomic,assign)int eventtype;
@property(nonatomic,assign)int shapetype;
@property(nonatomic,assign)int ruleid;
@property(nonatomic,assign)int isused;
@property(nonatomic,assign)int width;
@property(nonatomic,assign)int height;
@property(nonatomic,assign)NSString * address;
- (id)initWithRulename:(NSString*)name point:(NSString*)point rid:(int)rid precept:(NSString*)precept path:(NSString*)path descript:(NSString*)descript channlid:(int)channelid eventtype:(int)eventtype shapetype:(int)shapetype ruleid:(int)ruleid isused:(int)isused width:(int)width height:(int)height address:(NSString*)address;
+ (id)RlueWithRulename:(NSString*)name point:(NSString*)point rid:(int)rid precept:(NSString*)precept path:(NSString*)path descript:(NSString*)descript channlid:(int)channelid eventtype:(int)eventtype shapetype:(int)shapetype ruleid:(int)ruleid isused:(int)isused width:(int)width height:(int)height address:(NSString*)address;
@end
