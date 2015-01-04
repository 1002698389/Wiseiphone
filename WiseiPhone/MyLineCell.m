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
        self.btn=[[UIImageView alloc]initWithFrame:CGRectMake(200, 0, 22, 22)];
        self.btn.backgroundColor=[UIColor redColor];
        self.isinfo=[[UILabel alloc]init];
        self.isinfo.frame=CGRectMake(200,5,80,30);
        self.isinfo.font=[UIFont systemFontOfSize:12];
        self.isinfo.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.isinfo];
        [self.contentView addSubview:self.btn];
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
