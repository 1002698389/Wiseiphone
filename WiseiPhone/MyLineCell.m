//
//  MyLineCell.m
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "MyLineCell.h"

@implementation MyLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 35)];
       // self.imageIcon.backgroundColor=[UIColor redColor];
        self.titleName=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, 80, 30)];
      // [self.titleName setBackgroundColor:[UIColor greenColor]];
        self.titleName.font=[UIFont systemFontOfSize:12];
        self.titleName.textAlignment=NSTextAlignmentCenter;
        self.isinfo=[[UILabel alloc]initWithFrame:CGRectMake(200,5,80,30)];
        self.isinfo.font=[UIFont systemFontOfSize:12];
        self.btn=[[UIImageView alloc]initWithFrame:CGRectMake(278, 11, 22, 22)];
        [self.contentView addSubview:self.btn];
        [self.contentView addSubview:self.isinfo];
        [self.contentView addSubview:self.titleName];
        [self.contentView addSubview:self.imageIcon];
        // Initialization code
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
