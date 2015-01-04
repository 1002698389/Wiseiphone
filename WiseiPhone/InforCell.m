//
//  InforCell.m
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "InforCell.h"

@implementation InforCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.Iconmg=[[UIImageView alloc]init];
        self.Iconmg.frame=CGRectMake(self.bounds.origin.x+279, self.bounds.origin.y+45, 20, 20);
        [self.contentView addSubview:self.Iconmg];
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
