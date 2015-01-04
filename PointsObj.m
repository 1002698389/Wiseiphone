//
//  PointsObj.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-10-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "PointsObj.h"

@implementation PointsObj
- (id)initWithLine:(NSString*)linename point:(NSString*)point width:(int)width height:(int)height{
    self=[super init];
    if (self) {
        self.linename=linename;
        self.points=point;
        self.width=width;
        self.height=height;
    }


    return self;
}
@end
