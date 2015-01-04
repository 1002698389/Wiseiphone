//
//  DisplayList.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "DisplayList.h"

@implementation DisplayList

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.list=[[UILabel alloc]initWithFrame:CGRectMake(33,10, 200, 30)];
        self.uselab=[[UILabel alloc]initWithFrame:CGRectMake(220, 10, 80, 30)];
        self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(280, 10, 25, 25)];
        [self.contentView addSubview:self.uselab];
        [self.contentView addSubview:self.list];
        [self.contentView addSubview:self.imgv];
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
