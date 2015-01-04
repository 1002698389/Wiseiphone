//
//  linker.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-15.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "linker.h"

@implementation linker
- (id)initWithLinkid:(int)linkid byname:(NSString*)byname address:(NSString*)address port:(NSString*)port type:(NSString*)type username:(NSString*)username password:(NSString*)password channelnum:(int)channelnum isopen:(NSString *)isopen
{
    self=[super init];
    if (self) {
        self.linkid=linkid;
        self.byname=byname;
        self.address=address;
        self.port=port;
        self.type=type;
        self.username=username;
        self.password=password;
        self.channelnum=channelnum;
        self.isopen=isopen;
    }

    return self;

}
+ (id)LinkWithLinkid:(int)linkid byname:(NSString*)byname address:(NSString*)address port:(NSString*)port type:(NSString*)type username:(NSString*)username password:(NSString*)password channelnum:(int)channelnum isopen:(NSString *)isopen
{
    linker * link=[[linker alloc]initWithLinkid:linkid byname:byname address:address port:port type:type username:username password:password channelnum:channelnum isopen:isopen];
    
    return link;
}

@end
