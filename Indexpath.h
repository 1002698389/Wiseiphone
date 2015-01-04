//
//  Indexpath.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-12-7.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Indexpath : NSObject
+ (Indexpath*)shareindexpath;
@property(nonatomic,strong)NSMutableArray * indexpath;
@end
