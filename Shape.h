//
//  Shape.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-10-31.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSMutableArray * points;
- (id)initWithName:(NSString*)name points:(NSMutableArray*)points;
@end
