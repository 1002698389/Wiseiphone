//
//  Rules.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Rules.h"

@implementation Rules
- (id)initWithRulename:(NSString*)name point:(NSString*)point rid:(int)rid precept:(NSString*)precept path:(NSString*)path descript:(NSString*)descript channlid:(int)channelid eventtype:(int)eventtype shapetype:(int)shapetype ruleid:(int)ruleid isused:(int)isused width:(int)width height:(int)height address:(NSString*)address
{
    self=[super init];
    if (self) {
        self.rulename=name;
        self.points=point;
        self.Rid=rid;
        self.precept=precept;
        self.path=path;
        self.descript=descript;
        self.channlid=channelid;
        self.eventtype=eventtype;
        self.shapetype=shapetype;
        self.ruleid=ruleid;
        self.isused=isused;
        self.width=width;
        self.height=height;
        self.address=address;
    }
    return self;

}
+ (id)RlueWithRulename:(NSString*)name point:(NSString*)point rid:(int)rid precept:(NSString*)precept path:(NSString*)path descript:(NSString*)descript channlid:(int)channelid eventtype:(int)eventtype shapetype:(int)shapetype ruleid:(int)ruleid isused:(int)isused width:(int)width height:(int)height address:(NSString*)address
{
    Rules * ru=[[Rules alloc]initWithRulename:name point:point rid:rid precept:precept path:path descript:descript channlid:channelid eventtype:eventtype shapetype:shapetype ruleid:ruleid isused:isused width:width height:height address:address];
    
    return ru;
    
}
@end
