//
//  Paint.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-11-25.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Shape.h"

@interface Paint : UIView

@property(nonatomic,assign)int begin;
@property(nonatomic,strong)NSMutableArray *shapes;

@end
