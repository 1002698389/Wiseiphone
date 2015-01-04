//
//  linker.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-15.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface linker : NSObject
@property(nonatomic,assign)int linkid;
@property(nonatomic,retain)NSString * byname;
@property(nonatomic,retain)NSString * address;
@property(nonatomic,retain)NSString * port;
@property(nonatomic,retain)NSString * type;
@property(nonatomic,retain)NSString * username;
@property(nonatomic,retain)NSString * password;
@property(nonatomic,assign)int channelnum;
@property(nonatomic,retain)NSString * isopen;
- (id)initWithLinkid:(int)linkid byname:(NSString*)byname address:(NSString*)address port:(NSString*)port type:(NSString*)type username:(NSString*)username password:(NSString*)password channelnum:(int)channelnum isopen:(NSString*)isopen;
+ (id)LinkWithLinkid:(int)linkid byname:(NSString*)byname address:(NSString*)address port:(NSString*)port type:(NSString*)type username:(NSString*)username password:(NSString*)password channelnum:(int)channelnum isopen:(NSString*)isopen;
@end
