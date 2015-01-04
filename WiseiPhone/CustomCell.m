//
//  CustomCell.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "CustomCell.h"
#import "Rules.h"
#import "ZhinengController.h"
#import "PlayMovieController.h"
#import "kxmovie/KxMovieViewController.h"
@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor=[UIColor grayColor].CGColor;
        self.layer.borderWidth=1;
        self.playbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.playbtn.frame=CGRectMake(55, 10, 25, 25);
        [self.playbtn setImage:[UIImage imageNamed:@"JKAmoreBF.png"] forState:UIControlStateNormal];
        [self.playbtn addTarget:self action:@selector(playmovie) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playbtn];
        self.editbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.editbtn.frame=CGRectMake(150, 10, 25, 25);
        [self.editbtn setImage:[UIImage imageNamed:@"JKAmoreBJ.png"] forState:UIControlStateNormal];
        [self.editbtn addTarget:self action:@selector(updatedata) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.editbtn];
        self.deletbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.deletbtn.frame=CGRectMake(245, 10, 25, 25);
        [self.deletbtn setImage:[UIImage imageNamed:@"JKAmoreSC.png"] forState:UIControlStateNormal];
        [self.deletbtn addTarget:self action:@selector(deletdata) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deletbtn];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getdata:) name:@"takedata" object:nil];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)updatedata
{
    NSLog(@"updaterule=%@",self.rule.rulename);
    NSDictionary *update=[NSDictionary dictionaryWithObjectsAndKeys:self.rule,@"dat",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"update" object:self userInfo:update];


}
- (void)getdata:(NSNotification*)info
{
    self.rule=nil;
    self.rule=[[info userInfo]valueForKey:@"rule"];
   

}
- (void)playmovie
{
    
    NSDictionary * dic=[NSDictionary dictionaryWithObjectsAndKeys:self.rule,@"mynum", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playmovie" object:self userInfo:dic];
   
    

}
- (void)deletdata
{
   
    NSDictionary * dic=[NSDictionary dictionaryWithObjectsAndKeys:self.rule,@"rule", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"editData" object:self userInfo:dic];
    NSLog(@"执行删除数据");
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
