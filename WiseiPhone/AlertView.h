//
//  AlertView.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-16.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
@property(nonatomic,strong)UIImageView *imgv;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UILabel *tlab;
- (void)createAlertView:(id)target action:(SEL)action;
@end
