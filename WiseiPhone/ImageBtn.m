//
//  ImageBtn.m
//  WiseiPhone
//
//  Created by fcw on 14-7-17.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "ImageBtn.h"
#import "yShi.h"
@implementation ImageBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IS_IPHONE_5_SCREEN) {
            self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 64, 40)];
//            self.layer.borderWidth=1;
//            self.layer.borderColor=[UIColor colorWithRed:125/225.0f green:134/225.0f blue:146/225.0f alpha:1.00f].CGColor;
        }
        else{
            self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 40)];
        }
        [self addSubview:self.imgv];
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
  
    [_target performSelector:_action withObject:self];

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
