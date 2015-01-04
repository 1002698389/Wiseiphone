//
//  PaintDraw.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-11-26.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"
@interface PaintDraw : UIView

@property(nonatomic,assign)int begin;
@property(nonatomic,strong)NSMutableArray *shapes;
@property(nonatomic,assign)CGRect iframe;
@property(nonatomic,strong)NSMutableArray * isenable;
@end
