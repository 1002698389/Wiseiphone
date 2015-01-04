//
//  Shape.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-10-31.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Shape.h"

@implementation Shape
- (id)initWithName:(NSString*)name points:(NSMutableArray*)points{
    self=[super init];
    if (self) {
        self.name=name;
        self.points=points;
    }
    return self;
    
}
@end
