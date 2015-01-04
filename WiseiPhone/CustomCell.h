//
//  CustomCell.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rules.h"

@interface CustomCell : UITableViewCell
@property(nonatomic,strong)UIButton *playbtn;
@property(nonatomic,strong)UIButton *editbtn;
@property(nonatomic,strong)UIButton *deletbtn;
@property(nonatomic,strong)UILabel * txtlb;
@property(nonatomic,strong)Rules *rule;
@end
