//
//  TiyanController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "TiyanController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "MyLineCell.h"
#import "TYController.h"
#import "YulanController.h"
#import "Tiyan2Controller.h"
#import "BaojingController.h"
extern int isnetwork;
@interface TiyanController ()

@end

@implementation TiyanController
{
    int y;
    BOOL _isClick;
    NSMutableArray *_titleArray;
    NSMutableArray *_pathArray;
    UITableView *_tableView;
    UITapGestureRecognizer *tap3;
    NSMutableArray *_videoPath;
    UIView *viewLay3;
    NSMutableArray * _picName;
    NSMutableArray * _btnName;
    UIView * scenView;
   // MyNavigationBar *mnb;
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
- (void)dealloc
{
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
- (void)viewWillAppear:(BOOL)animated{

    
    
    [self.view bringSubviewToFront:self.iview];

}
- (void)viewWillDisappear:(BOOL)animated
{

  [self setSelected:NO];

}
- (MyNavigationBar*)mnb{
    if (!_mnb) {
        _mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60)];
    }
    return _mnb;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    _isClick = YES;
    [self.navigationController setNavigationBarHidden:YES];
   // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"用户体验" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(0, 60, 320,SCREEN_HEIGHT-60)];
    vw.backgroundColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    [self.view addSubview:vw];
    [self.view addSubview:[self intruduceComp]];
    [self.view addSubview:self.mnb];
    _videoPath=[[NSMutableArray alloc]initWithObjects:@"区域计数1.mp4",@"双重警戒线.mp4",@"徘徊1.mp4",@"逗留1.mp4",@"物体遗留.mp4",@"物体失窃.mp4",@"运动物体计数12.mp4",@"警戒线.mp4",@"警戒线.mp4", nil];
    _picName=[[NSMutableArray alloc]initWithObjects:@"区域计数.png",@"双重警戒线.png",@"徘徊.png",@"逗留.png",@"YHTYlogo.png",@"物品.png",@"物品遗失.png",@"物体计数.png", @"警戒线1.png",nil];
    _btnName=[[NSMutableArray alloc]initWithObjects:@"区域计数",@"双重警戒线",@"徘徊",@"逗留",@"",@"物品遗留",@"物品失窃",@"物体记数",@"警戒线", nil];
    _pathArray =[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<_videoPath.count; i++) {
    NSString * bundlefilepath=[[NSBundle mainBundle] pathForResource:[_videoPath objectAtIndex:i] ofType:nil];
            [_pathArray addObject:bundlefilepath];
    }
    
    [self LoadBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addIview) name:@"ialert" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onlinecolor) name:@"online" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changefail) name:@"logfail" object:nil];
    [self.view addSubview:self.iview];
}
- (void)presentviewnext{
    BaojingController * bo=[[BaojingController alloc]init];
    [self presentViewController:bo animated:YES completion:nil];
    
}
- (void)onlinecolor{
    
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
    
}
- (MoveView*)iview
{
    if (!_iview) {
        _iview=[[MoveView alloc]initWithFrame:CGRectMake(136,60, 50, 50)];
        _iview.alpha=0.6;
        _iview.layer.cornerRadius=25;
        _iview.layer.masksToBounds=YES;
        if (isnetwork==1) {
            _iview.image=[UIImage imageNamed:@"警报球1-2.png"];
        }else{
            _iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];
        }
        _iview.userInteractionEnabled=YES;
        UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doHandlePanAction:)];
        [_iview addGestureRecognizer:pan];
        _iview.iviewdelegate=self;
    }
    return _iview;
}
- (void)addIview{
    
 
   
    [self alertcolor];
    
}
- (void)changefail{


   self.iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];

}
- (void)alertcolor
{
    
    
    self.iview.image=[UIImage imageNamed:@"警报球2-2.png"];
    [self performSelector:@selector(changeimage) withObject:self afterDelay:0.2];
    
}
- (void)changeimage{
    
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
    
}
- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
    UIView * view=[[UIApplication sharedApplication]keyWindow];
    CGPoint point = [paramSender translationInView:view];
    
    paramSender.view.center = CGPointMake(paramSender.view.center.x + point.x, paramSender.view.center.y + point.y);
    [paramSender setTranslation:CGPointMake(0, 0) inView:view];
    
    
}
- (void)baojing{

    BaojingController * baojin=[[BaojingController alloc]init];
    
    [self presentViewController:baojin animated:NO completion:nil];

}
- (UILabel*)intruduceComp
{
    
    
    UILabel *inlab=[[UILabel alloc]init];
    if (IS_IPHONE_5_SCREEN) {
        inlab.frame = CGRectMake(25, 0, 270, 340);
    }
    else{
        inlab.frame = CGRectMake(25, -47, 270, 340);
    }
    [inlab setLineBreakMode:NSLineBreakByWordWrapping];
    inlab.numberOfLines=0;
    inlab.textAlignment=NSTextAlignmentLeft;
    UILabel *tlab = [[UILabel alloc]init];
    if (IS_IPHONE_5_SCREEN) {
        tlab.frame = CGRectMake(10, 70, 310, 40);
    }
    else{
        tlab.frame = CGRectMake(0, 55, 320, 40);
    }
    
    tlab.text=@"关于威视科技";
    tlab.textAlignment=NSTextAlignmentCenter;
    tlab.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    if (IS_IPHONE_5_SCREEN) {
        inlab.text=@"        威视创建科技(北京)有限公司是一家专业从事计算机视觉与图像处理技术以及相关产品研发的高新技术企业，专注服务于智能视觉、智能安防监控领域、并已在相关领域沁润多年。公司紧紧把握前沿的科技创新...";
    }
    else{
        inlab.text=@"        威视创建科技(北京)有限公司是一家专业从事计算机视觉与图像处理技术以及相关产品研发的高新技术企业，专注服务于...";
    }
    inlab.font=[UIFont systemFontOfSize:14];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:inlab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2.0];//调整行间距
    [paragraphStyle setLineHeightMultiple:1.35];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [inlab.text length])];
    inlab.attributedText = attributedString;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(info)];
    tapGesture.numberOfTapsRequired=1;
    inlab.userInteractionEnabled = YES;
    [inlab addGestureRecognizer:tapGesture];
    [self.view addSubview:tlab];
    [self.view addSubview:inlab];
    return inlab;
}

