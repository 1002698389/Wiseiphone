//
//  Indexpath.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-12-7.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Indexpath.h"

@implementation Indexpath
+ (Indexpath*)shareindexpath
{
    static Indexpath * instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[Indexpath alloc]init];
    });

    return instance;
    
    
}

@end
