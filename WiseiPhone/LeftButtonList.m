//
//  LeftButtonList.m
//  WiseiPhone
//
//  Created by fcw on 14-7-3.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "LeftButtonList.h"
#import "yShi.h"
#import "RootViewController.h"
@implementation LeftButtonList
{
    int y;
    NSMutableArray *_image;
    NSMutableArray *_title;
    NSMutableArray *_viewControllers;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[NSMutableArray alloc]initWithObjects:@"JKAmenu1.png",@"JKAmenu2.png",@"JKAmenu3.png",@"JKAmenu4.png",@"JKAmenu5.png",@"JKAmenu6.png", nil];
        _title = [[NSMutableArray alloc]initWithObjects:@"实时预览",@"录像管理",@"报警信息",@"用户体验",@"智能设置",@"系统设置", nil];
        //_rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 40+y, SCREEN_WIDTH, 200)];
        self.backgroundColor = [UIColor colorWithRed:0.11f green:0.16f blue:0.20f alpha:1.00f];
        for (int i=0; i<2; i++)
        {
            for (int j=0; j<3; j++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+j*107, 0+i*107, 106, 106);
                [btn setImage:[UIImage imageNamed:[_image objectAtIndex:i*3+j]] forState:UIControlStateNormal];
                btn.tag = i*3+j;
                [btn addTarget:self action:@selector(MenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
        }
    }
    return self;
}
- (void)MenuBtnClick:(UIButton *)btn
{
    RootViewController * rvc=[[RootViewController alloc]init];
    [rvc presentViewController:(UIViewController *)_viewControllers[btn.tag] animated:YES completion:nil];
    [_rootView removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