-(void)info
{
    Tiyan2Controller *ty2c=[[Tiyan2Controller alloc]init];
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromTop";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    [self presentViewController:ty2c animated:NO completion:nil];
}

- (void)LoadBtn
{
    for (int i=0; i<3; i++) {
        
        for (int j=0; j<3; j++) {
            
            if (IS_IPHONE_5_SCREEN) {
                if (i==1&&j==2) {
                    //self.btn.frame=CGRectMake(106, 106+160, 106, 106);
                    self.btn.imgv.frame=CGRectMake(0, 0, 106, 106);
                    self.btn=[[ImgBtn alloc]initWithTarget:self action:@selector(presentPlayview:)];
                    self.btn.frame=CGRectMake(j*106, i*106+250, 106, 106);
                    self.btn.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
                    self.btn.nameLab.textAlignment=NSTextAlignmentCenter;
                    [self.btn addSubview:self.btn.nameLab];
                    self.btn.imgv.image=[UIImage imageNamed:[_picName objectAtIndex:3*i+j]];
                    self.btn.nameLab.text=[NSString stringWithFormat:@"%@",[_btnName objectAtIndex:3*i+j]];
                    self.btn.layer.borderWidth=1;
                    self.btn.layer.borderColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1].CGColor;
                    self.btn.backgroundColor=[UIColor whiteColor];
                    self.btn.tag=(i*3+j+1)*111;
                    self.btn.userInteractionEnabled=YES;
                    [self.view addSubview:self.btn];
                }else{
                    self.btn=[[ImgBtn alloc]initWithTarget:self action:@selector(presentPlayview:)];
                    self.btn.frame=CGRectMake(j*106, i*106+250, 106, 106);
                    self.btn.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
                    self.btn.nameLab.textAlignment=NSTextAlignmentCenter;
                    [self.btn addSubview:self.btn.nameLab];
                    self.btn.imgv.image=[UIImage imageNamed:[_picName objectAtIndex:3*i+j]];
                    self.btn.nameLab.text=[NSString stringWithFormat:@"%@",[_btnName objectAtIndex:3*i+j]];
                    self.btn.layer.borderWidth=1;
                    self.btn.layer.borderColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1].CGColor;
                    self.btn.backgroundColor=[UIColor whiteColor];
                    self.btn.tag=(i*3+j+1)*111;
                    self.btn.userInteractionEnabled=YES;
                    [self.view addSubview:self.btn];
                }
            }else{
                if (i==1&&j==2) {
                    self.btn.imgv.frame=CGRectMake(0, 0, 106, 106);
                    self.btn=[[ImgBtn alloc]initWithTarget:self action:@selector(presentPlayview:)];
                    self.btn.frame=CGRectMake(j*106, i*106+160, 106, 106);
                    self.btn.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
                    self.btn.nameLab.textAlignment=NSTextAlignmentCenter;
                    [self.btn addSubview:self.btn.nameLab];
                    self.btn.imgv.image=[UIImage imageNamed:[_picName objectAtIndex:3*i+j]];
                    self.btn.nameLab.text=[NSString stringWithFormat:@"%@",[_btnName objectAtIndex:3*i+j]];
                    self.btn.layer.borderWidth=1;
                    self.btn.tag=(i*3+j+1)*111;;
                    self.btn.layer.borderColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1].CGColor;
                    self.btn.backgroundColor=[UIColor whiteColor];
                    self.btn.userInteractionEnabled=YES;
                    [self.view addSubview:self.btn];
                }else{
                    self.btn=[[ImgBtn alloc]initWithTarget:self action:@selector(presentPlayview:)];
                    self.btn.frame=CGRectMake(j*106, i*106+160, 106, 106);
                    self.btn.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
                    self.btn.nameLab.textAlignment=NSTextAlignmentCenter;
                    [self.btn addSubview:self.btn.nameLab];
                    self.btn.imgv.image=[UIImage imageNamed:[_picName objectAtIndex:3*i+j]];
                    self.btn.nameLab.text=[NSString stringWithFormat:@"%@",[_btnName objectAtIndex:3*i+j]];
                    self.btn.layer.borderWidth=1;
                    self.btn.tag=(i*3+j+1)*111;;
                    self.btn.layer.borderColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1].CGColor;
                    self.btn.backgroundColor=[UIColor whiteColor];
                    self.btn.userInteractionEnabled=YES;
                    [self.view addSubview:self.btn];
                }
                
            }
            
            
        }
    }



}
- (void)remove:(NSNotification*)info
{
    BOOL isOk=[[[info userInfo]valueForKey:@"isc"] boolValue];
    if (isOk==YES) {
        [self setSelected:NO];
   
        _isClick = YES;
    }
    
    
}
- (void)takemsg:(NSNotification*)info
{
    _isClick=[[[info userInfo]valueForKey:@"ck"] boolValue];

}

