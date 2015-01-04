//
//  LabelText.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-15.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "LabelText.h"

@implementation LabelText

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lab.frame=CGRectMake(0, 0, self.frame.size.width/4, self.frame.size.height);
        self.txt.frame=CGRectMake(0, 0, (self.frame.size.width*3)/4, self.frame.size.height);
        self.txt.backgroundColor=[UIColor yellowColor];
        [self addSubview:self.lab];
        [self addSubview:self.txt];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
