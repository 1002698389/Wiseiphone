//
//  saveIndex.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-22.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rules.h"
@interface saveIndex : NSObject
@property(nonatomic,retain)NSMutableArray * indexsarray;
@property(nonatomic,retain)Rules * sendRule;
@property(nonatomic,retain)NSArray * idxarry;
- (id)initWithIndex;
+ (saveIndex*)shareindex;
@end
