//
//  MyView.h
//  WiseiPhone
//
//  Created by fcw on 14-7-1.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyView : UIView

@property(nonatomic,strong) UILabel *label;
- (void)drawRect:(CGRect)rect;
- (void)takestate;
- (void)takeoff;
@end
