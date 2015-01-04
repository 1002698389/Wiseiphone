//
//  ImgBtn.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-5.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "ImgBtn.h"
#import "yShi.h"
@implementation ImgBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (IS_IPHONE_5_SCREEN) {
            self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(27, 12, 50, 50)];
            self.layer.borderWidth=2;
            self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        }
        else{
            self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(27, 12, 50, 50)];
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

@end
