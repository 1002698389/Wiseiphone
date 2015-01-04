//
//  InforCell.h
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InforCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *Iconmg;

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *titleType;
@property (weak, nonatomic) IBOutlet UILabel *titleTime;
@property (weak, nonatomic) IBOutlet UIImageView *alertpic;
@property (nonatomic,strong)UIImageView * defaultpic;
@end
