//
//  RootViewController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "YulanController.h"
#import "LuxianController.h"
#import "BaojingController.h"
#import "TiyanController.h"
#import "ZhinengController.h"
#import "XitongController.h"
#import "yShi.h"
#import "LXController.h"
#import "TestController.h"
#import "PlayMovieController.h"
#import "ListChannelController.h"
@interface RootViewController ()

@end

@implementation RootViewController
{
    int y;
    NSMutableArray *_image;
    NSMutableArray *_title;
    NSMutableArray *_viewControllers;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
        {
            y = 20;
            self.hidesBottomBarWhenPushed = NO;
        }
        else
            self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
//    _viewControllers = [[NSMutableArray alloc]initWithObjects:self.yuvc,self.luvc,self.baovc,self.lxvc,self.tivc,self.zhivc,self.xivc,self.xtvc, nil];
    
       _viewControllers = [[NSMutableArray alloc]initWithObjects:self.yuvc,self.tivc,self.zhivc,self.xivc,self.baovc,self.lccvc, nil];
    self.rootView= [[UIView alloc]initWithFrame:CGRectMake(0, -120, SCREEN_WIDTH,180)];
    self.rootView.backgroundColor = [UIColor colorWithRed:0.11f green:0.16f blue:0.20f alpha:1.00f];
    _image = [[NSMutableArray alloc]initWithObjects:@"JKAmenu1.png",@"JKAmenu4.png",@"JKAmenu5.png",@"JKAmenu6.png",@"JKAmenu3.png",@"img_dvdm.png", nil];
    _title = [[NSMutableArray alloc]initWithObjects:@"实时预览",@"用户体验",@"规则管理",@"系统设置",@"报警信息",@"设备管理",nil];
    for (int i=0; i<2; i++)
    {
        for (int j=0; j<4; j++)
        {
            
            
            //            btn.frame = CGRectMake(0+j*80, 0, 80, 80);
            if (_title.count>i*4+j) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+j*80, 0+i*80, 80, 80);
                [btn setImage:[UIImage imageNamed:[_image objectAtIndex:i*4+j]] forState:UIControlStateNormal];
                UILabel * txtlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, 80, 20)];
                txtlabel.text=[NSString stringWithFormat:@"%@",[_title objectAtIndex:i*4+j]];
                txtlabel.textColor=[UIColor whiteColor];
                txtlabel.textAlignment=NSTextAlignmentCenter;
                txtlabel.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
                [btn addSubview:txtlabel];
                
                btn.tag =i*4+j;
                
                [btn addTarget:self action:@selector(MenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.rootView addSubview:btn];
            }
            
            //            [btn setImage:[UIImage imageNamed:[_image objectAtIndex:j]] forState:UIControlStateNormal];
            
            //            txtlabel.text=[NSString stringWithFormat:@"%@",[_title objectAtIndex:j]];
            
            
        }
    }
   
}
//- (UIView*)rootView
//{
//    if (!_rootView) {
//        _rootView
//    }
//    return _rootView;
//}
- (UIView*)viewLayer
{
    if (!_viewLayer) {
        _viewLayer=[[UIView alloc]initWithFrame:CGRectMake(0, 40+y+180, SCREEN_WIDTH, SCREEN_HEIGHT-40-y-180)];
    }
    return _viewLayer;
}
- (PlayMovieController*)xtvc
{
    if (!_xtvc) {
        _xtvc=[[PlayMovieController alloc]init];
    }
    return  _xtvc;
}
- (YulanController*)yuvc
{
    if (!_yuvc) {
        _yuvc = [[YulanController alloc]init];
    }
    return _yuvc;

}
- (LuxianController*)luvc
{
    if (!_luvc) {
        _luvc=[[LuxianController alloc]init];
    }

    return _luvc;
}
- (BaojingController*)baovc
{
    if (!_baovc) {
        _baovc=[[BaojingController alloc]init];
    }
    return  _baovc;

}
- (LXController*)lxvc
{
    if (!_lxvc) {
        _lxvc=[[LXController alloc]init];
    }
    return _lxvc;

}
- (TiyanController*)tivc
{
    if (!_tivc) {
        _tivc=[[TiyanController alloc]init];
    }
    return _tivc;
}
- (ZhinengController*)zhivc
{
    if (!_zhivc) {
        _zhivc=[[ZhinengController alloc]init];
    }

    return _zhivc;
}
- (XitongController*)xivc
{
    if (!_xivc) {
        _xivc=[[XitongController alloc]init];
    }
    return _xivc;

}
- (ListChannelController*)lccvc{
    if (!_lccvc) {
        _lccvc=[[ListChannelController alloc]init];
    }
    return _lccvc;
}
- (void)setSelected:(BOOL)selected
{
    
    if (selected==YES) {
        
//        _image = [[NSMutableArray alloc]initWithObjects:@"JKAmenu1.png",@"JKAmenu2.png",@"JKAmenu3.png",@"JKAmenu7.png",@"JKAmenu4.png",@"JKAmenu5.png",@"JKAmenu6.png",@"JKAmenu8.png", nil];
//        _title = [[NSMutableArray alloc]initWithObjects:@"实时预览",@"录像管理",@"报警信息",@"图像管理",@"用户体验",@"智能设置",@"系统设置",@"用户登录", nil];
       

       
       // [self.rootView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rootView.tiff"]]];
        
        
         [self.view addSubview:self.rootView];
        [self.view addSubview:self.viewLayer];
      UITapGestureRecognizer *tapone=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeroot)];
        tapone.numberOfTapsRequired=1;
        [self.viewLayer addGestureRecognizer:tapone];
        self.viewLayer.userInteractionEnabled=YES;
        [UIView animateWithDuration:0.3 animations:^{
    
            self.rootView.frame =CGRectMake(0, 60, 320, 180);
        }completion:nil];
      
        self.viewLayer.hidden=NO;
        
    }else{
        self.viewLayer.hidden=YES;
        [UIView animateWithDuration:0.3 animations:^{
           
            self.rootView.frame = CGRectMake(0, -120, 320, 180);
        }completion:nil];
    
    }
}

- (void) addbtn
{
   

}
- (void)removeroot
{
    NSNumber * isCancel=[NSNumber numberWithBool:YES];
    NSDictionary * dic=[NSDictionary dictionaryWithObjectsAndKeys:isCancel,@"isc", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelrootview" object:nil userInfo:dic];

}
- (void)MenuBtnClick:(UIButton *)btn
{
    
    NSNumber * isclk=[NSNumber numberWithBool:YES];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:isclk forKey:@"ck"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selc" object:nil userInfo:dict];
    UIViewController * mdc=_viewControllers[btn.tag];
    self.RtvDelegate=self.yuvc;
    [self.RtvDelegate clearVideo:btn.tag];
    
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromTop";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    //[self.navigationController pushViewController:mdc animated:NO];
    [self presentViewController:mdc  animated:NO completion:nil];
    [self.rootView removeFromSuperview];
    [self.viewLayer removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   

}
@end
