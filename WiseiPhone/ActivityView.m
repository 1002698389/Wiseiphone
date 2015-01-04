//
//  ActivityView.m
//  WiseiPhone
//
//  Created by fcw on 14-7-4.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithTarget:(id)target action:(SEL)action
{
    self=[super init];
    if (self) {
        _target=target;
        _action=action;
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 

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
