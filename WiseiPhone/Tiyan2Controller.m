//
//  Tiyan2Controller.m
//  WiseiPhone
//
//  Created by chou an on 14-8-7.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Tiyan2Controller.h"
#import "TiyanController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "MyLineCell.h"
#import "TYController.h"
#import "BaojingController.h"
extern int isnetwork;
@implementation Tiyan2Controller
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

    [self.view addSubview:self.iview];
    [self.view bringSubviewToFront:self.iview];
}
- (void)viewWillDisappear:(BOOL)animated{

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
    [self.mnb createNavigationBarWithImage:@"用户体验" andLeftButtonImageName:@"" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 508)];
    infoView.backgroundColor = [UIColor whiteColor];
    UILabel *info = [[UILabel alloc]init];
    if (IS_IPHONE_5_SCREEN) {
        info.frame = CGRectMake(20, 50, 280, 300);
    }
    else{
        info.frame = CGRectMake(20, 0, 280, 300);
    }
    [info setLineBreakMode:NSLineBreakByWordWrapping];
    info.numberOfLines=0;
    info.textAlignment=NSTextAlignmentNatural;
    UILabel *tilab=[[UILabel alloc]init];
    if (IS_IPHONE_5_SCREEN) {
        tilab.frame = CGRectMake(0, 10, 320, 40);
    }
    else{
        tilab.frame = CGRectMake(0, -5, 320, 40);
    }
    tilab.text=@"关于威视科技";
    tilab.textAlignment=NSTextAlignmentCenter;
    tilab.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    info.text=@"       威视创建科技（北京）有限公司是一家专业从事计算机视觉与图像处理技术以及相关产品研发的高新技术企业，专注服务于智能视觉、智能安防监控领域，并已在相关领域沁润多年。公司紧紧把握前沿的科技创新理念，依托优秀的研发团队，采用国际上最先进且实用的算法理论，成功开发出具有完全自主知识产权的智能安全防护的系列产品；公司秉承“开拓创新、品质一流、客户满意”的经营理念，将倾力于为公安、交通、金融、电力、物业管理、体育场馆等行业提供稳定可靠、专业先进的视频软、硬件系统和解决方案。公司矢志成为一流的智能视频分析、智能监控解决方案的供应商和相应硬软件系统的开发商、并期望在计算机视觉技术领域有长久的建树以及较深远的影响力。";
    if (IS_IPHONE_5_SCREEN) {
        info.font=[UIFont systemFontOfSize:14];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:info.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2.0];//调整行间距
        [paragraphStyle setLineHeightMultiple:1.0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [info.text length])];
        info.attributedText = attributedString;
    }
    else
    {
        info.font=[UIFont systemFontOfSize:12.5];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:info.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2.0];//调整行间距
        [paragraphStyle setLineHeightMultiple:1.0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [info.text length])];
        info.attributedText = attributedString;
    }

    [infoView addSubview:tilab];
    [infoView addSubview:info];
    UIImageView* flowChart = [[UIImageView alloc]init];
    if (IS_IPHONE_5_SCREEN) {
        flowChart.frame = CGRectMake(22, 420, 277, 141);
    }
    else{
        flowChart.frame = CGRectMake(22, 340, 277, 141);
    }
    
    
    [flowChart setImage:[UIImage imageNamed:@"flowView.jpg"]];
    
    [self.view addSubview:infoView];
    [self.view addSubview:flowChart];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addIview) name:@"ialert" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onlinecolor) name:@"online" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changefail) name:@"logfail" object:nil];
}
- (void)presentviewnext{
    BaojingController * bo=[[BaojingController alloc]init];
    [self presentViewController:bo animated:YES completion:nil];
    
}
- (void)onlinecolor{
    
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
    
}
- (void)changefail{

    self.iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];

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
    if (btn.tag == 1)
    {
        TiyanController * ty=[[TiyanController alloc]init];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:ty animated:NO completion:nil];
       // [self dismissViewControllerAnimated:NO completion:nil];
    }
}



@end
