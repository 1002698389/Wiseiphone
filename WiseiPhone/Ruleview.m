//
//  Ruleview.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Ruleview.h"

@implementation Ruleview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, 320, 54);
        self.backgroundColor=[UIColor lightGrayColor];
        
        self.playbtn=[UIButton buttonWithType:UIButtonTypeSystem];
        self.playbtn.frame=CGRectMake(30, 3, 50, 50);
       [self.playbtn setImage:[UIImage imageNamed:@"JKAbottomBF.png"] forState:UIControlStateNormal];
        [self addSubview:self.playbtn];
        self.editbtn=[UIButton buttonWithType:UIButtonTypeSystem];
        self.editbtn.frame=CGRectMake(140, 3, 50, 50);
        [self.editbtn setImage:[UIImage imageNamed:@"JKAbottomBJ.png"] forState:UIControlStateNormal];
        [self addSubview:self.editbtn];
        self.deletbtn=[UIButton buttonWithType:UIButtonTypeSystem];
        self.deletbtn.frame=CGRectMake(240, 3, 50, 50);
        [self.deletbtn setImage:[UIImage imageNamed:@"JKAbottomSC.png"] forState:UIControlStateNormal];
        [self addSubview:self.deletbtn];
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
