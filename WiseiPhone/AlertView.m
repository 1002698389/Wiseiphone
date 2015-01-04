//
//  AlertView.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-16.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=20;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
        // Initialization code
    }
    return self;
}

- (UIButton*)btn
{
    if (!_btn) {
       
    }
    return _btn;
}
- (UIImageView*)imgv
{
    if (!_imgv) {
        
    }
    return _imgv;
}
- (UILabel*)lab
{
    if (!_lab) {
        
    }

    return _lab;
}
- (UILabel*)tlab
{
    if (_tlab) {
        
    }

    return _tlab;
}
- (void)createAlertView:(id)target action:(SEL)action
{
    
    //self.backgroundColor=[UIColor colorWithRed:221/255 green:221/255 blue:221/255 alpha:0];
   self.imgv=[[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 250, 250)];
    self.imgv.backgroundColor=[UIColor whiteColor];
    self.imgv.layer.cornerRadius=20;
    self.imgv.layer.masksToBounds=YES;
    //29,128,211
    
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[self.btn setTitle:@"确认" forState:UIControlStateNormal];
    self.btn.backgroundColor=[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    UILabel * lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 252, 50)];
    lab.text=@"确认";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:22];
    lab.textColor=[UIColor colorWithRed:0.11 green:0.5 blue:0.83 alpha:1];
    self.btn.frame=CGRectMake(0,self.bounds.size.height-50 , 252, 50);
    [self.btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.btn addSubview:lab];
    self.lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, 100, 30)];
    self.lab.textColor=[UIColor redColor];
    self.lab.font=[UIFont systemFontOfSize:16];
    self.tlab=[[UILabel alloc]initWithFrame:CGRectMake(132, 260, 120, 30)];
    self.tlab.textColor=[UIColor redColor];
    self.tlab.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.lab ];
    [self addSubview:self.tlab];
    [self addSubview:self.imgv];
    [self addSubview:self.btn ];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  


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
