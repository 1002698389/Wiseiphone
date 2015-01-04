//
//  PointsObj.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-10-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointsObj : NSObject
@property(nonatomic,strong)NSString * linename;
@property(nonatomic,strong)NSString * points;
@property(nonatomic,assign)int width;
@property(nonatomic,assign)int height;
- (id)initWithLine:(NSString*)linename point:(NSString*)point width:(int)width height:(int)height;
@end
