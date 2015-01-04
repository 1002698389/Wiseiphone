//
//  MyNavigationBar.m
//  意林News
//
//  Created by Michelle on 14-3-3.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createNavigationBarWithImage:(NSString *)name andLeftButtonImageName:(NSString *)leftImageName andRightButtonImageName:(NSString *)rightImageName andSEL:(SEL)sel andClass:(id)classObject
{
    //设置背景色
    [self createBackGroundImageView];
    
    [self createTitleViewWithName:name];
    //创建按钮
    if (leftImageName.length>0)
    {
        [self createBarButtonItemWithImageName:leftImageName andSEL:sel andClass:classObject andType:0];
    }
    if (rightImageName.length>0)
    {
        [self createBarButtonItemWithImageName:rightImageName andSEL:sel andClass:classObject andType:1];
    }
}
- (void)createBackGroundImageView
{
    UIView *groundView = [[UIView alloc]initWithFrame:self.bounds];
    groundView.backgroundColor = [UIColor colorWithRed:0.11f green:0.16f blue:0.20f alpha:1.00f];
    [self addSubview:groundView];
}
- (void)createTitleViewWithName:(NSString *)name
{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    title.backgroundColor = [UIColor colorWithRed:0.01f green:0.49f blue:0.78f alpha:1.00f];
    title.text = name;
    title.font = [UIFont boldSystemFontOfSize:21];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
}
- (void)createBarButtonItemWithImageName:(NSString *)imageName andSEL:(SEL)sel andClass:(id)classObject andType:(int)type
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if (type == 0)
    {
        btn.frame = CGRectMake(10, 25, image.size.width/2, image.size.height/2);
        btn.tag = 0;
    }
    else
    {
        btn.frame = CGRectMake(320-image.size.width/2-10, 25, image.size.width/2, image.size.height/2);
        btn.tag = 1;
    }
    [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
@end