- (void)presentPlayview:(ImgBtn*)btn
{
//    scenView=[[UIView alloc]init];
//    scenView.bounds=btn.bounds;
//    scenView.backgroundColor=[UIColor blackColor];
//    scenView.alpha=0.8;
//    [self.view addSubview:scenView];
    [self performSelector:@selector(removeview) withObject:self afterDelay:0.2];
    NSString *moviePath;
    if (btn.tag==111) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:0];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        test.ititle=[_btnName objectAtIndex:0];
        [self presentViewController:test animated:NO completion:nil];
    }
    if (btn.tag==222) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:1];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:1];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
     
    }
    if (btn.tag==333) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:2];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:2];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
    }
    if (btn.tag==444) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:3];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:3];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
    }
    if (btn.tag==555) {
        NSLog(@"威视科技");
    }
    if (btn.tag==666) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:4];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:5];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
    }
    if (btn.tag==777) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:5];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:6];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
        
    }
    if (btn.tag==888) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:6];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:7];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
    }
    if (btn.tag==999) {
        TestController * test=[[TestController alloc]init];
        moviePath=[_pathArray objectAtIndex:7];
        test.path=moviePath;
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        test.ititle=[_btnName objectAtIndex:8];
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:test animated:NO completion:nil];
    }
    
 
}
- (void)removeview
{
   // [scenView removeFromSuperview];

}
#pragma mark - NavigationBar
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)removeroot
{
    [viewLay3 removeFromSuperview];
    [self setSelected:NO];
    _isClick = YES;
    
}
- (void)bbiClick:(UIButton *)btn
{
  
    if (btn.tag == 0)
    {
        if (_isClick == YES)
        {
           
            [self setSelected:YES];
            
            [self.view addSubview:self.rootc.rootView];
            _isClick = NO;
            [self.mnb.superview bringSubviewToFront:self.mnb];
        }else

        {
            [self setSelected:NO];
            [self.rootc.rootView removeFromSuperview];
            _isClick = YES;
        }
    }
    if (btn.tag == 1)
    {
        YulanController * yulan=[[YulanController alloc]init];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:yulan animated:NO completion:nil];
        //[self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
