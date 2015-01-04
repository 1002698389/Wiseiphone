//
//  LinkListCell.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-18.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "LinkListCell.h"

@implementation LinkListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.vv=[[UIView alloc]init];
        self.vv.backgroundColor=[UIColor whiteColor];
        self.backgroundColor=[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        [self.contentView addSubview:self.vv];
        self.lab1=[[UILabel alloc]initWithFrame:CGRectMake(40, 3, 200, 50)];
        self.lab1.font=[UIFont systemFontOfSize:15];
        self.lab2=[[UILabel alloc]initWithFrame:CGRectMake(self.lab1.frame.origin.x, 46, 120, 40)];
        self.lab2.font=[UIFont systemFontOfSize:12];
        self.lab3=[[UILabel alloc]initWithFrame:CGRectMake(180, 46, 100, 40)];
        self.lab3.font=[UIFont systemFontOfSize:12];
        self.lab4=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 160, 40)];
        self.lab4.font=[UIFont systemFontOfSize:12];
        self.lab5=[[UILabel alloc]initWithFrame:CGRectMake(180, 80, 100, 40)];
        self.lab5.font=[UIFont systemFontOfSize:12];
        self.lab6=[[UILabel alloc]initWithFrame:CGRectMake(140, 50, 60, 30)];
        self.lab6.font=[UIFont systemFontOfSize:12];
        self.lab6.textAlignment=NSTextAlignmentCenter;
        self.lpkbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.lpkbtn.frame=CGRectMake(240, 30, 60, 30);
        self.lpkbtn.backgroundColor=[UIColor blackColor];
        self.lpkbtn.tintColor=[UIColor whiteColor];
        self.lpkbtn.layer.cornerRadius=5;
        self.lpkbtn.layer.masksToBounds=YES;
        [self.contentView addSubview:self.lpkbtn];
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
        [self.contentView addSubview:self.lab6];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
