//
//  saveIndex.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-22.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "saveIndex.h"

@implementation saveIndex

+ (saveIndex*)shareindex
{
    static saveIndex * instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[saveIndex alloc]init];
    });
    return instance;
    
    
}
- (id)initWithIndex
{
    self=[super init];
    if (self) {
        self.sendRule=[[Rules alloc]init];
        self.indexsarray=[NSMutableArray arrayWithCapacity:1];
    }
    return self;
}
@end
