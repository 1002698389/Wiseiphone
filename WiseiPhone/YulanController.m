//
//  YulanController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "YulanController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "YLController.h"
#import "Draw.h"
#import "ActivityView.h"
#import "LeftButtonList.h"
#import "SocketServer.h"
#import "MyView.h"
#import "Rules.h"
#import "Getrules.h"
#import "Dbcon.h"
#import "saveIndex.h"
#import "urlinfo.h"
#import "MoveView.h"
#import "BaojingController.h"
#import "Paint.h"
#import "Shape.h"

//#import "VideoController.h"
extern KxMovieViewController *video1;
extern KxMovieViewController *video2;
extern KxMovieViewController *video3;
extern KxMovieViewController *video4;
extern int isinterest;
extern int istunel;
extern int isnetwork;
 NSArray *  tmidx;
extern NSMutableArray * idxpaths;
@interface YulanController ()

@end
//   extern CGImageRef UIGetScreenImage();
@implementation YulanController
{
    int y;
    //BOOL _isClick;
    BOOL _selected;
    BOOL _selectbig;
    int total;
    int isCount;
    NSString * clik;
//    UIView *_consoleView;
    UIView *_ruleView;
    UIView *_definitionView;
    NSMutableArray *_leiXing;
    NSMutableArray *_fangan;
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UIView *view4;
    BOOL _secClick;
    Draw *_draw;
    BOOL _isSingle;
    BOOL _isDouble;
    int _tag;
    int _isScale;
    UILabel * _lab;
    NSMutableArray *displayImgs;
    NSMutableArray *checkBoxs;
    NSMutableArray *imG;
    NSMutableArray *faCode;
    NSString * pointstring;
    UILabel *_info;
    UIView * viewv;
    int Big;
    NSString * _typename;
    int _checktag;
    UILabel *tint;
    NSMutableArray * _indexs;
    NSMutableArray * _paths;
    NSMutableArray * _chnames;
   // MyNavigationBar *mnb;
    NSMutableArray * rulearray;
    NSMutableArray * newrulearray;
    NSMutableArray * myindexs;
    NSMutableArray * movieurl;
    NSMutableArray * widths;
    NSMutableArray *heights;
    NSMutableArray *channels;
//    KxMovieViewController * video1;
//    KxMovieViewController * video2;
//    KxMovieViewController * video3;
//    KxMovieViewController * video4;
}
- (UIView*)backGround
{
    if (!_backGround) {
        _backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGround.backgroundColor = [UIColor colorWithRed:12.0/255.0f green:13.0/255.0f blue:15.0/255.0f alpha:0.7f];
    }
   
    
    return _backGround;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        total=0;
       self.idx=[NSMutableArray arrayWithCapacity:1];
        _indexs=[NSMutableArray arrayWithCapacity:1];
        _paths=[NSMutableArray arrayWithCapacity:1];
        _chnames=[NSMutableArray arrayWithCapacity:1];
        rulearray=[NSMutableArray arrayWithCapacity:1];
        newrulearray=[NSMutableArray arrayWithCapacity:1];
        myindexs=[NSMutableArray arrayWithCapacity:1];
        movieurl=[NSMutableArray arrayWithCapacity:1];
        widths=[NSMutableArray arrayWithCapacity:1];
        heights=[NSMutableArray arrayWithCapacity:1];
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
    [self.bfView1 removeFromSuperview];
    [self.bfView2 removeFromSuperview];
    [self.bfView3 removeFromSuperview];
    [self.bfView4 removeFromSuperview];
    [self.focal1 removeFromSuperview];
    [self.focal2 removeFromSuperview];
    [self.focalView removeFromSuperview];
    [self.ruleview1 removeFromSuperview];
    [self.ruleview2 removeFromSuperview];
    [self.rootView removeFromSuperview];
    [self.lt1 removeFromSuperview];
    [self.lt2 removeFromSuperview];
    [self.lt3 removeFromSuperview];
    [self.lt4 removeFromSuperview];
    [self.litteltitle removeFromSuperview];
    [self.slider removeFromSuperview];
    [self.scroll removeFromSuperview];
    [self.upbtn removeFromSuperview];
    [self.downbtn removeFromSuperview];
    [self.leftbtn removeFromSuperview];
    [self.rightbtn removeFromSuperview];
    [self.page removeFromSuperview];
    [self.paint1 removeFromSuperview];
    [self.paint2 removeFromSuperview];
    [self.paint3 removeFromSuperview];
    [self.paint4 removeFromSuperview];
    [self.paint5 removeFromSuperview];
    [self.paint6 removeFromSuperview];
    [self.paint7 removeFromSuperview];
    [self.paint8 removeFromSuperview];
    [self.backGround  removeFromSuperview];
    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [video1 deleteself];
    [video2 deleteself];
    [video3 deleteself];
    [video4 deleteself];
    [video1.view removeFromSuperview];
    [video2.view removeFromSuperview];
    [video3.view removeFromSuperview];
    [video4.view removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated
{
   
   int info=[[Getrules shareRules] takeurlinfocount];
    //NSMutableArray * info=[[NSMutableArray alloc]initWithObjects:@"1", nil];
    if (info==0) {
        UIButton * btn11=(UIButton*)[self.optionview viewWithTag:11];
        UIButton * btn12=(UIButton*)[self.optionview viewWithTag:12];
        UIButton * btn13=(UIButton*)[self.optionview viewWithTag:13];
        UIButton * btn15=(UIButton*)[self.optionview viewWithTag:15];
        UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
        UIButton * btn16=(UIButton*)[self.optionview viewWithTag:16];
        btn11.enabled=NO;
        btn12.enabled=NO;
        btn13.enabled=NO;
        btn14.enabled=NO;
        btn15.enabled=NO;
        btn16.enabled=NO;
    }
  

    

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
   NSString * ss=[user objectForKey:@"av"];
    if ([ss isEqualToString:@"一"]) {
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
    }
    if ([ss isEqualToString:@"二"]) {
        [self.bfView1 takeoff];
        [self.bfView2 takestate];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
    }
    if ([ss isEqualToString:@"三"]) {
        [self.bfView1 takeoff];
        [self.bfView2 takeoff];
        [self.bfView3 takestate];
        [self.bfView4 takeoff];
    }
    if ([ss isEqualToString:@"四"]) {
        [self.bfView1 takeoff];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takestate];
    }
    [self.view addSubview:self.bfView1];
    [self.view addSubview:self.bfView2];
    [self.view addSubview:self.bfView3];
    [self.view addSubview:self.bfView4];
//    NSNumber * width=[NSNumber numberWithInt:156];
//    NSNumber * height=[NSNumber numberWithInt:139];
//    NSDictionary * numdic=[NSDictionary dictionaryWithObjectsAndKeys:width,@"wth",height,@"hgt", nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeframe" object:self userInfo:numdic];
    //[self addMovieFour:info];
    [self.view addSubview:self.iview];
    [self.view bringSubviewToFront:self.iview];
     [self performSelector:@selector(removeact) withObject:self afterDelay:5];
    NSLog(@"---------------------------------------------idxpaths=%@",idxpaths);
}
- (void)viewWillDisappear:(BOOL)animated
{
//    [video1 clearBuffer];
//    [video2 clearBuffer];
//    [video3 clearBuffer];
//    [video4 clearBuffer];
//    [self.bfView1 removeFromSuperview];
//    [self.bfView2 removeFromSuperview];
//    [self.bfView3 removeFromSuperview];
//    [self.bfView4 removeFromSuperview];
//    self.bfView1=nil;
//    self.bfView2=nil;
//    self.bfView3=nil;
//    self.bfView4=nil;
//    [_paths removeAllObjects];
    [self setSelected:NO];
}
- (void)createfile:(NSString*)filename
{
    
    NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    directorypath=[NSString stringWithFormat:@"%@/%@",directorypath,filename];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directorypath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:directorypath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
}

- (void)presentviewnext{
    BaojingController * bo=[[BaojingController alloc]init];
    [self presentViewController:bo animated:YES completion:nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    NSMutableArray * chanels=[NSMutableArray arrayWithCapacity:1];
    NSMutableArray * urlinfos=[[Getrules shareRules]takeurlinfo];
    for (int i=0; i<urlinfos.count; i++) {
        urlinfo * rts=[[urlinfo alloc]init];
        [chanels addObject:[NSNumber numberWithInt:rts.index]];
       
    }

    NSLog(@"chanels=%@",chanels);
    Big = 0;
    [self.view addSubview:self.bfView1];
    [self.view addSubview:self.bfView2];
    [self.view addSubview:self.bfView3];
    [self.view addSubview:self.bfView4];
    [self.view addSubview:self.rootc.rootView];
    _isClick=YES;
    _secClick=NO;
    self.view.userInteractionEnabled=YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    [self.navigationController setNavigationBarHidden:YES];
 //   self.mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"实时预览" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopPath.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
      self.idx=[NSMutableArray arrayWithCapacity:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablebtn) name:@"ismovie" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getpaths:) name:@"pathurl" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getchname:) name:@"postname" object:nil];
    faCode=[NSMutableArray arrayWithCapacity:1];
    _isSingle=NO;
    _isDouble=NO;
    _lab=[[UILabel alloc]initWithFrame:CGRectMake(14, 8, 120, 30)];
    _lab.textAlignment=NSTextAlignmentLeft;
    _lab.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    imG=[NSMutableArray arrayWithCapacity:1];
    displayImgs=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<4; i++) {
        UIImageView * ivg=[[UIImageView alloc]initWithFrame:CGRectMake(10+35*i, 40, 30, 30)];
        [displayImgs addObject:ivg];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawRectangle:) name:@"kx" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doubleclk:) name:@"doubleclick" object:nil];
    _selectedTitle = [[NSMutableArray alloc]init];
    
    if(IS_IPHONE_5_SCREEN)
    {
        self.optionview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70+y, SCREEN_WIDTH, 50)];
    }
    else
    {
        self.optionview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60+y, SCREEN_WIDTH, 40)];
    }
    self.optionview.backgroundColor = [UIColor colorWithRed:0.15f green:0.16f blue:0.18f alpha:1.00f];
//    self.optionview.contentSize = CGSizeMake(64*6, 40);
    self.optionview.contentSize = CGSizeMake(64*5, 40);
    self.optionview.showsVerticalScrollIndicator = NO;
    self.optionview.pagingEnabled = NO;
    [self.view addSubview:self.optionview];
    int info=[[Getrules shareRules] takeurlinfocount];
    [self addMovieFour:info];
    NSMutableArray *opImage = [[NSMutableArray alloc]initWithObjects:@"JKAbottomPZ.png",@"JKAbottomZT.png",@"JKAbottomYT.png",@"JKAbottomZN.png",@"JKAbottomQX.png", nil];
    NSMutableArray *opImageSelected = [[NSMutableArray alloc]initWithObjects:@"JKAbottomPZ.png",@"JKAbottomBF.png",@"JKAbottomYTon.png",@"JKAbottomZNon.png",@"JKAbottomQXon.png", nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pointstr:) name:@"mongline" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Recpoint:) name:@"orthogon" object:nil];
    
    for (int i=0; i<[opImage count]; i++)
    {
        UIButton *opBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5_SCREEN) {
            opBtn.frame = CGRectMake(12+i*64, 5, 40, 40);
        }
        else
        {
            opBtn.frame = CGRectMake(12+i*64, 0, 40, 40);
        }
        
        opBtn.backgroundColor = [UIColor clearColor];
        [opBtn setImage:[UIImage imageNamed:[opImage objectAtIndex:i]] forState:UIControlStateNormal];
        [opBtn setImage:[UIImage imageNamed:[opImageSelected objectAtIndex:i]] forState:UIControlStateSelected];
        if (i == 1) {
            opBtn.tag = 15+i;
        }
        else{
            opBtn.tag = 11+i;
        }
        [opBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.optionview addSubview:opBtn];
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickTouch) name:@"isdouble" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getindexs:) name:@"indexarr" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bigVideo:) name:@"frame" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeact) name:@"beginplay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removealert) name:@"failplay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addIview) name:@"ialert" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlinecolor) name:@"online" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveoffline) name:@"logfail" object:nil];
}
- (MyNavigationBar*)mnb{
    if (!_mnb) {
        _mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60)];
    }
    return _mnb;

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
- (void)receiveoffline{

  self.iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];
    [video1 deleteself];
    [video2 deleteself];
    [video3 deleteself];
    [video4 deleteself];
    [video1.view removeFromSuperview];
    [video2.view removeFromSuperview];
    [video3.view removeFromSuperview];
    [video4.view removeFromSuperview];
    video1.view=nil;
    video2.view=nil;
    video3.view=nil;
    video4.view=nil;
    [[Getrules shareRules] deleteoriginfo];
    [[Getrules shareRules] deleteurlinfo];
    [channels removeAllObjects];
    [movieurl removeAllObjects];


}
- (void)onlinecolor{

  self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];

}
- (void)alertcolor
{
    
    
    self.iview.image=[UIImage imageNamed:@"警报球2-2.png"];
    [self performSelector:@selector(changeimage) withObject:self afterDelay:0.2];
    
}
- (void)changeimage{
    
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
    
}
- (void)enablebtn{
    UIButton * btn11=(UIButton*)[self.optionview viewWithTag:11];
    UIButton * btn12=(UIButton*)[self.optionview viewWithTag:12];
    UIButton * btn13=(UIButton*)[self.optionview viewWithTag:13];
    UIButton * btn15=(UIButton*)[self.optionview viewWithTag:15];
    UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
    UIButton * btn16=(UIButton*)[self.optionview viewWithTag:16];
    btn11.enabled=YES;
    btn12.enabled=YES;
    btn13.enabled=YES;
    btn14.enabled=YES;
    btn15.enabled=YES;
    btn16.enabled=YES;



}
- (void)removealert{

    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];
    

}
- (void)removeact{

    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];


}
- (UIActivityIndicatorView*)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        
        _activityIndicatorView.center=self.view.center;
        _activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _activityIndicatorView.alpha=0.2;
    }
    return _activityIndicatorView;
    
}
- (UIView *)maskview{
    if (!_maskview) {
        _maskview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _maskview.backgroundColor=[UIColor blackColor];
        _maskview.alpha=0.1;
    }
    return _maskview;
}
- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
    UIView * view=[[UIApplication sharedApplication]keyWindow];
    CGPoint point = [paramSender translationInView:view];
    
    paramSender.view.center = CGPointMake(paramSender.view.center.x + point.x, paramSender.view.center.y + point.y);
    [paramSender setTranslation:CGPointMake(0, 0) inView:view];
    
    
}
- (void)baojing{

    BaojingController * baojin=[[BaojingController alloc]init];
    
    [self presentViewController:baojin animated:YES completion:^{
        
    }];
    
}
- (void)getindexs:(NSNotification*)info
{
    
   
    [saveIndex shareindex].indexsarray=[[info userInfo]valueForKey:@"idx"];
    NSLog(@"self.idx=%@",[saveIndex shareindex].indexsarray);
    
}
- (void)getpaths:(NSNotification*)info
{
    NSLog(@"我接收到消息了");

    int urlmut=[[Getrules shareRules]takeurlinfocount];
    NSLog(@"urlmut=%d",urlmut);
    if (isinterest==1&&urlmut!=0) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.maskview];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.activityIndicatorView];
        [self.activityIndicatorView startAnimating];
       
       
        [self playvideo];
    }
  
     [self performSelector:@selector(removeact) withObject:self afterDelay:5];
    
   
   
    
    
}
- (void)playvideo
{
  total=[[Getrules shareRules] takeurlinfocount];
   
 [self addMovieFour:total];
 
}
- (void)getchname:(NSNotification*)info
{
    _chnames=[[info userInfo]valueForKey:@"chname"];
    

}
- (DoublePaint*)paint5{
    if (!_paint5) {
        
        _paint5 = [[DoublePaint alloc]initWithFrame:CGRectMake(0, 0, 320,300)];
        CGRect irect=CGRectMake(0,0,320,300);
        _paint5.backgroundColor = [UIColor clearColor];
        _paint5.tag=70;
        int channel;
        if (channels.count>=1) {
            channel=[[channels objectAtIndex:0] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
                NSLog(@"points=%@",points);
                // NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
                //                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                NSLog(@"ppts=%@",ppts);
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];
            }
            
            _paint5.shapes=shapesarr;
            _paint5.begin=1;
            _paint5.iframe=irect;
            _paint5.isenable=enablearr;
        }
        
        
    }
    
    return _paint5;



}
- (DoublePaint*)paint6{

    if (!_paint6) {
        
        _paint6 = [[DoublePaint alloc]initWithFrame:CGRectMake(320, 0, 320,300)];
        CGRect irect=CGRectMake(320,0,320,300);
        _paint6.backgroundColor = [UIColor clearColor];
        _paint6.tag=71;
        int channel;
        if (channels.count>=1) {
            channel=[[channels objectAtIndex:1] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
                NSLog(@"points=%@",points);
                // NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
                //                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                NSLog(@"ppts=%@",ppts);
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];

            }
            
            _paint6.shapes=shapesarr;
            _paint6.begin=1;
            _paint6.iframe=irect;
            _paint6.isenable=enablearr;
        }
        
        
    }
    
    return _paint6;




}
- (DoublePaint*)paint7{

    if (!_paint7) {
        
        _paint7 = [[DoublePaint alloc]initWithFrame:CGRectMake(640, 0, 320,300)];
        CGRect irect=CGRectMake(640,0,320,300);
        _paint7.backgroundColor = [UIColor clearColor];
        _paint7.tag=72;
        int channel;
        if (channels.count>=1) {
            channel=[[channels objectAtIndex:2] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
                NSLog(@"points=%@",points);
                // NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
                //                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                NSLog(@"ppts=%@",ppts);
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];

            }
            
            _paint7.shapes=shapesarr;
            _paint7.begin=1;
            _paint7.iframe=irect;
            _paint7.isenable=enablearr;
        }
        
        
    }
    
    return _paint7;



}
- (DoublePaint*)paint8{

    if (!_paint8) {
        
        _paint8 = [[DoublePaint alloc]initWithFrame:CGRectMake(960, 0, 320,300)];
        CGRect irect=CGRectMake(960,0,320,300);
        _paint8.backgroundColor = [UIColor clearColor];
        _paint8.tag=73;
        int channel;
        if (channels.count>=1) {
            channel=[[channels objectAtIndex:3] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
                NSLog(@"points=%@",points);
                // NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
                //                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                NSLog(@"ppts=%@",ppts);
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];

            }
            
            _paint8.shapes=shapesarr;
            _paint8.begin=1;
            _paint8.iframe=irect;
            _paint8.isenable=enablearr;
        }
        
        
    }
    
    return _paint8;

}
- (PaintDraw*)paint1
{
    if (!_paint1) {
        
            _paint1 = [[PaintDraw alloc]initWithFrame:CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, self.bfView1.bounds.size.width-3, self.bfView1.bounds.size.height-17)];
        CGRect irect=CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, self.bfView1.bounds.size.width-3, self.bfView1.bounds.size.height-17);
        _paint1.backgroundColor = [UIColor clearColor];
        _paint1.tag=80;
        int channel;
        if (channels.count>=1) {
            channel=[[channels objectAtIndex:0] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
                NSLog(@"points=%@",points);
               // NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
//                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                NSLog(@"ppts=%@",ppts);
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];
            }
            
            _paint1.shapes=shapesarr;
            _paint1.begin=1;
            _paint1.iframe=irect;
            _paint1.isenable=enablearr;
            
        }
        
         
    }
    
    return _paint1;
    
}

- (PaintDraw*)paint2
{
    if (!_paint2) {
      
            _paint2=[[PaintDraw alloc]initWithFrame:CGRectMake(self.bfView2.bounds.origin.x+1, self.bfView2.bounds.origin.y+1, self.bfView2.bounds.size.width-3, self.bfView2.bounds.size.height-17)];
        CGRect irect=CGRectMake(self.bfView2.bounds.origin.x+1, self.bfView2.bounds.origin.y+1, self.bfView2.bounds.size.width-3, self.bfView2.bounds.size.height-17);
        _paint2.backgroundColor=[UIColor clearColor];
        _paint2.tag=81;
        int channel;
        if (channels.count>=2) {
            channel=[[channels objectAtIndex:1] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
//                NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
//                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];
            }
            
            _paint2.shapes=shapesarr;
            _paint2.begin=1;
            _paint2.iframe=irect;
            _paint2.isenable=enablearr;
            NSValue * rectvalue=[NSValue valueWithCGRect:irect];
            NSLog(@"rectvalue=%@",rectvalue);
        }
       
    }
    
    return _paint2;
}
- (PaintDraw*)paint3
{
    if (!_paint3) {
     
            _paint3=[[PaintDraw alloc]initWithFrame:CGRectMake(self.bfView3.bounds.origin.x+1, self.bfView3.bounds.origin.y+1, self.bfView3.bounds.size.width-3, self.bfView3.bounds.size.height-17)];
        CGRect irect=CGRectMake(self.bfView3.bounds.origin.x+1, self.bfView3.bounds.origin.y+1, self.bfView3.bounds.size.width-3, self.bfView3.bounds.size.height-17);
        _paint3.backgroundColor=[UIColor clearColor];
        _paint3.tag=82;
        int channel;
        if (channels.count>=3) {
            channel=[[channels objectAtIndex:2] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enablearr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
//                NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
//                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                }
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enablearr addObject:[NSNumber numberWithInt:rule.isused]];
            }
            
            _paint3.shapes=shapesarr;
            _paint3.begin=1;
            _paint3.iframe=irect;
            _paint3.isenable=enablearr;
        }
        
    }
    return _paint3;
    
}
- (PaintDraw*)paint4
{
    if (!_paint4) {
        
       _paint4=[[PaintDraw alloc]initWithFrame:CGRectMake(self.bfView4.bounds.origin.x+1, self.bfView4.bounds.origin.y+1, self.bfView4.bounds.size.width-3, self.bfView4.bounds.size.height-17)];
        CGRect irect=CGRectMake(self.bfView4.bounds.origin.x+1, self.bfView4.bounds.origin.y+1, self.bfView4.bounds.size.width-3, self.bfView4.bounds.size.height-17);
        _paint4.backgroundColor=[UIColor clearColor];
        _paint4.tag=83;
        int channel;
        if (channels.count>=4) {
            channel=[[channels objectAtIndex:3] intValue]-1;
            NSMutableArray * rules=[[Getrules shareRules]getRules:channel];
            NSMutableArray * shapesarr=[NSMutableArray arrayWithCapacity:1];
            NSMutableArray * enabelarr=[NSMutableArray arrayWithCapacity:1];
            for (int i=0; i<rules.count; i++) {
                Rules * rule=[rules objectAtIndex:i];
                NSArray * points=[rule.points componentsSeparatedByString:@","];
//                NSMutableArray * pt=[[NSMutableArray alloc]initWithArray:points];
//                [pt removeLastObject];
                NSMutableArray * ppts=[NSMutableArray arrayWithCapacity:1];
                for (int j=0; j<points.count/2;j++) {
                    CGPoint point=CGPointMake([[points objectAtIndex:j*2] floatValue], [[points objectAtIndex:j*2+1]floatValue]);
                    NSValue * pv=[NSValue valueWithCGPoint:point];
                    [ppts addObject:pv];
                    
                }
                Shape * s=[[Shape alloc]initWithName:rule.rulename points:ppts];
                [shapesarr addObject:s];
                [enabelarr addObject:[NSNumber numberWithInt:rule.isused]];
            }
            
            _paint4.shapes=shapesarr;
            _paint4.begin=1;
            _paint4.iframe=irect;
            _paint4.isenable=enabelarr;
        }
       
    }
    
    return _paint4;
    
}

- (void)addpaint{
    NSMutableArray * tongdaos=[[Getrules shareRules] getroutharray];
    for (int i=0; i<tongdaos.count; i++) {
      
       
        
        
    }


}
- (void)addMovieFour:(int)count
{
    istunel=0;
    NSMutableArray * info=[[Getrules shareRules] takeurlinfo];
     channels=[NSMutableArray arrayWithCapacity:1];
    [movieurl removeAllObjects];
    for (int i=0; i<info.count; i++) {
        urlinfo * ulf=[info objectAtIndex:i];
        [movieurl addObject:ulf.path];
        NSNumber *chanl=[NSNumber numberWithInt:ulf.index+1];
        [channels addObject:chanl];
    }
    if (channels.count==1) {
        self.lt1.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:0]];
    }
    if (channels.count==2) {
         self.lt1.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:0]];
         self.lt2.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:1]];
    }
    if (channels.count==3) {
        self.lt1.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:0]];
        self.lt2.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:1]];
        self.lt3.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:2]];
        
   
    }
    if (channels.count==4) {
        self.lt1.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:0]];
        self.lt2.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:1]];
        self.lt3.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:2]];
        self.lt4.text=[NSString stringWithFormat:@"第%@路视频播放中",[channels objectAtIndex:3]];
    }
    NSLog(@"movieurl=%@",movieurl);
    if (count==4) {
        video1=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:0] parameters:nil];
        video1.delegate = self;
        video1.view.frame = CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, 156, 139);
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        video1.view.tag = 1;
        video2=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:1] parameters:nil];
        video2.delegate = self;
        video2.view.frame = CGRectMake(self.bfView2.bounds.origin.x+1, self.bfView2.bounds.origin.y+1, 156, 139);
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        video2.view.tag = 2;
        video3=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:2] parameters:nil];
        video3.delegate = self;
        video3.view.frame = CGRectMake(self.bfView3.bounds.origin.x+1, self.bfView3.bounds.origin.y+1, 156, 139);
        video3.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video3.view.center=CGPointMake(80, 76.5);
        video3.view.tag = 3;
        video4=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:3] parameters:nil];
        video4.delegate = self;
        video4.view.frame = CGRectMake(self.bfView4.bounds.origin.x+1, self.bfView4.bounds.origin.y+1, 156, 139);
        video4.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video4.view.center=CGPointMake(80, 76.5);
        video4.view.tag = 4;
        [self.bfView1 addSubview:video1.view];
        [self.bfView2 addSubview:video2.view];
        [self.bfView3 addSubview:video3.view];
        [self.bfView4 addSubview:video4.view];
        [self.paint1 removeFromSuperview];
        [self.paint2 removeFromSuperview];
        [self.paint3 removeFromSuperview];
        [self.paint4 removeFromSuperview];
        self.paint1=nil;
        self.paint2=nil;
        self.paint3=nil;
        self.paint4=nil;
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
        [self.bfView4 addSubview:self.paint4];
        [video1.view addSubview:self.lt1];
        [video2.view addSubview:self.lt2];
        [video3.view addSubview:self.lt3];
        [video4.view addSubview:self.lt4];
        video1.selected=YES;
        video2.selected=NO;
        video3.selected=NO;
        video4.selected=NO;
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
    }
    if (count==1) {
        video1=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:0] parameters:nil];
        video1.delegate = self;
        video1.view.frame = CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, 156, 139);
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        video1.view.tag = 1;
        [self.bfView1 addSubview:video1.view];
        [video1.view addSubview:self.lt1];
        NSValue * value=[NSValue valueWithCGPoint:video1.view.center];
        NSLog(@"视频中心点=%@",value);
       video1.selected=YES;
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
        [self.paint1 removeFromSuperview];
        self.paint1=nil;
        [self.bfView1 addSubview:self.paint1];
        [self.bfView1 bringSubviewToFront:self.paint1];
    }
    if (count==2) {
        video1=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:0] parameters:nil];
        video1.delegate = self;
        video1.view.frame = CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, 156, 139);
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        video1.view.tag = 1;
        video2=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:1]  parameters:nil];
        video2.delegate = self;
        video2.view.frame = CGRectMake(self.bfView2.bounds.origin.x+1, self.bfView2.bounds.origin.y+1, 156, 139);
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        video2.view.tag = 2;
        [self.bfView1 addSubview:video1.view];
        [self.bfView2 addSubview:video2.view];
        [video1.view addSubview:self.lt1];
        [video2.view addSubview:self.lt2];
        video1.selected=YES;
        video2.selected=NO;
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.paint1 removeFromSuperview];
        [self.paint2 removeFromSuperview];
        self.paint1=nil;
        self.paint2=nil;
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
    }
    if (count==3) {
        video1=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:0] parameters:nil];
        video1.delegate = self;
        video1.view.frame = CGRectMake(self.bfView1.bounds.origin.x+1, self.bfView1.bounds.origin.y+1, 156, 139);
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        video1.view.tag = 1;
        video2=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:1] parameters:nil];
        video2.delegate = self;
        video2.view.frame = CGRectMake(self.bfView2.bounds.origin.x+1, self.bfView2.bounds.origin.y+1, 156, 139);
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        video2.view.tag = 2;
        video3=[KxMovieViewController movieViewControllerWithContentPath:[movieurl objectAtIndex:2] parameters:nil];
        video3.delegate = self;
        video3.view.frame = CGRectMake(self.bfView3.bounds.origin.x+1, self.bfView3.bounds.origin.y+1, 156, 139);
        video3.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video3.view.center=CGPointMake(80, 76.5);
        video3.view.tag = 3;
        
        [self.bfView1 addSubview:video1.view];
        [self.bfView2 addSubview:video2.view];
        [self.bfView3 addSubview:video3.view];
        
        [video1.view addSubview:self.lt1];
        [video2.view addSubview:self.lt2];
        [video3.view addSubview:self.lt3];
        
        video1.selected=YES;
        video2.selected=NO;
        video3.selected=NO;
        video4.selected=NO;
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.paint1 removeFromSuperview];
        [self.paint2 removeFromSuperview];
        [self.paint3 removeFromSuperview];
   
        self.paint1=nil;
        self.paint2=nil;
        self.paint3=nil;
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
        
    }
    
    
}
- (UILabel*)litteltitle
{
    
    if (!_litteltitle) {
        if (IS_IPHONE_5_SCREEN) {
            _litteltitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
        }
        else{
            _litteltitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
        }
        
    }
    return _litteltitle;

}
- (UILabel*)lt1
{
    if (!_lt1) {
        _lt1 = [[UILabel alloc]initWithFrame:CGRectMake(self.bfView1.bounds.origin.x, self.bfView1.bounds.origin.y+128.5, 156, 13)];
       
        _lt1.backgroundColor = [UIColor  colorWithRed:68.0f/255.0f green:127.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
        //NSString * lbtx=[_chnames objectAtIndex:0];
       _lt1.text = [NSString stringWithFormat:@"第一路视频播放中"];
       _lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        _lt1.textColor = [UIColor whiteColor];
     _lt1.contentMode=UIViewContentModeScaleAspectFill;
      _lt1.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return _lt1;
}
- (UILabel*)lt2
{
    if (!_lt2) {
        _lt2 = [[UILabel alloc]initWithFrame:CGRectMake(self.bfView2.bounds.origin.x, self.bfView2.bounds.origin.y+128.5, 156, 13)];
        
        _lt2.backgroundColor = [UIColor  colorWithRed:68.0f/255.0f green:127.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
       // NSString * lbtx=[_chnames objectAtIndex:1];
     _lt2.text = [NSString stringWithFormat:@"第二路视频播放中"];
       _lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        _lt2.textColor = [UIColor whiteColor];
        _lt2.contentMode=UIViewContentModeScaleAspectFill;
        _lt2.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return _lt2;
}
- (UILabel*)lt3
{
    if (!_lt3) {
        _lt3 = [[UILabel alloc]initWithFrame:CGRectMake(self.bfView3.bounds.origin.x, self.bfView3.bounds.origin.y+128.5, 156, 13)];
        
        _lt3.backgroundColor = [UIColor  colorWithRed:68.0f/255.0f green:127.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
        //NSString * lbtx=[_chnames objectAtIndex:2];
        _lt3.text = [NSString stringWithFormat:@"第三路视频播放中"];
      _lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        _lt3.textColor = [UIColor whiteColor];
        _lt3.contentMode=UIViewContentModeScaleAspectFill;
        _lt3.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return _lt3;
}
- (UILabel*)lt4
{
    if (!_lt4) {
        _lt4 = [[UILabel alloc]initWithFrame:CGRectMake(self.bfView4.bounds.origin.x, self.bfView4.bounds.origin.y+128.5, 156, 13)];
        
        _lt4.backgroundColor = [UIColor  colorWithRed:68.0f/255.0f green:127.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
        //NSString * lbtx=[_chnames objectAtIndex:3];
        _lt4.text = [NSString stringWithFormat:@"第四路视频播放中"];
        _lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        _lt4.textColor = [UIColor whiteColor];
        _lt4.contentMode=UIViewContentModeScaleAspectFill;
        _lt4.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return _lt4;
}
- (UIImageView*)focal1
{
    if (!_focal1) {
        if (IS_IPHONE_5_SCREEN) {
            _focal1=[[UIImageView alloc]initWithFrame:CGRectMake(70, 5, 40, 40)];
        }
        else{
            _focal1=[[UIImageView alloc]initWithFrame:CGRectMake(70, -5, 40, 40)];
        }
        
    }
    return _focal1;
}
- (UIImageView*)focal2
{
    
    if (!_focal2) {
        if (IS_IPHONE_5_SCREEN) {
            _focal2=[[UIImageView alloc]initWithFrame:CGRectMake(260, 5, 40, 40)];
        }
        else{
            _focal2=[[UIImageView alloc]initWithFrame:CGRectMake(260, -5, 40, 40)];
        }
    }
    
    return _focal2;
}
- (UISlider*)slider
{
    if (!_slider) {
        if (IS_IPHONE_5_SCREEN) {
            _slider=[[UISlider alloc]initWithFrame:CGRectMake(120, 20, 140, 10)];
        }
        else{
            _slider=[[UISlider alloc]initWithFrame:CGRectMake(120, 10, 140, 10)];
        }
        
    }
    return _slider;
}
- (MyView*)bfView1
{
    if (!_bfView1) {
        if (IS_IPHONE_5_SCREEN) {
            _bfView1 = [[MyView alloc]initWithFrame:CGRectMake(0, 82+y, 159, 156)];
        }
        else
        {
            _bfView1 = [[MyView alloc]initWithFrame:CGRectMake(0, 42+y, 159, 156)];
        }
        _bfView1.backgroundColor = [UIColor blackColor];
        _bfView1.tag=1000;
    }
    
    return _bfView1;

}
- (MyView*)bfView2
{
    if (!_bfView2) {
        if (IS_IPHONE_5_SCREEN) {
            _bfView2=[[MyView alloc]initWithFrame:CGRectMake(161, 82+y, 159, 156)];
        }
        else
        {
            _bfView2=[[MyView alloc]initWithFrame:CGRectMake(161, 42+y, 159, 156)];
        }
        _bfView2.backgroundColor=[UIColor blackColor];
        _bfView2.tag=2000;
    }
    
    return _bfView2;
}
- (MyView*)bfView3
{
    if (!_bfView3) {
        if (IS_IPHONE_5_SCREEN) {
            _bfView3=[[MyView alloc]initWithFrame:CGRectMake(0, 241+y, 159, 156)];
        }
        else
        {
            _bfView3=[[MyView alloc]initWithFrame:CGRectMake(0, 201+y, 159, 156)];
        }
        _bfView3.backgroundColor=[UIColor blackColor];
        _bfView3.tag=3000;
    }
    return _bfView3;

}
- (MyView*)bfView4
{
    if (!_bfView4) {
        if (IS_IPHONE_5_SCREEN) {
            _bfView4=[[MyView alloc]initWithFrame:CGRectMake(161, 241+y, 159, 156)];
        }
        else
        {
            _bfView4=[[MyView alloc]initWithFrame:CGRectMake(161, 201+y, 159, 156)];
        }
        _bfView4.backgroundColor=[UIColor blackColor];
        _bfView4.tag=4000;
    }
    
    return _bfView4;

}
- (void)remove:(NSNotification*)info
{
    BOOL isOk=[[[info userInfo]valueForKey:@"isc"] boolValue];
    if (isOk==YES) {
        [self setSelected:NO];
        [self.rootc.rootView removeFromSuperview];
        self.isClick = YES;
    }
    

}



- (void)drawRectangle:(NSNotification*)userinfo
{
    NSUserDefaults * userdef=[NSUserDefaults standardUserDefaults];
    
    int tag=[[[userinfo userInfo] valueForKey:@"tag"] intValue];
    NSLog(@"点击%d",tag);
    if (tag==1000) {
        [userdef setObject:@"一" forKey:@"av"];
        [userdef synchronize];
        video1.selected=YES;
        video2.selected=NO;
        video3.selected=NO;
        video4.selected=NO;
        [self.bfView1 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
    }
    if (tag==2000) {
        [userdef setObject:@"二" forKey:@"av"];
        [userdef synchronize];
        video1.selected=NO;
        video2.selected=YES;
        video3.selected=NO;
        video4.selected=NO;
        [self.bfView2 takestate];
        [self.bfView1 takeoff];
        [self.bfView3 takeoff];
        [self.bfView4 takeoff];
    }
    if (tag==3000) {
        [userdef setObject:@"三" forKey:@"av"];
        [userdef synchronize];
        video1.selected=NO;
        video2.selected=NO;
        video3.selected=YES;
        video4.selected=NO;
        [self.bfView3 takestate];
        [self.bfView2 takeoff];
        [self.bfView1 takeoff];
        [self.bfView4 takeoff];
    }
    if (tag==4000) {
        [userdef setObject:@"四" forKey:@"av"];
        [userdef synchronize];
        video1.selected=NO;
        video2.selected=NO;
        video3.selected=NO;
        video4.selected=YES;
        [self.bfView4 takestate];
        [self.bfView2 takeoff];
        [self.bfView3 takeoff];
        [self.bfView1 takeoff];
    }

}

- (UIView*)consoleView{
    if (!_consoleView) {
    UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
    btn14.selected=NO;
    UIButton * btn15=(UIButton*)[self.optionview viewWithTag:15];
    btn15.selected=NO;
        if(IS_IPHONE_5_SCREEN)
        {
            _consoleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-120+y, SCREEN_WIDTH, 50)];
        }
        else
        {
            _consoleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-110+y, SCREEN_WIDTH, 40)];
        }
    _consoleView.backgroundColor = [UIColor colorWithRed:0.25f green:0.27f blue:0.30f alpha:1.00f];
    
    NSMutableArray *naImage = [[NSMutableArray alloc]initWithObjects:@"JKAbottom2A.png",@"JKAbottom2B.png",@"JKAbottom2C.png",@"JKAbottom2D.png",@"JKAbottom2E.png", nil];
   // NSMutableArray *naImageSelecd = [[NSMutableArray alloc]initWithObjects:@"JKAbottom2Aon.png",@"JKAbottom2Bon.png",@"JKAbottom2Con.png",@"JKAbottom2Don.png",@"JKAbottom2Eon.png", nil];
    
    for (int i=0; i<5; i++)
    {
        ImageBtn *naBtn = [[ImageBtn alloc]initWithTarget:self action:@selector(btnClick2:)];
        naBtn.userInteractionEnabled = YES;
        if (IS_IPHONE_5_SCREEN) {
            naBtn.frame = CGRectMake(i*64, 0, 64, 50);
        }
        else
        {
            naBtn.frame = CGRectMake(i*64, 0, 64, 40);
        }
        naBtn.backgroundColor = [UIColor clearColor];
        naBtn.isSelect=NO;
        naBtn.imgv.image=[UIImage imageNamed:[naImage objectAtIndex:i]];
        
      
//        [naBtn setImage:[UIImage imageNamed:[naImage objectAtIndex:i]] forState:UIControlStateNormal];
//        [naBtn setImage:[UIImage imageNamed:[naImageSelecd objectAtIndex:i]] forState:UIControlStateSelected];
//        [naBtn setBackgroundImage:[UIImage imageNamed:@"JKAbottom2Bg.png"] forState:UIControlStateSelected];
        naBtn.tag = 21+i;
       // [naBtn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [_consoleView addSubview:naBtn];
    }
    }
    return _consoleView;
}
#pragma mark - Delegate 放大缩小
- (UIScrollView*)scroll
{
    if (!_scroll) {
        if (IS_IPHONE_5_SCREEN) {
            _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, 320, 320)];
             _scroll.contentSize=CGSizeMake(640, 320);
        }
        else{
            _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, 320, 317)];
             _scroll.contentSize=CGSizeMake(640, 297);
        }
        
       
        _scroll.scrollEnabled=YES;
        _scroll.pagingEnabled=YES;
    }
    return _scroll;
}
- (void)doubleclk:(NSNotification*)info{
    
    int itag=[[[info userInfo] valueForKey:@"tag"] intValue];
    NSLog(@"total=%d",total);
    NSMutableArray * urls=[[Getrules shareRules] takeurlinfo];
    total=(int)urls.count;
    _isSingle=NO;
   
    if (_isSingle==NO) {
        itag=itag/1000;
        _tag=itag;
        NSLog(@"itag=%d",itag);
        if (_selectbig==NO) {
            _selectbig=YES;
        }else{
        
            _selectbig=NO;
        }
        if (total==1) {
           
            self.page.numberOfPages=1;
            [self.view addSubview:self.page];
            [self.paint1 removeFromSuperview];
            [self.paint2 removeFromSuperview];
            [self.paint3 removeFromSuperview];
            [self.paint4 removeFromSuperview];
            self.paint1=nil;
            self.paint2=nil;
            self.paint3=nil;
            self.paint4=nil;
        }else if(total==2){
        
            self.page.numberOfPages=2;
            [self.view addSubview:self.page];
            [self.paint1 removeFromSuperview];
            [self.paint2 removeFromSuperview];
            [self.paint3 removeFromSuperview];
            [self.paint4 removeFromSuperview];
            self.paint1=nil;
            self.paint2=nil;
            self.paint3=nil;
            self.paint4=nil;
        
        }else if(total==3){
            self.page.numberOfPages=3;
            [self.view addSubview:self.page];
            [self.paint1 removeFromSuperview];
            [self.paint2 removeFromSuperview];
            [self.paint3 removeFromSuperview];
            [self.paint4 removeFromSuperview];
            self.paint1=nil;
            self.paint2=nil;
            self.paint3=nil;
            self.paint4=nil;
        
        }else if(total==4){
        
            self.page.numberOfPages=4;
            [self.view addSubview:self.page];
            [self.paint1 removeFromSuperview];
            [self.paint2 removeFromSuperview];
            [self.paint3 removeFromSuperview];
            [self.paint4 removeFromSuperview];
            self.paint1=nil;
            self.paint2=nil;
            self.paint3=nil;
            self.paint4=nil;
        }
       
        if (_selectbig==YES) {
            Big = 1;
            _isDouble=YES;
            
            if (total==1) {
                _isScale=1;
              
                self.scroll.delegate=self;
                self.scroll.backgroundColor=[UIColor blackColor];
                [self.view addSubview:self.scroll];
                [self.view bringSubviewToFront:self.scroll];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView1.frame=CGRectMake(0, 0, 320, 300);
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt1.frame=CGRectMake(0, 295, 320, 25);
                    
                }
                else{
                    
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.bfView1.frame=CGRectMake(0,0, 320, 297);
                    self.lt1.frame=CGRectMake(0, 293, 320, 25);
                    
                }
                NSLog(@"放大后中心点=%@",[NSValue valueWithCGPoint:video1.view.center]);
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                [self.scroll addSubview:self.paint5];
                [self.view bringSubviewToFront:self.lt1];
                [self.view bringSubviewToFront:self.page];
                [self.view bringSubviewToFront:self.paint5];
                
            }else if (total==2) {
                _isScale=1;
               
                self.scroll.delegate=self;
                self.scroll.backgroundColor=[UIColor clearColor];
                [self.view addSubview:self.scroll];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView1.frame=CGRectMake(0, 0, 320, 300);
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt1.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.bfView1.frame=CGRectMake(0,0, 320, 297);
                    self.lt1.frame=CGRectMake(0, 293, 320, 25);
                }
                
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                [self.scroll addSubview:self.paint5];
                [self.view bringSubviewToFront:self.paint5];
                if (itag==1) {
                    self.scroll.contentOffset=CGPointMake(0, 0);
                }
                if (itag==2) {
                    self.scroll.contentOffset=CGPointMake(320, 0);
                }
                
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView2.frame=CGRectMake(320, 0, 320, 300);
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                  
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                }
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                [self.scroll addSubview:self.paint6];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                [self.view bringSubviewToFront:self.paint6];
                
            }else if (total==3) {
                _isScale=1;
              
                self.scroll.delegate=self;
                self.scroll.backgroundColor=[UIColor clearColor];
                [self.view addSubview:self.scroll];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView1.frame=CGRectMake(0, 0, 320, 300);
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt1.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.bfView1.frame=CGRectMake(0,0, 320, 297);
                    self.lt1.frame=CGRectMake(0, 293, 320, 25);
                }
                
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                [self.scroll addSubview:self.paint5];
                [self.view bringSubviewToFront:self.paint5];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView2.frame=CGRectMake(320, 0, 320, 300);
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                   
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                }
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                [self.scroll addSubview:self.paint6];
                [self.view bringSubviewToFront:self.paint6];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                if (itag==1) {
                    self.scroll.contentOffset=CGPointMake(0, 0);
                }
                if (itag==2) {
                    self.scroll.contentOffset=CGPointMake(320, 0);
                }
                if (itag==3) {
                    self.scroll.contentOffset=CGPointMake(640, 0);
                }
                if (IS_IPHONE_5_SCREEN) {
                    video3.view.center=CGPointMake(800, 160);
                    video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt3.frame=CGRectMake(0, 295, 320, 25);
                    self.bfView3.frame=CGRectMake(640, 0, 320, 300);
                }
                else{
                    video3.view.center=CGPointMake(800, 160);
                    video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt3.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView3.frame=CGRectMake(640, 0, 320, 297);
                }
                
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                [self.scroll addSubview:self.paint7];
                [self.view bringSubviewToFront:self.paint7];
            }else if (total==4) {
                _isScale=1;
               
                self.scroll.delegate=self;
                self.scroll.backgroundColor=[UIColor clearColor];
                [self.view addSubview:self.scroll];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView1.frame=CGRectMake(0, 0, 320, 300);
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt1.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                    video1.view.center=CGPointMake(160, 160);
                    video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.bfView1.frame=CGRectMake(0,0, 320, 297);
                    self.lt1.frame=CGRectMake(0, 293, 320, 25);
                }
                
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                [self.scroll addSubview:self.paint5];
                [self.view bringSubviewToFront:self.paint5];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                if (IS_IPHONE_5_SCREEN) {
                    self.bfView2.frame=CGRectMake(320, 0, 320, 300);
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 295, 320, 25);
                }
                else{
                    
                    video2.view.center=CGPointMake(480, 160);
                    video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt2.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                }
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                [self.scroll addSubview:self.paint6];
                [self.view bringSubviewToFront:self.paint6];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                if (IS_IPHONE_5_SCREEN) {
                    video3.view.center=CGPointMake(800, 160);
                    video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt3.frame=CGRectMake(0, 295, 320, 25);
                    self.bfView3.frame=CGRectMake(640, 0, 320, 300);
                }
                else{
                    video3.view.center=CGPointMake(800, 160);
                    video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt3.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView3.frame=CGRectMake(640, 0, 320, 297);
                }
                
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                [self.scroll addSubview:self.paint7];
                [self.view bringSubviewToFront:self.paint7];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                if (itag==1) {
                    self.scroll.contentOffset=CGPointMake(0, 0);
                }
                if (itag==2) {
                    self.scroll.contentOffset=CGPointMake(320, 0);
                }
                if (itag==3) {
                    self.scroll.contentOffset=CGPointMake(640, 0);
                }
                if (itag==4) {
                    self.scroll.contentOffset=CGPointMake(960, 0);
                }
                if (IS_IPHONE_5_SCREEN) {
                    video4.view.center=CGPointMake(1120,160);
                    video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt4.frame=CGRectMake(0, 295, 320, 25);
                    self.bfView4.frame=CGRectMake(960, 0, 320, 300);
                }
                else{
                    video4.view.center=CGPointMake(1120,160);
                    video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                    self.lt4.frame=CGRectMake(0, 293, 320, 25);
                    self.bfView4.frame=CGRectMake(960, 0, 320, 297);
                }
                
                self.lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView4 addSubview:self.lt4];
                [self.scroll addSubview:self.bfView4];
                [self.scroll addSubview:video4.view];
                [self.scroll addSubview:self.paint8];
                [self.view bringSubviewToFront:self.scroll];
                [self.view bringSubviewToFront:self.page];
                [self.view bringSubviewToFront:self.paint8];
            }
            
            
            
        }
      
    }
[self.view bringSubviewToFront:self.iview];


}
- (void)clickTouch{

    if (_selectbig==YES) {
        [self litterView];
        [_ruleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [tint removeFromSuperview];
        [self.upbtn removeFromSuperview];
        [self.downbtn removeFromSuperview];
        [self.leftbtn removeFromSuperview];
        [self.rightbtn removeFromSuperview];
        [_consoleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
    }
    
    NSMutableArray *couplay=[[Getrules shareRules] takeurlinfo];
    if (couplay.count==1) {
        [self.bfView1 addSubview:self.paint1];
    }else if (couplay.count==2) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
    }
    else if (couplay.count==3) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
    }
    else if (couplay.count==4) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
        [self.bfView4 addSubview:self.paint4];
    }



}
- (void)clickTap:(UIViewController *)viewController
{
    
    if (_selectbig==YES) {
         [self litterView];
        [_ruleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [tint removeFromSuperview];
        [self.upbtn removeFromSuperview];
        [self.downbtn removeFromSuperview];
        [self.leftbtn removeFromSuperview];
        [self.rightbtn removeFromSuperview];
        [_consoleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
        
    }
    
    NSMutableArray *couplay=[[Getrules shareRules] takeurlinfo];
    if (couplay.count==1) {
        [self.bfView1 addSubview:self.paint1];
    }else if (couplay.count==2) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
    }
    else if (couplay.count==3) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
    }
    else if (couplay.count==4) {
        [self.bfView1 addSubview:self.paint1];
        [self.bfView2 addSubview:self.paint2];
        [self.bfView3 addSubview:self.paint3];
        [self.bfView4 addSubview:self.paint4];
    }
    
}
- (void)litterView
{
    int total1=(int)[[[Getrules shareRules] takeurlinfo] count];
    _isDouble=NO;
    _isScale=0;
    Big = 0;
    if (total1==1) {
        
        if (IS_IPHONE_5_SCREEN) {
            self.bfView1.frame=CGRectMake(0, 82+y, 159, 156);
        }
        else
        {
            self.bfView1.frame=CGRectMake(0, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView1];
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        self.lt1.frame = CGRectMake(self.bfView1.bounds.origin.x, self.bfView1.bounds.origin.y+128.5, 156, 13);
        self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView1 bringSubviewToFront:self.bfView1.label];
        [self.bfView1 addSubview:video1.view];
        [video1.view addSubview:self.lt1];
        [self.bfView1 addSubview:self.paint1];
        [self.paint5 removeFromSuperview];
        self.paint5=nil;
    }else if (total1==2) {
        if (IS_IPHONE_5_SCREEN) {
            self.bfView1.frame=CGRectMake(0, 82+y, 159, 156);
        }
        else
        {
            self.bfView1.frame=CGRectMake(0, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView1];
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        self.lt1.frame = CGRectMake(self.bfView1.bounds.origin.x, self.bfView1.bounds.origin.y+128.5, 156, 13);
        self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView1 bringSubviewToFront:self.bfView1.label];
        [self.bfView1 addSubview:video1.view];
        [video1.view addSubview:self.lt1];
        [self.bfView1 addSubview:self.paint1];
        [self.paint5 removeFromSuperview];
        self.paint5=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView2.frame=CGRectMake(161, 82+y, 159, 156);
        }
        else
        {
            self.bfView2.frame=CGRectMake(161, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView2];
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        self.lt2.frame = CGRectMake(self.bfView2.bounds.origin.x, self.bfView2.bounds.origin.y+128.5, 156, 13);
        self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView2 bringSubviewToFront:self.bfView2.label];
        [self.bfView2 addSubview:video2.view];
        [video2.view addSubview:self.lt2];
        [self.bfView2 addSubview:self.paint2];
        [self.paint6 removeFromSuperview];
        self.paint6=nil;
    } else if (total1==3) {
        if (IS_IPHONE_5_SCREEN) {
            self.bfView1.frame=CGRectMake(0, 82+y, 159, 156);
        }
        else
        {
            self.bfView1.frame=CGRectMake(0, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView1];
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        self.lt1.frame = CGRectMake(self.bfView1.bounds.origin.x, self.bfView1.bounds.origin.y+128.5, 156, 13);
        self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView1 bringSubviewToFront:self.bfView1.label];
        [self.bfView1 addSubview:video1.view];
        [video1.view addSubview:self.lt1];
        [self.bfView1 addSubview:self.paint1];
        [self.paint5 removeFromSuperview];
        self.paint5=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView2.frame=CGRectMake(161, 82+y, 159, 156);
        }
        else
        {
            self.bfView2.frame=CGRectMake(161, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView2];
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        self.lt2.frame = CGRectMake(self.bfView2.bounds.origin.x, self.bfView2.bounds.origin.y+128.5, 156, 13);
        self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView2 bringSubviewToFront:self.bfView2.label];
        [self.bfView2 addSubview:video2.view];
        [video2.view addSubview:self.lt2];
        [self.bfView2 addSubview:self.paint2];
        [self.paint6 removeFromSuperview];
        self.paint6=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView3.frame=CGRectMake(0, 241+y, 159, 156);
        }
        else{
            self.bfView3.frame=CGRectMake(0, 201+y, 159, 156);
        }
        [self.view addSubview:self.bfView3];
        video3.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video3.view.center=CGPointMake(80, 76.5);
        self.lt3.frame = CGRectMake(self.bfView3.bounds.origin.x, self.bfView3.bounds.origin.y+128.5, 156, 13);
        self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView3 bringSubviewToFront:self.bfView3.label];
        [self.bfView3 addSubview:video3.view];
        [video3.view addSubview:self.lt3];
        [self.bfView3 addSubview:self.paint3];
        [self.paint7 removeFromSuperview];
        self.paint7=nil;
    } else if (total1==4) {
        if (IS_IPHONE_5_SCREEN) {
            self.bfView1.frame=CGRectMake(0, 82+y, 159, 156);
        }
        else
        {
            self.bfView1.frame=CGRectMake(0, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView1];
        video1.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video1.view.center=CGPointMake(80, 76.5);
        self.lt1.frame = CGRectMake(self.bfView1.bounds.origin.x, self.bfView1.bounds.origin.y+128.5, 156, 13);
        self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView1 bringSubviewToFront:self.bfView1.label];
        [self.bfView1 addSubview:video1.view];
        [video1.view addSubview:self.lt1];
        [self.bfView1 addSubview:self.paint1];
        [self.paint5 removeFromSuperview];
        self.paint5=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView2.frame=CGRectMake(161, 82+y, 159, 156);
        }
        else
        {
            self.bfView2.frame=CGRectMake(161, 42+y, 159, 156);
        }
        [self.view addSubview:self.bfView2];
        video2.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video2.view.center=CGPointMake(80, 76.5);
        self.lt2.frame = CGRectMake(self.bfView2.bounds.origin.x, self.bfView2.bounds.origin.y+128.5, 156, 13);
        self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView2 bringSubviewToFront:self.bfView2.label];
        [self.bfView2 addSubview:video2.view];
        [video2.view addSubview:self.lt2];
        [self.bfView2 addSubview:self.paint2];
        [self.paint6 removeFromSuperview];
        self.paint6=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView3.frame=CGRectMake(0, 241+y, 159, 156);
        }
        else{
            self.bfView3.frame=CGRectMake(0, 201+y, 159, 156);
        }
        video3.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video3.view.center=CGPointMake(80, 76.5);
        self.lt3.frame = CGRectMake(self.bfView3.bounds.origin.x, self.bfView3.bounds.origin.y+128.5, 156, 13);
        [self.view addSubview:self.bfView3];
        self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView3 bringSubviewToFront:self.bfView3.label];
        [self.bfView3 addSubview:video3.view];
        [video3.view addSubview:self.lt3];
        [self.bfView3 addSubview:self.paint3];
        [self.paint7 removeFromSuperview];
        self.paint7=nil;
        if (IS_IPHONE_5_SCREEN) {
            self.bfView4.frame=CGRectMake(161, 241+y, 159, 156);
        }
        else{
            self.bfView4.frame=CGRectMake(161, 201+y, 159, 156);
        }
        [self.view addSubview:self.bfView4];
        video4.view.transform=CGAffineTransformMakeScale(1.f, 1.08f);
        video4.view.center=CGPointMake(80, 76.5);
        self.lt4.frame = CGRectMake(self.bfView4.bounds.origin.x, self.bfView4.bounds.origin.y+128.5, 156, 13);
        [self.bfView4 addSubview:video4.view];
        self.lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
        [self.bfView4 addSubview:video4.view];
        [video4.view addSubview:self.lt4];
        [self.bfView4 addSubview:self.paint4];
        [self.paint8 removeFromSuperview];
        self.paint8=nil;
    }
    _selectbig=NO;
    
    [self.scroll removeFromSuperview];
    self.scroll=nil;
    [self.page removeFromSuperview];
    self.page=nil;
    if (total==4) {
        [video1 play];
        [video2 play];
        [video3 play];
        [video4 play];
    }
    if (total==1) {
        [video1 play];
    }
    if (total==2) {
        [video1 play];
        [video2 play];
    }
    if (total==3) {
        [video1 play];
        [video2 play];
        [video3 play];
        
    }

    [self.view bringSubviewToFront:self.iview];
}
- (void)bigVideo:(NSNotification*)info
{
    int widt=(int)[[[info userInfo]valueForKey:@"width"] integerValue];
    if ((widt<320&&_isScale==1)||(widt==320&&_isScale==1)) {

            NSNumber * width=[NSNumber numberWithInt:320];
            NSNumber * height=[NSNumber numberWithInt:300];
            NSDictionary * numdic=[NSDictionary dictionaryWithObjectsAndKeys:width,@"wth",height,@"hgt", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeframe" object:self userInfo:numdic];
     
    }else {
        NSNumber * width=[NSNumber numberWithInt:156];
        NSNumber * height=[NSNumber numberWithInt:139];
        NSDictionary * numdic=[NSDictionary dictionaryWithObjectsAndKeys:width,@"wth",height,@"hgt", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeframe" object:self userInfo:numdic];
    }

}
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
        
    }
    return _rootc;
}
- (void)takemsg:(NSNotification*)info
{

    self.isClick=[[[info userInfo] valueForKey:@"ck"] boolValue];

}
- (void)bbiClick:(UIButton *)btn
{

   
    if (btn.tag == 0)
    {
        //UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 370)];
        
        if (self.isClick == YES)
            {
                
                [self setSelected:YES];
                self.rootc.rootView.hidden=NO;
                self.isClick = NO;
                [self.mnb.superview bringSubviewToFront:self.mnb];
                
            }else
           {
           //    [self addkeywindow];
            [self setSelected:NO];
            self.isClick = YES;
            
           }
      }
    
    
    if (btn.tag == 1)
    {
        [self setSelected:NO];
        self.isClick=YES;
        YLController *yl = [[YLController alloc]init];
        
        if (_isDouble==YES) {
            [self smallScreen];
            [self.scroll removeFromSuperview];
            [self.page removeFromSuperview];
            _isDouble=NO;
        }else{
        [self smallScreen];
        }
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        //[self.navigationController pushViewController:yl animated:YES];
        [self presentViewController:yl animated:NO completion:nil];
       // [self dismissViewControllerAnimated:YES completion:nil];

    }
   
}

#pragma mark - 一级工具条
- (void)yuntVideo1
{NSLog(@"执行了视频1");
    Big = 1;
    if (IS_IPHONE_5_SCREEN) {
       
        video1.view.center = CGPointMake(160, 160);
        video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt1.frame=CGRectMake(0, 295, 320, 25);
    }
    else{
        video1.view.center = CGPointMake(160, 160);
        video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt1.frame=CGRectMake(0, 293, 320, 25);
    }
    self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [self.bfView1 addSubview:self.lt1];
}
- (void)yuntVideo2
{NSLog(@"执行了视频2");
    Big = 1;
    if (IS_IPHONE_5_SCREEN) {
        video2.view.center = CGPointMake(160, 160);
        video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt2.frame=CGRectMake(0, 295, 320, 25);
    }
    else{
        video2.view.center = CGPointMake(160, 160);
        video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt2.frame=CGRectMake(0, 293, 320, 25);
    }
    self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [self.bfView2 addSubview:self.lt2];
}
- (void)yuntVideo3
{
NSLog(@"执行了视频3");
    Big = 1;
    if (IS_IPHONE_5_SCREEN) {
        video3.view.center = CGPointMake(160, 160);
        video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt3.frame=CGRectMake(0, 295, 320, 25);
    }
    else{
        video3.view.center = CGPointMake(160, 160);
        video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt3.frame=CGRectMake(0, 293, 320, 25);
    }
    self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [self.bfView3 addSubview:self.lt3];
}
- (void)yuntVideo4
{NSLog(@"执行了视频4");
    Big = 1;
    if (IS_IPHONE_5_SCREEN) {
        video4.view.center = CGPointMake(160, 160);
        video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt4.frame=CGRectMake(0, 295, 320, 25);
    }
    else{
        video4.view.center = CGPointMake(160, 160);
        video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
        self.lt4.frame=CGRectMake(0, 293, 320, 25);
    }
    self.lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [self.bfView4 addSubview:self.lt4];
}
- (void)scaleYuntai
{
 
    Big = 1;
    if (video1.selected== YES)
    {
        _tag=1;
        _isScale=1;
        if (_isDouble==YES) {
            if(IS_IPHONE_5_SCREEN)
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }

            [self.page removeFromSuperview];
        }
        
        else {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView1.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);
            }
            [self yuntVideo1];
            [self.view bringSubviewToFront:self.bfView1];
            [self.view bringSubviewToFront:self.lt1];
//            self.video1.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video1.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video1 play];
            [video2 pause];
            [video3 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else{
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            
            [self.view bringSubviewToFront:self.bfView1];
            [self.view bringSubviewToFront:self.lt1];
   
        }
        
    } else if (video2.selected == YES)
    {
        _tag=2;
        _isScale=1;
        if (_isDouble==YES) {
            if(IS_IPHONE_5_SCREEN)
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.page removeFromSuperview];
        }
        else{
    
            if (IS_IPHONE_5_SCREEN) {
                self.bfView2.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView2.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);
            }
            
            
            [self.view bringSubviewToFront:self.bfView2];
           
            [self yuntVideo2];
            [self.view bringSubviewToFront:self.lt2];
//            self.video2.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video2.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video2 play];
            [video1 pause];
            [video3 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.bfView2 addSubview:video2.view];
            [self.view bringSubviewToFront:self.bfView2];
            [self.view bringSubviewToFront:self.lt2];
        }
        
    } else if (video3.selected == YES)
    {
        _tag=3;
        _isScale=1;
        if (_isDouble==YES) {
            if(IS_IPHONE_5_SCREEN)
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.page removeFromSuperview];
        }else{
            
            if (IS_IPHONE_5_SCREEN) {
                self.bfView3.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView3.frame=CGRectMake(0, 60, 320, 310);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);
            }
            
            [self yuntVideo3];
            [self.view bringSubviewToFront:self.bfView3];
            [self.view bringSubviewToFront:self.lt3];
//            
//            self.video3.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video3.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video3 play];
            [video1 pause];
            [video2 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.bfView3 addSubview:video3.view];
            [self.view bringSubviewToFront:self.bfView3];
            [self.view bringSubviewToFront:self.lt3];
        
        }
        
    } else if (video4.selected == YES)
    {
        _tag=4;
        _isScale=1;
        if (_isDouble==YES) {
            if(IS_IPHONE_5_SCREEN)
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.page removeFromSuperview];
        }else{
        
       
            if (IS_IPHONE_5_SCREEN) {
                self.bfView4.frame=CGRectMake(0, 100, 320, 320);
            }
            else
            {
                self.bfView4.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
            }
            
            [self yuntVideo4];
            [self.view bringSubviewToFront:self.bfView4];
            [self.view bringSubviewToFront:self.lt4];
            
//            self.video4.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video4.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [video4 play];
            [video1 pause];
            [video2 pause];
            [video3 pause];
            [self.bfView4 addSubview:video4.view];
            [self.view bringSubviewToFront:self.bfView4];
            [self.view bringSubviewToFront:self.lt4];
        }
       
        
    }
    
    [self.view addSubview:self.upbtn];
   
    [self.view addSubview:self.downbtn];
    
    [self.view addSubview:self.leftbtn];
    
    [self.view addSubview:self.rightbtn];
    
}
- (void)scaleScreen
{
    Big = 1;
    if (video1.selected== YES)
    {
        _tag=1;
        _isScale=1;
        if (_isDouble==YES) {
            [self.view addSubview:_ruleView];
            [self.page removeFromSuperview];
        }
        else {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView1.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);
            }
            [self yuntVideo1];
            [self.view bringSubviewToFront:self.bfView1];
            
//            self.video1.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video1.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video1 play];
            [video2 pause];
            [video3 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else{
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            
            [self.view bringSubviewToFront:self.bfView1];
            
            
        }
     
    } else if (video2.selected == YES)
    {
        _tag=2;
        _isScale=1;
        if (_isDouble==YES) {
            [self.view addSubview:_ruleView];
            [self.page removeFromSuperview];
        }
        else{
            
            if (IS_IPHONE_5_SCREEN) {
                self.bfView2.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView2.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);
            }
            
            
            [self.view bringSubviewToFront:self.bfView2];
            
            [self yuntVideo2];
//            self.video2.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video2.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video2 play];
            [video1 pause];
            [video3 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.bfView2 addSubview:video2.view];
            [self.view bringSubviewToFront:self.bfView2];
            
        }
        
    } else if (video3.selected == YES)
    {
        _tag=3;
        _isScale=1;
        if (_isDouble==YES) {
            [self.view addSubview:_ruleView];
            [self.page removeFromSuperview];
        }else{
            
            if (IS_IPHONE_5_SCREEN) {
                self.bfView3.frame=CGRectMake(0, 100, 320, 320);
            }
            else{
                self.bfView3.frame=CGRectMake(0, 60, 320, 310);
                self.bfView4.frame=CGRectMake(161, 191+y, 159, 156);

            }
            
            [self yuntVideo3];
            [self.view bringSubviewToFront:self.bfView3];
            
            
//            self.video3.glView.contentMode = UIViewContentModeScaleAspectFill;
//            self.video3.glView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
            [video3 play];
            [video1 pause];
            [video2 pause];
            [video4 pause];
            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [self.bfView3 addSubview:video3.view];
            [self.view bringSubviewToFront:self.bfView3];
            
            
        }
        
    } else if (video4.selected == YES)
    {
        _tag=4;
        _isScale=1;
        if (_isDouble==YES) {
            [self.view addSubview:_ruleView];
            [self.page removeFromSuperview];
        }else{
            
            
            if (IS_IPHONE_5_SCREEN) {
                self.bfView4.frame=CGRectMake(0, 100, 320, 320);
            }
            else
            {
                self.bfView4.frame=CGRectMake(0, 60, 320, 310);
                self.bfView3.frame=CGRectMake(0, 191+y, 159, 156);
            }
            
            [self yuntVideo4];
            [self.view bringSubviewToFront:self.bfView4];
            

            if (IS_IPHONE_5_SCREEN) {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-120+y, 320, 50);
            }
            else
            {
                self.consoleView.frame=CGRectMake(0, SCREEN_HEIGHT-100+y, 320, 40);
            }
            [video4 play];
            [video1 pause];
            [video2 pause];
            [video3 pause];
            [self.bfView4 addSubview:video4.view];
            [self.view bringSubviewToFront:self.bfView4];
            
        }
        
        
    }
    if (IS_IPHONE_5_SCREEN) {
        _draw = [[Draw alloc]initWithFrame:CGRectMake(0, 100, 320, 320)];
    }else{
        
        _draw=[[Draw alloc]initWithFrame:CGRectMake(0, 60, 320, 320)];
        
    }
    
    _draw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_draw];
    [self.view setNeedsDisplay];
    [self.view bringSubviewToFront:self.iview];
}
- (void)smallScreen
{
    _isScale=0;
    Big = 0;
    [self litterView];
    UIButton * BTN=(UIButton*)[self.optionview viewWithTag:13];
    BTN.selected=NO;
    [self.consoleView removeFromSuperview];
    [_draw removeFromSuperview];
    [self.upbtn removeFromSuperview];
    [self.downbtn removeFromSuperview];
    [self.leftbtn removeFromSuperview];
    [self.rightbtn removeFromSuperview];
    [video1 play];
    [video2 play];
    [video3 play];
    [video4 play];
    [self.view bringSubviewToFront:self.iview];
}
- (UIPageControl *)page
{
    if (!_page) {
        if (IS_IPHONE_5_SCREEN) {
            _page=[[UIPageControl alloc]initWithFrame:CGRectMake(110, 460, 100, 20)];
        }else{
        
            _page=[[UIPageControl alloc]initWithFrame:CGRectMake(110, 400, 100, 20)];
        
        }
        
        
    }
    return _page;
}
- (UIButton *)upbtn
{
    if (!_upbtn) {
        _upbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5_SCREEN) {
             _upbtn.frame=CGRectMake(121, 100, 80, 80);
        }else{
        
            _upbtn.frame=CGRectMake(121, 70, 80, 80);
        
        }
       
        [_upbtn setImage:[UIImage imageNamed:@"JKApositionUp.png"] forState:UIControlStateNormal];
    }
    return _upbtn;
}
- (UIButton*)downbtn
{
    if (!_downbtn) {
        _downbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5_SCREEN) {
            _downbtn.frame=CGRectMake(121, 301,80, 80);
        }else{
        
            _downbtn.frame=CGRectMake(121, 271,80, 80);
        }
        
        [_downbtn setImage:[UIImage imageNamed:@"JKApositionDown.png"] forState:UIControlStateNormal];
    }
    return _downbtn;
}
- (UIButton *)leftbtn
{
    if (!_leftbtn) {
        _leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5_SCREEN) {
            _leftbtn.frame=CGRectMake(0, 201, 80, 80);
        }else{
        
            _leftbtn.frame=CGRectMake(0, 171, 80, 80);
        }
        
        [_leftbtn setImage:[UIImage imageNamed:@"JKApositionLeft.png"] forState:UIControlStateNormal];
    }
    return _leftbtn;

}
- (UIButton *)rightbtn
{
    if (!_rightbtn) {
        _rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        if (IS_IPHONE_5_SCREEN) {
            _rightbtn.frame=CGRectMake(241, 201, 80, 80);
        }else{
            
            _rightbtn.frame=CGRectMake(241, 171, 80, 80);
        }
        
        [_rightbtn setImage:[UIImage imageNamed:@"JKApositionRight.png"] forState:UIControlStateNormal];
    }

    return _rightbtn;
}
- (void) btnChangeColor
{
    [UIView animateWithDuration:0.1 animations:^{
        viewv.opaque=1;
        [viewv removeFromSuperview];
        
    }];

   
}
- (void)ruleinterface
{
    _isSingle=YES;
    UIButton * btn11=(UIButton*)[self.optionview viewWithTag:11];
    btn11.selected=NO;
    UIButton * btn12=(UIButton*)[self.optionview viewWithTag:12];
    btn12.selected=NO;
    UIButton * btn13=(UIButton*)[self.optionview viewWithTag:13];
    btn13.selected=NO;
//    UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
//    btn14.selected=NO;
    UIButton * btn15=(UIButton*)[self.optionview viewWithTag:15];
    btn15.selected=NO;
    if (IS_IPHONE_5_SCREEN) {
        _ruleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-170+y, SCREEN_WIDTH, 100)];
    }
    else{
        _ruleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100+y, SCREEN_WIDTH, 40)];
    }
    _ruleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ruleView];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5_SCREEN) {
        btn1.frame = CGRectMake(210, 10, 100, 25);
    }
    else
    {
        btn1.frame = CGRectMake(0, 10, 120, 20);
    }
    btn1.tag = 31;
    [btn1 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn1 setTitle:@"选则规则类型" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    [_ruleView addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5_SCREEN) {
        btn2.frame = CGRectMake(210, 40, 100, 25);
    }
    else{
        btn2.frame = CGRectMake(120, 10, 120, 20);
    }
    btn2.tag = 32;
    [btn2 setTitle:@"选择处理方案" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn2 addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    [_ruleView addSubview:btn2];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5_SCREEN) {
        btn3.frame = CGRectMake(270, 70, 40, 25);
    }
    else{
        btn3.frame = CGRectMake(260, 10, 40, 20);
    }
    btn3.tag = 33;
    [btn3 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
    btn3.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn3 setTitle:@"保存" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    [_ruleView addSubview:btn3];
    
    [self scaleScreen];
   



}
- (void)disablebtn{

    UIButton * btn11=(UIButton*)[self.optionview viewWithTag:11];
    UIButton * btn12=(UIButton*)[self.optionview viewWithTag:12];
    UIButton * btn13=(UIButton*)[self.optionview viewWithTag:13];
    UIButton * btn15=(UIButton*)[self.optionview viewWithTag:15];
    UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
    UIButton * btn16=(UIButton*)[self.optionview viewWithTag:16];
    btn11.enabled=NO;
    btn12.enabled=NO;
    btn13.enabled=NO;
    btn14.enabled=NO;
    btn15.enabled=NO;
    btn16.enabled=NO;


}
- (void)btnClick:(UIButton *)btn
{
    if (_isDouble==YES) {
        btn.selected=NO;
        _isSingle=NO;
        
        [self.consoleView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
        [self.upbtn removeFromSuperview];
        [self.downbtn removeFromSuperview];
        [self.leftbtn removeFromSuperview];
        [self.rightbtn removeFromSuperview];
        [self litterView];
    }else{
    viewv=[[UIView alloc]init];
    btn.selected = !btn.selected;
        
    if (btn.tag == 11)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
            /*
        [self setSelected:NO];
        self.isClick=YES;
        viewv.alpha = 0.6;
        viewv.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:viewv];
        [self performSelector:@selector(btnChangeColor) withObject:self afterDelay:0.1];
        //[btn setImage:[UIImage imageNamed:@"JKAbottomPZ.png"] forState:UIControlStateReserved];
        if (btn.selected==YES) {
            btn.selected=NO;
                if (_video1.selected==YES) {
                NSInteger myDataLength = 320 * 460 * 4;
                // allocate array and read pixels into it.
                GLubyte *buffer = (GLubyte *) malloc(myDataLength);
                glReadPixels(0, 0, 320, 460, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
                // gl renders "upside down" so swap top to bottom into new array.
                // there's gotta be a better way, but this works.
                GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
                for(int y1 = 0; y1 <460; y1++)
                {
                    for(int x1 = 0; x1 <320 * 4; x1++)
                    {
                        buffer2[(459 - y1) * 320 * 4 + x1] = buffer[y1 * 4 * 320 + x1];
                    }
                }
                free(buffer);
                // make data provider with data.
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
                // prep the ingredients
                int bitsPerComponent = 8;
                int bitsPerPixel = 32;
                int bytesPerRow = 4 * 320;
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
                CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
                // make the cgimage
                CGImageRef imageRef = CGImageCreate(320, 460, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
//                CGRect myImageRef = CGRectMake(0, 180, 320, 460);
                CGRect myImageRef = CGRectMake(0, 0, 0, 0);
                if (Big == 1) {
                   viewv.frame = CGRectMake(0, 100, 320, 310);
                   myImageRef  = CGRectMake(0, 180, 320, 460);
                }
                else{
                    viewv.frame = _bfView1.frame;
                    myImageRef = CGRectMake(0, 330, 150, 150);
                }
                CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRef);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, myImageRef, subImageRef);
                UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
                UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
                UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
            }
            if (_video2.selected==YES) {
                NSInteger myDataLength = 320 * 460 * 4;
                // allocate array and read pixels into it.
                GLubyte *buffer = (GLubyte *) malloc(myDataLength);
                glReadPixels(0, 0, 320, 460, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
                // gl renders "upside down" so swap top to bottom into new array.
                // there's gotta be a better way, but this works.
                GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
                for(int y1 = 0; y1 <460; y1++)
                {
                    for(int x1 = 0; x1 <320 * 4; x1++)
                    {
                        buffer2[(459 - y1) * 320 * 4 + x1] = buffer[y1 * 4 * 320 + x1];
                    }
                }
                free(buffer);
                // make data provider with data.
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
                // prep the ingredients
                int bitsPerComponent = 8;
                int bitsPerPixel = 32;
                int bytesPerRow = 4 * 320;
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
                CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
                // make the cgimage
                CGImageRef imageRef = CGImageCreate(320, 460, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
                CGRect myImageRef = CGRectMake(0, 0, 0, 0);
                if (Big == 1) {
                    viewv.frame = CGRectMake(0, 100, 320, 310);
                    myImageRef  = CGRectMake(0, 180, 320, 460);
                }
                else{
                    viewv.frame = _bfView2.frame;
                    myImageRef = CGRectMake(0, 330, 150, 150);
                }
                CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRef);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, myImageRef, subImageRef);
                UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
                UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
                UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
            }
            if (_video3.selected==YES) {
                NSInteger myDataLength = 320 * 460 * 4;
                // allocate array and read pixels into it.
                GLubyte *buffer = (GLubyte *) malloc(myDataLength);
                glReadPixels(0, 0, 320, 460, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
                // gl renders "upside down" so swap top to bottom into new array.
                // there's gotta be a better way, but this works.
                GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
                for(int y1 = 0; y1 <460; y1++)
                {
                    for(int x1 = 0; x1 <320 * 4; x1++)
                    {
                        buffer2[(459 - y1) * 320 * 4 + x1] = buffer[y1 * 4 * 320 + x1];
                    }
                }
                free(buffer);
                // make data provider with data.
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
                // prep the ingredients
                int bitsPerComponent = 8;
                int bitsPerPixel = 32;
                int bytesPerRow = 4 * 320;
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
                CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
                // make the cgimage
                CGImageRef imageRef = CGImageCreate(320, 460, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
                CGRect myImageRef = CGRectMake(0, 0, 0, 0);
                if (Big == 1) {
                    viewv.frame = CGRectMake(0, 100, 320, 310);
                    myImageRef  = CGRectMake(0, 180, 320, 460);
                }
                else{
                    viewv.frame = _bfView3.frame;
                    myImageRef = CGRectMake(0, 330, 150, 150);
                }
                CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRef);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, myImageRef, subImageRef);
                UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
                UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
                UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
            }
            if (_video4.selected==YES) {
                NSInteger myDataLength = 320 * 460 * 4;
                // allocate array and read pixels into it.
                GLubyte *buffer = (GLubyte *) malloc(myDataLength);
                glReadPixels(0, 0, 320, 460, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
                // gl renders "upside down" so swap top to bottom into new array.
                // there's gotta be a better way, but this works.
                GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
                for(int y1 = 0; y1 <460; y1++)
                {
                    for(int x1 = 0; x1 <320 * 4; x1++)
                    {
                        buffer2[(459 - y1) * 320 * 4 + x1] = buffer[y1 * 4 * 320 + x1];
                    }
                }
                free(buffer);
                // make data provider with data.
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
                // prep the ingredients
                int bitsPerComponent = 8;
                int bitsPerPixel = 32;
                int bytesPerRow = 4 * 320;
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
                CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
                // make the cgimage
                CGImageRef imageRef = CGImageCreate(320, 460, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
                CGRect myImageRef = CGRectMake(0, 0, 0, 0);
                if (Big == 1) {
                    viewv.frame = CGRectMake(0, 100, 320, 310);
                    myImageRef  = CGRectMake(0, 180, 320, 460);
                }
                else{
                    viewv.frame = _bfView4.frame;
                    myImageRef = CGRectMake(0, 330, 150, 150);
                }
                CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRef);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, myImageRef, subImageRef);
                UIImage *myImage = [UIImage imageWithCGImage:subImageRef];
                UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
                UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
            }
        }
        else{
            [btn setImage:[UIImage imageNamed:@"JKAbottomPZ.png"] forState:UIControlStateNormal];
        }
        [_consoleView removeFromSuperview];
        [_ruleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
*/
    }
    if (btn.tag == 12)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
        if ([self.bfView1.subviews containsObject:video1.view]&&video1.selected==YES) {
            btn.enabled=YES;
 
        }
        if ([self.bfView2.subviews containsObject:video2.view]&&video2.selected==YES) {
            btn.enabled=YES;
          
            
        }
        if ([self.bfView3.subviews containsObject:video3.view]&&video3.selected==YES) {
            btn.enabled=YES;
          
        }
        if ([self.bfView4.subviews containsObject:video4.view]&&video4.selected==YES) {
            btn.enabled=YES;
       
        }
        [self setSelected:NO];
        self.isClick=YES;
        if (btn.selected==YES) {
           
            UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
            btn14.selected=NO;
        
            
        }
        [_consoleView removeFromSuperview];
        [_ruleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
    }
    
    if (btn.tag == 13)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
        [self setSelected:NO];
        self.isClick=YES;
        [_ruleView removeFromSuperview];
        [_definitionView removeFromSuperview];
         [tint removeFromSuperview];
        
        if (btn.selected == YES)
        {
            _isSingle=YES;
            _selectbig=YES;
            UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
                btn14.selected=NO;
            
            if ([self.bfView1.subviews containsObject:video1.view]&&video1.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
                btn.enabled=YES;
                [self scaleYuntai];
                [self.view addSubview:self.consoleView];
            }
            if ([self.bfView2.subviews containsObject:video2.view]&&video2.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
                btn.enabled=YES;
                [self scaleYuntai];
                [self.view addSubview:self.consoleView];
            
            }
            if ([self.bfView3.subviews containsObject:video3.view]&&video3.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
                btn.enabled=YES;
                [self scaleYuntai];
                [self.view addSubview:self.consoleView];;
            }
            if ([self.bfView4.subviews containsObject:video4.view]&&video4.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
                btn.enabled=YES;
                [self scaleYuntai];
                [self.view addSubview:self.consoleView];
            }
            [self.view bringSubviewToFront:self.iview];
        }
        else
        {
          
            _isSingle=NO;
            _selectbig=NO;
            [self smallScreen];
            [self.consoleView removeFromSuperview];
            [self.focalView removeFromSuperview];
            [self.focusView removeFromSuperview];
            [self.haloView removeFromSuperview];
            [_ruleView removeFromSuperview];
            [_definitionView removeFromSuperview];
            [self.ruleview1 removeFromSuperview];
            [self.ruleview2 removeFromSuperview];
            NSMutableArray * urlcount=[[Getrules shareRules] takeurlinfo];
            if (urlcount.count==1) {
                [self.bfView1 addSubview:self.paint1];
            }
            if (urlcount.count==2) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                
            }
            if (urlcount.count==3) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
            }
            if (urlcount.count==4) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
                [self.bfView4 addSubview:self.paint4];
            }
            [self.view bringSubviewToFront:self.iview];
        }
    
   }
    if (btn.tag == 14)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
         [self setSelected:NO];
        self.isClick=YES;
        [self.upbtn removeFromSuperview];
        [self.downbtn removeFromSuperview];
        [self.leftbtn removeFromSuperview];
        [self.rightbtn removeFromSuperview];
        [_consoleView removeFromSuperview];
        [_definitionView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
       
        if (btn.selected == YES)
        {
            _selectbig=YES;
            
            if ([self.bfView1.subviews containsObject:video1.view]&&video1.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
               // [self.bfView1 addSubview:self.paint5];
                btn.enabled=YES;
                [self ruleinterface];
                btn.selected=YES;
                NSDictionary * num1=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"idx", nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"traf" object:self userInfo:num1];
            }
            if ([self.bfView2.subviews containsObject:video2.view]&&video2.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
               // [video2.view addSubview:self.paint6];
                btn.enabled=YES;
                [self ruleinterface];
                btn.selected=YES;
                NSDictionary * num1=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"idx", nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"traf" object:self userInfo:num1];
            }
            if ([self.bfView3.subviews containsObject:video3.view]&&video3.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
               // [video3.view addSubview:self.paint7];
                btn.enabled=YES;
                [self ruleinterface];
                btn.selected=YES;
                NSDictionary * num1=[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"idx", nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"traf" object:self userInfo:num1];
            }
            if ([self.bfView4.subviews containsObject:video4.view]&&video4.selected==YES) {
                [self.paint1 removeFromSuperview];
                [self.paint2 removeFromSuperview];
                [self.paint3 removeFromSuperview];
                [self.paint4 removeFromSuperview];
               // [video4.view addSubview:self.paint8];
                btn.enabled=YES;
                [self ruleinterface];
                btn.selected=YES;
                NSDictionary * num1=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"idx", nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"traf" object:self userInfo:num1];
            }
            [self.view bringSubviewToFront:self.iview];
            
        }else
        {
          
            _selectbig=NO;
                _isSingle=NO;
                btn.selected=NO;
                [self smallScreen];
                [_ruleView removeFromSuperview];
                [self.ruleview1 removeFromSuperview];
                [self.ruleview2 removeFromSuperview];
                [_draw removeFromSuperview];
                [tint removeFromSuperview];
            [self.view bringSubviewToFront:self.paint1];
            [self.view bringSubviewToFront:self.paint2];
            [self.view bringSubviewToFront:self.paint3];
            [self.view bringSubviewToFront:self.paint4];
            NSMutableArray * urlcount=[[Getrules shareRules] takeurlinfo];
            if (urlcount.count==1) {
                [self.paint5 removeFromSuperview];
                [self.bfView1 addSubview:self.paint1];
                
            }
            if (urlcount.count==2) {
                [self.paint5 removeFromSuperview];
                [self.paint6 removeFromSuperview];
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                
            }
            if (urlcount.count==3) {
                [self.paint5 removeFromSuperview];
                [self.paint6 removeFromSuperview];
                [self.paint7 removeFromSuperview];
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
            }
            if (urlcount.count==4) {
                [self.paint5 removeFromSuperview];
                [self.paint6 removeFromSuperview];
                [self.paint7 removeFromSuperview];
                [self.paint8 removeFromSuperview];
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
                [self.bfView4 addSubview:self.paint4];
            }
            [self.view bringSubviewToFront:self.iview];
        }
    }
    if (btn.tag == 15)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
         [self setSelected:NO];
        [_consoleView removeFromSuperview];
        [_ruleView removeFromSuperview];
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
        if (btn.selected == YES)
        {
            UIButton * btn11=(UIButton*)[self.optionview viewWithTag:11];
            btn11.selected=NO;
            UIButton * btn13=(UIButton*)[self.optionview viewWithTag:13];
            btn13.selected=NO;
            UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
            btn14.selected=NO;
            if (IS_IPHONE_5_SCREEN) {
                _definitionView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-110+y, SCREEN_WIDTH, 40)];
            }
            else{
                _definitionView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100+y, SCREEN_WIDTH, 40)];
            }
            _definitionView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
            [self.view addSubview:_definitionView];
            NSArray *titleArray = [[NSArray alloc]initWithObjects:@"超清",@"高清",@"流畅",@"自定义", nil];
            for (int i=0; i<4; i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+i*80, 0, 79, 40);
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:0.08f green:0.51f blue:0.78f alpha:1.00f] forState:UIControlStateSelected];
                btn.tag = 41+i;
                [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
                [_definitionView addSubview:btn];
            }
        }
        else
        {
            [_definitionView removeFromSuperview];
        }
    }
    if (btn.tag == 16)
    {
        [self disablebtn];
        [self performSelector:@selector(enablebtn) withObject:self afterDelay:0.2];
         [self setSelected:NO];
        if (btn.selected==YES) {
            [video1 pause];
            [video2 pause];
            [video3 pause];
            [video4 pause];
            [btn setImage:[UIImage imageNamed:@"JKAbottomBF.png"] forState:UIControlStateSelected];
            
            
            
        }else {
            [video1 play];
            [video2 play];
            [video3 play];
            [video4 play];
            [btn setImage:[UIImage imageNamed:@"JKAbottomZT.png"] forState:UIControlStateNormal];
            
            
        }
       
    }
    }
}
- (UIView*)ruleview1{
    if (!_ruleview1) {
        if (IS_IPHONE_5_SCREEN) {
            _ruleview1=[[UIView alloc]initWithFrame:CGRectMake(45, 160, SCREEN_WIDTH-90, 274)];
        }
        else{
            _ruleview1=[[UIView alloc]initWithFrame:CGRectMake(45, 70, SCREEN_WIDTH-90, 274)];
        }
        _ruleview1.layer.cornerRadius = 5;
        _leiXing = [NSMutableArray arrayWithObjects:@"警戒线",@"进入指定区域",@"区域内物体失窃",@"运动物体计数", nil];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 230, 50)];
        label.backgroundColor = [UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f];
        label.font = [UIFont systemFontOfSize:17];
        [label setText:@"选择规则类型"];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        [_ruleview1 addSubview:label];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 224, 230, 50);
        btn1.backgroundColor = [UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f];
        [btn1 setTitle:@"下一步" forState: UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn1.showsTouchWhenHighlighted=YES;
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        btn1.tag=65;
        btn1.layer.cornerRadius = 5;
        btn1.layer.masksToBounds = YES;
        [btn1 addTarget:self action:@selector(gofaan) forControlEvents:UIControlEventTouchUpInside];
        [_ruleview1 addSubview:btn1];
        
        for (int i=0; i<4; i++)
        {
            QCheckBox * checkBox = [[QCheckBox alloc]initWithDelegate:self];
            checkBox.frame = CGRectMake(0, 45+46*i, 230, 45);
            checkBox.backgroundColor = [UIColor whiteColor];
            [checkBox setTitle:[_leiXing objectAtIndex:i] forState:UIControlStateNormal];
            [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [checkBox.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [checkBox addTarget:self action:@selector(selectQcheck:) forControlEvents:UIControlEventTouchUpInside];
            [_ruleview1 addSubview:checkBox];
            checkBox.tag = i+50;
            [checkBox setChecked:NO];
            
        }
        
        for (int j=0; j<3; j++) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 90+46*j, 230, 1)];
            label1.backgroundColor = [UIColor colorWithRed:236.0/255.0f green:237.0/255.0f blue:238.0/255.0f alpha:1.0f];
            [_ruleview1 addSubview:label1];
        }
        
    }
    return _ruleview1;
}
- (UIView*)ruleview2{
    if (!_ruleview2) {
        if (IS_IPHONE_5_SCREEN) {
            _ruleview2=[[UIView alloc]initWithFrame:CGRectMake(45, 160, SCREEN_WIDTH-90, 274)];
        }
        else{
            _ruleview2=[[UIView alloc]initWithFrame:CGRectMake(45, 70, SCREEN_WIDTH-90, 274)];
        }
        checkBoxs=[NSMutableArray arrayWithCapacity:1];
        _ruleview2.layer.cornerRadius = 5;
        _fangan = [NSMutableArray arrayWithObjects:@"实时日志",@"截图",@"触发报警录像",@"触发警铃", nil];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 230, 50)];
        label.backgroundColor = [UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f];
        label.font = [UIFont systemFontOfSize:17];
        [label setText:@"选择处理方案"];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        [_ruleview2 addSubview:label];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 224, 118, 50);
        btn1.backgroundColor = [UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f];
        [btn1 setTitle:@"上一步" forState: UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        btn1.showsTouchWhenHighlighted=YES;
        btn1.tag=66;
        btn1.layer.cornerRadius = 5;
        btn1.layer.masksToBounds = YES;
        [btn1 addTarget:self action:@selector(upperside) forControlEvents:UIControlEventTouchUpInside];
        [_ruleview2 addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(110, 224, 120, 50);
        btn2.backgroundColor = [UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f];
        [btn2 setTitle:@"确定，下一步" forState: UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:3.0/255.0f green:125.0/255.0f blue:199/255.0f alpha:1.00f] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        btn2.showsTouchWhenHighlighted=YES;
        btn2.tag=64;
        btn2.layer.cornerRadius = 5;
        btn2.layer.masksToBounds = YES;
        [btn2 addTarget:self action:@selector(wipeGetoff:) forControlEvents:UIControlEventTouchUpInside];
        [_ruleview2 addSubview:btn2];
        
        for (int i= 0; i<4; i++)
        {
            QCheckBox * checkBox = [[QCheckBox alloc]initWithDelegate:self];
            checkBox.frame = CGRectMake(0, 45+46*i, 230, 45);
            checkBox.backgroundColor = [UIColor whiteColor];
            [checkBox setTitle:[_fangan objectAtIndex:i] forState:UIControlStateNormal];
            [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [checkBox.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [checkBox addTarget:self action:@selector(selImage:) forControlEvents:UIControlEventTouchUpInside];
            [_ruleview2 addSubview:checkBox];
            [checkBox setChecked:NO];
            
        }
       
        for (int j=0; j<3; j++) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 90+46*j, 230, 1)];
            label1.backgroundColor = [UIColor colorWithRed:236.0/255.0f green:237.0/255.0f blue:238.0/255.0f alpha:1.0f];
            [_ruleview2 addSubview:label1];
        }
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(113, 229, 2, 45)];
        label2.backgroundColor = [UIColor colorWithRed:217.0/255.0f green:218.0/255.0f blue:218.0/255.0f alpha:1.0f];
        [_ruleview2 addSubview:label2];
        
    }
    return _ruleview2;
}
- (void)gofaan
{
    [self.ruleview1 removeFromSuperview];
    self.ruleview1=nil;
    [self.view addSubview:self.ruleview2];
    _lab.text=_typename;
    if (IS_IPHONE_5_SCREEN) {
        [_ruleView addSubview:_lab];
    }
    else{
    }
}
- (void)selImage:(QCheckBox*)cbn
{
   
    [checkBoxs addObject:cbn];
    if ([cbn.titleLabel.text isEqualToString:@"实时日志"]) {
        UIImage * img=[UIImage imageNamed:@"JKAbottomBJ.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        else{
        }
        
        [faCode addObject:@"0"];
        
    }
    if ([cbn.titleLabel.text isEqualToString:@"截图"]) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomJP.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        else{
        }
       
            [faCode addObject:@"1"];
        
    }
    if ([cbn.titleLabel.text isEqualToString:@"触发报警录像"]) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomLX.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        else{
        }
      
            [faCode addObject:@"2"];
        
    }
    if ([cbn.titleLabel.text isEqualToString:@"触发警铃"]) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomSYon.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        else{
        }
        
            [faCode addObject:@"3"];
        
    }
}
- (UIView*)focalView
{
    if (!_focalView) {
        if (IS_IPHONE_5_SCREEN) {
            _focalView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-170+y, 320, 50)];
        }
        else{
            _focalView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-130+y, 320, 30)];
        }
        
    }
    
    return _focalView;
}
- (UIView*)focusView
{
    if (!_focusView) {
        if (IS_IPHONE_5_SCREEN) {
            _focusView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-170+y, 320, 50)];
        }
        else{
            _focusView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-130+y, 320, 30)];
        }
        
        
    }
    return  _focusView;
}
- (UIView*)haloView
{
    if (!_haloView) {
        if (IS_IPHONE_5_SCREEN) {
            _haloView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-170+y, 320, 50)];
        }
        else{
            _haloView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-130+y, 320, 30)];
        }
        
    }
    
    return _haloView;
}
#pragma mark - 二级工具条
- (void)clearVideo:(int)i
{

}

- (void)btnClick2:(ImageBtn *)btn
{
    if (btn.tag == 21 || btn.tag == 22 || btn.tag == 23 || btn.tag == 24 || btn.tag == 25)
    {
        UIView *selectedView = btn.superview;
        for (ImageBtn *btn in selectedView.subviews)
        {
            if ([btn isKindOfClass:[ImageBtn class]])
            {
                btn.isSelect = NO;
            }
        }
    }
    //btn.selected = !btn.selected;
    if (btn.tag == 21)
    {
        if (btn.isSelect==YES) {
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:21];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2A.png"];
            [self.focalView removeFromSuperview];
            btn.isSelect=NO;
        }
        else{
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:21];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2Aon.png"];
            image.isSelect=YES;
            ImageBtn *image2=(ImageBtn *) [self.consoleView viewWithTag:22];
            image2.imgv.image=[UIImage imageNamed:@"JKAbottom2B.png"];
            image2.isSelect=NO;
            ImageBtn *image3=(ImageBtn *) [self.consoleView viewWithTag:23];
            image3.imgv.image=[UIImage imageNamed:@"JKAbottom2C.png"];
            image3.isSelect=NO;
            ImageBtn *image4=(ImageBtn *) [self.consoleView viewWithTag:24];
            image4.imgv.image=[UIImage imageNamed:@"JKAbottom2D.png"];
            image4.isSelect=NO;
            ImageBtn *image5=(ImageBtn *) [self.consoleView viewWithTag:25];
            image5.imgv.image=[UIImage imageNamed:@"JKAbottom2E.png"];
            image5.isSelect=NO;
        }
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
    }
    if (btn.tag == 22)
    {

        if (btn.isSelect==YES) {
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:22];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2B.png"];
            [self.focalView removeFromSuperview];
            btn.isSelect=NO;
        }
        else{
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:22];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2Bon.png"];
            image.isSelect=YES;
            ImageBtn *image2=(ImageBtn *) [self.consoleView viewWithTag:21];
            image2.imgv.image=[UIImage imageNamed:@"JKAbottom2A.png"];
            image2.isSelect=NO;
            ImageBtn *image3=(ImageBtn *) [self.consoleView viewWithTag:23];
            image3.imgv.image=[UIImage imageNamed:@"JKAbottom2C.png"];
            image3.isSelect=NO;
            ImageBtn *image4=(ImageBtn *) [self.consoleView viewWithTag:24];
            image4.imgv.image=[UIImage imageNamed:@"JKAbottom2D.png"];
            image4.isSelect=NO;
            ImageBtn *image5=(ImageBtn *) [self.consoleView viewWithTag:25];
            image5.imgv.image=[UIImage imageNamed:@"JKAbottom2E.png"];
            image5.isSelect=NO;
        self.focalView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.focalView];
        self.litteltitle.text = @"焦距";
        self.litteltitle.font = [UIFont fontWithName:@"" size:17];
        self.litteltitle.textAlignment = NSTextAlignmentCenter;
        [self.focalView addSubview:self.litteltitle];
        self.focal1.image = [UIImage imageNamed:@"JKbottomJJ2left.png"];
        [self.focalView addSubview:self.focal1];
        [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventEditingChanged];
        self.slider.tag = 1;
        [self.focalView addSubview:self.slider];
        self.focal2.image = [UIImage imageNamed:@"JKbottomJJ2right.png"];
        [self.focalView addSubview:self.focal2];
            _secClick=YES;
          
            [self.focusView removeFromSuperview];
            [self.haloView removeFromSuperview];
        }
    }
    if (btn.tag == 23)
    {

        if (btn.isSelect==YES) {
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:23];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2C.png"];
            [self.focusView removeFromSuperview];
            btn.isSelect=NO;
        }
        else{
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:23];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2Con.png"];
            image.isSelect=YES;
            ImageBtn *image2=(ImageBtn *) [self.consoleView viewWithTag:22];
            image2.imgv.image=[UIImage imageNamed:@"JKAbottom2B.png"];
            image2.isSelect=NO;
            ImageBtn *image3=(ImageBtn *) [self.consoleView viewWithTag:21];
            image3.imgv.image=[UIImage imageNamed:@"JKAbottom2A.png"];
            image3.isSelect=NO;
            ImageBtn *image4=(ImageBtn *) [self.consoleView viewWithTag:24];
            image4.imgv.image=[UIImage imageNamed:@"JKAbottom2D.png"];
            image4.isSelect=NO;
            ImageBtn *image5=(ImageBtn *) [self.consoleView viewWithTag:25];
            image5.imgv.image=[UIImage imageNamed:@"JKAbottom2E.png"];
            image5.isSelect=NO;
        self.focusView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.focusView];
        self.litteltitle.text = @"聚焦";
        self.litteltitle.font = [UIFont fontWithName:@"" size:17];
        self.litteltitle.textAlignment = NSTextAlignmentCenter;
        [self.focusView addSubview:self.litteltitle];
        self.focal1.image = [UIImage imageNamed:@"JKbottomJJleft.png"];
        [self.focusView addSubview:self.focal1];
        [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventEditingChanged];
        self.slider.tag = 2;
        [self.focusView addSubview:self.slider];
        self.focal2.image = [UIImage imageNamed:@"JKbottomJJright.png"];
        [self.focusView addSubview:self.focal2];
            _secClick=YES;
            [self.focalView removeFromSuperview];
            
            [self.haloView removeFromSuperview];
        }
    }
    if (btn.tag == 24)
    {

        if (btn.isSelect==YES) {
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:24];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2D.png"];
            [self.haloView removeFromSuperview];
            btn.isSelect=NO;
        }
        else{
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:24];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2Don.png"];
            image.isSelect=YES;
            ImageBtn *image2=(ImageBtn *) [self.consoleView viewWithTag:22];
            image2.imgv.image=[UIImage imageNamed:@"JKAbottom2B.png"];
            image2.isSelect=NO;
            ImageBtn *image3=(ImageBtn *) [self.consoleView viewWithTag:23];
            image3.imgv.image=[UIImage imageNamed:@"JKAbottom2C.png"];
            image3.isSelect=NO;
            ImageBtn *image4=(ImageBtn *) [self.consoleView viewWithTag:21];
            image4.imgv.image=[UIImage imageNamed:@"JKAbottom2A.png"];
            image4.isSelect=NO;
            ImageBtn *image5=(ImageBtn *) [self.consoleView viewWithTag:25];
            image5.imgv.image=[UIImage imageNamed:@"JKAbottom2E.png"];
            image5.isSelect=NO;
            [self.view addSubview:self.haloView];
        self.haloView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.haloView];
        self.litteltitle.text = @"光圈";
        self.litteltitle.font = [UIFont fontWithName:@"" size:17];
        self.litteltitle.textAlignment = NSTextAlignmentCenter;
        [self.haloView addSubview:self.litteltitle];
        self.focal1.image = [UIImage imageNamed:@"JKbottomGQleft.png"];
        [self.haloView addSubview:self.focal1];
        [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventEditingChanged];
        self.slider.tag = 3;
        [self.haloView addSubview:self.slider];
        self.focal2.image = [UIImage imageNamed:@"JKbottomGQright.png"];
        [self.haloView addSubview:self.focal2];
            _secClick=YES;
            [self.focalView removeFromSuperview];
            [self.focusView removeFromSuperview];
            
                    }
        

    }
    if (btn.tag == 25)
    {
        if (btn.isSelect==YES) {
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:25];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2E.png"];
            [self.focalView removeFromSuperview];
            btn.isSelect=NO;
        }
        else{
            ImageBtn *image=(ImageBtn *) [self.consoleView viewWithTag:25];
            image.imgv.image=[UIImage imageNamed:@"JKAbottom2Eon.png"];
            image.isSelect=YES;
            ImageBtn *image2=(ImageBtn *) [self.consoleView viewWithTag:22];
            image2.imgv.image=[UIImage imageNamed:@"JKAbottom2B.png"];
            image2.isSelect=NO;
            ImageBtn *image3=(ImageBtn *) [self.consoleView viewWithTag:23];
            image3.imgv.image=[UIImage imageNamed:@"JKAbottom2C.png"];
            image3.isSelect=NO;
            ImageBtn *image4=(ImageBtn *) [self.consoleView viewWithTag:24];
            image4.imgv.image=[UIImage imageNamed:@"JKAbottom2D.png"];
            image4.isSelect=NO;
            ImageBtn *image5=(ImageBtn *) [self.consoleView viewWithTag:21];
            image5.imgv.image=[UIImage imageNamed:@"JKAbottom2A.png"];
            image5.isSelect=NO;
            _secClick=YES;
        }
        
        [self.focalView removeFromSuperview];
        [self.focusView removeFromSuperview];
        [self.haloView removeFromSuperview];
    }
    if (btn.tag == 31)
    {
        self.ruleview1.backgroundColor = [UIColor whiteColor];
        [self.ruleview2 removeFromSuperview];
        [self.view addSubview:self.backGround];
        [self.view addSubview:self.ruleview1];
    }
    if (btn.tag == 32)
    {
        self.ruleview2.backgroundColor = [UIColor whiteColor];
        self.ruleview2.userInteractionEnabled = YES;
        [self.ruleview1 removeFromSuperview];
       [self.view addSubview:self.backGround];
        [self.view addSubview:self.ruleview2];
        
    }
    if (btn.tag == 33)
    {
        
        //self.idx=[saveIndex shareindex].indexsarray;
        
        NSString *rulename=_typename;
        NSMutableString *fazh=[NSMutableString stringWithCapacity:1];
        
        for (int n=0; n<faCode.count; n++) {
            NSString * str=[NSString stringWithFormat:@"%@,",[faCode objectAtIndex:n]];
            [fazh appendString:str];
            
        }
        Rules * rul=[[Rules alloc]init];
       
        rul.precept=fazh;
        rul.points=pointstring;
        rul.isused=1;
       
        rul.descript=rul.rulename;
        [self.idx removeAllObjects];
        NSMutableArray * urlfo=[[Getrules shareRules] takeurlinfo];
        for (int i=0; i<urlfo.count; i++) {
            urlinfo * ulf=[urlfo objectAtIndex:i];
            [self.idx addObject:[NSNumber numberWithInt:ulf.index]];
            [widths addObject:[NSNumber numberWithInt:ulf.width]];
            [heights addObject:[NSNumber numberWithInt:ulf.height]];
        }
        NSLog(@"selected=%d",video1.selected);
        NSLog(@"movieurl=%@",movieurl);
        NSLog(@"self.idx=%@",self.idx);
        NSString * mypath;
        if (video1.selected==YES) {
            mypath=(NSString*)[movieurl objectAtIndex:0];
            int index=[[self.idx objectAtIndex:0] intValue];
            rul.channlid=index;
            rul.width=[[widths objectAtIndex:0] intValue];
            rul.height=[[heights objectAtIndex:0] intValue];
        }
        if (video2.selected==YES) {
            mypath=(NSString*)[movieurl objectAtIndex:1];
            int index=[[self.idx objectAtIndex:1] intValue];
            rul.channlid=index;
            rul.width=[[widths objectAtIndex:1] intValue];
            rul.height=[[heights objectAtIndex:1] intValue];
        }
        if (video3.selected==YES) {
            mypath=(NSString*)[movieurl objectAtIndex:2];
            int index=[[self.idx objectAtIndex:2] intValue];
            rul.channlid=index;
            rul.width=[[widths objectAtIndex:2] intValue];
            rul.height=[[heights objectAtIndex:2] intValue];
        }
        if (video4.selected==YES) {
            mypath=(NSString*)[movieurl objectAtIndex:3];
            int index=[[self.idx objectAtIndex:3] intValue];
            rul.channlid=index;
            rul.width=[[widths objectAtIndex:3] intValue];
            rul.height=[[heights objectAtIndex:3] intValue];
        }
        rul.path=mypath;
       
             rul.rulename=rulename;
            if ([rul.rulename isEqualToString:@"警戒线"]) {
                rul.descript=@"警戒线";
                rul.eventtype=0;
                rul.shapetype=0;
            }
            
            if ([rul.rulename isEqualToString:@"进入指定区域"]) {
                rul.descript=@"进入指定区域";
                rul.eventtype=2;
                rul.shapetype=3;
            }
           
            if ([rul.rulename isEqualToString:@"区域内物体失窃"]) {
                rul.descript=@"区域内物体失窃";
                rul.eventtype=5;
                rul.shapetype=1;
            }
          
            if ([rul.rulename isEqualToString:@"运动物体计数"]) {
                rul.descript=@"运动物体计数";
                rul.eventtype=13;
                rul.shapetype=1;
            }
        
        [rulearray removeAllObjects];
        [newrulearray removeAllObjects];
        rulearray=[[Getrules shareRules]takeruleid:rul.channlid];
    
        for (int i=0; i<16; i++) {
            NSNumber * idd=[NSNumber numberWithInt:i+1];
            if (![rulearray containsObject:idd]) {
                [newrulearray addObject:idd];
                
            }
        }
       
        if (newrulearray.count==0) {
            
            UIAlertView * art=[[UIAlertView alloc]initWithTitle:@"规则超出16条" message:@"请删除一条规则再添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [art show];
            return;
        }else{
            
            rul.ruleid=[[newrulearray objectAtIndex:0] intValue];
        }
        NSLog(@"rulename=%@",rul.rulename);
        NSLog(@"point=%@",rul.points);
        NSLog(@"precept=%@",rul.precept);
        NSLog(@"rulepath=%@",rul.path);
        if (rul.rulename.length==0||rul.precept==nil||rul.points==nil) {
            //rul.precept=@"0,0,0,0,";
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"规则必须完整" message:@"请填写完整的规则方案并且画出规则线或规则区域" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }else{
            [[self backGround] removeFromSuperview];
            UIButton * btn14=(UIButton*)[self.optionview viewWithTag:14];
            btn14.selected=NO;
            [self.ruleview1 removeFromSuperview];
            [self.ruleview2 removeFromSuperview];
            [_ruleView removeFromSuperview];
            [_draw removeFromSuperview];
            [[Getrules shareRules]addRules:rul];
            [saveIndex shareindex].sendRule=rul;
            [[SocketServer shareSocket] sendRule];
            [UIView animateWithDuration:0.2 animations:^{
                _info=[[UILabel alloc]initWithFrame:CGRectMake(90, 200, 160, 50)];
                _info.backgroundColor=[UIColor whiteColor];
                _info.textAlignment=NSTextAlignmentCenter;
                _info.layer.cornerRadius=5;
                _info.layer.masksToBounds=YES;
                _info.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
                _info.text=@"保存成功";
                 [[[UIApplication sharedApplication] keyWindow] addSubview:_info];
            }];
            total=(int)[[Getrules shareRules] takeurlinfo].count;
            [faCode removeAllObjects];
            [self performSelector:@selector(removeinfo) withObject:self afterDelay:1];
            [self litterView];
            [tint removeFromSuperview];
            [self.paint1 removeFromSuperview];
            [self.paint2 removeFromSuperview];
            [self.paint3 removeFromSuperview];
            [self.paint4 removeFromSuperview];
            self.paint1=nil;
            self.paint2=nil;
            self.paint3=nil;
            self.paint4=nil;
             NSMutableArray * info=[[Getrules shareRules] takeurlinfo];
            if (info.count==1) {
                [self.bfView1 addSubview:self.paint1];
            }
            if (info.count==2) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
            }
            if (info.count==3) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
                
            }
            if (info.count==4) {
                [self.bfView1 addSubview:self.paint1];
                [self.bfView2 addSubview:self.paint2];
                [self.bfView3 addSubview:self.paint3];
                [self.bfView4 addSubview:self.paint4];
            }
        
        }
        
        
       
    }
    if (btn.tag == 41 || btn.tag == 42 || btn.tag == 43 || btn.tag == 44)
    {
        UIView *selectedView = btn.superview;
        for(UIButton *btn in selectedView.subviews)
        {
            if([btn isKindOfClass:[UIButton class]])
            {
                // 将所有的颜色都变为初始颜色
                btn.selected = NO;
            }
        }
       // btn.selected = !btn.selected;
    }
}
- (void)removeinfo
{
    [_info removeFromSuperview];
    _info=nil;

}
- (void)selectQcheck:(QCheckBox*)btn
{
    
    _checktag=(int)btn.tag;
    btn.checked=YES;
    if (btn.tag==50) {
        if (IS_IPHONE_5_SCREEN) {
            _lab.text=nil;
            _typename=btn.titleLabel.text;
        }
        _typename=btn.titleLabel.text;
        QCheckBox * qbtn=(QCheckBox*)[self.ruleview1 viewWithTag:51];
        qbtn.checked=NO;
        QCheckBox * qbtn1=(QCheckBox*)[self.ruleview1 viewWithTag:52];
        qbtn1.checked=NO;
        QCheckBox * qbtn2=(QCheckBox*)[self.ruleview1 viewWithTag:53];
        qbtn2.checked=NO;
        
    }
    if (btn.tag == 51)
    {
        if (IS_IPHONE_5_SCREEN) {
            _lab.text=nil;
            _typename=btn.titleLabel.text;
        }
        _typename=btn.titleLabel.text;
        QCheckBox * qbtn=(QCheckBox*)[self.ruleview1 viewWithTag:50];
        qbtn.checked=NO;
        QCheckBox * qbtn1=(QCheckBox*)[self.ruleview1 viewWithTag:52];
        qbtn1.checked=NO;
        QCheckBox * qbtn2=(QCheckBox*)[self.ruleview1 viewWithTag:53];
        qbtn2.checked=NO;
       
    }
    if (btn.tag==52||btn.tag==53) {
        if (IS_IPHONE_5_SCREEN) {
            _lab.text=nil;
            _typename=btn.titleLabel.text;
        }
        _typename=btn.titleLabel.text;
        if (btn.tag==52) {
            QCheckBox * qbtn=(QCheckBox*)[self.ruleview1 viewWithTag:51];
            qbtn.checked=NO;
            QCheckBox * qbtn1=(QCheckBox*)[self.ruleview1 viewWithTag:50];
            qbtn1.checked=NO;
            QCheckBox * qbtn2=(QCheckBox*)[self.ruleview1 viewWithTag:53];
            qbtn2.checked=NO;
            
        }
        if (btn.tag==53) {
            QCheckBox * qbtn=(QCheckBox*)[self.ruleview1 viewWithTag:51];
            qbtn.checked=NO;
            QCheckBox * qbtn1=(QCheckBox*)[self.ruleview1 viewWithTag:52];
            qbtn1.checked=NO;
            QCheckBox * qbtn2=(QCheckBox*)[self.ruleview1 viewWithTag:50];
            qbtn2.checked=NO;
            
        }
    }
}

- (void)upperside
{
    [self.ruleview2 removeFromSuperview];
    [self.view addSubview:self.backGround];
    [self.view addSubview:self.ruleview1];
    
    
}
- (void)wipeGetoff:(UIButton*)btn
{
    if (IS_IPHONE_5_SCREEN) {
        for (int j=0; j<checkBoxs.count; j++) {
            QCheckBox * checked=(QCheckBox*)[checkBoxs objectAtIndex:j];
            checked.checked=NO;
        }
        for (int k=0; k<displayImgs.count; k++) {
            UIImageView * oldview=(UIImageView*)[displayImgs objectAtIndex:k];
            [oldview removeFromSuperview];
        }
        for (int i=0; i<checkBoxs.count; i++) {
            
            UIImageView * igv=(UIImageView*)[displayImgs objectAtIndex:i];
            UIImage * img=(UIImage *)[imG objectAtIndex:i];
            igv.image=img;
            [_ruleView addSubview:igv];
            
        }
        
    }
    [self.backGround removeFromSuperview];
    self.backGround = nil;
    [checkBoxs removeAllObjects];
    [imG removeAllObjects];
    [self.ruleview2 removeFromSuperview];
    [self drawClick];
    [self tinters];

}
- (void)tinters
{
    if(IS_IPHONE_5_SCREEN){
        tint=[[UILabel alloc]initWithFrame:CGRectMake(110, 70, 320, 30)];
    }
    else{
        tint=[[UILabel alloc]initWithFrame:CGRectMake(110, 370, 320, 30)];
    }

    tint.text=@"请在视频上划线";
    tint.textColor=[UIColor whiteColor];
    tint.font=[UIFont systemFontOfSize:15];
    tint.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:tint];

}
- (void)drawClick
{
    [self.backGround removeFromSuperview];
     [self.ruleview1 removeFromSuperview];
    self.ruleview1=nil;
  
    if (_checktag == 50 || _checktag == 58)
    {
       
        _draw.type = 1;
        
        
    }
   
    if (_checktag == 52 || _checktag == 53||_checktag==51)
    {
       
       
        _draw.type = 3;
    }
    if (_checktag == 54 || _checktag == 55 || _checktag == 56 || _checktag == 58)
    {
       
        
        _draw.type = 4;
    }
    
    if (_checktag == 60 || _checktag == 61 || _checktag== 62 || _checktag == 63)
    {

    }
    
}
- (void)pointstr:(NSNotification*)info
{
    
    NSString * s1=[[info userInfo]valueForKey:@"fx"];
    NSString * s2=[[info userInfo]valueForKey:@"fy"];
    NSString * s3=[[info userInfo]valueForKey:@"ex"];
    NSString * s4=[[info userInfo]valueForKey:@"ey"];
    pointstring=[NSString stringWithFormat:@"%@,%@,%@,%@",s1,s2,s3,s4];
    NSLog(@"pointstring=%@",pointstring);

}
- (void)Recpoint:(NSNotification*)info
{
    NSString * s1=[[info userInfo]valueForKey:@"fx"];
    NSString * s2=[[info userInfo]valueForKey:@"fy"];
    NSString * s3=[[info userInfo]valueForKey:@"ex"];
    NSString * s4=[[info userInfo]valueForKey:@"ey"];
    pointstring=[NSString stringWithFormat:@"%@,%@,%@,%@",s1,s2,s3,s4];


}
- (void)sliderChange:(UISlider *)slider
{

    slider.minimumValue = 0;
    slider.maximumValue = 10;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offset=scrollView.contentOffset.x;
    if (total==4) {
        if (IS_IPHONE_5_SCREEN) {
            self.scroll.contentSize=CGSizeMake(1280, 320);
        }else{
           self.scroll.contentSize=CGSizeMake(1280, 317);
        
        }
        
        if (offset==0) {

            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0,0, 320, 300);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            else{
                self.bfView1.frame=CGRectMake(0,0, 320, 297);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            
            
           
        }
        if (offset==320) {

            if (IS_IPHONE_5_SCREEN) {
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.bfView2.frame=CGRectMake(320, 0, 320, 300);
                self.lt2.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.scroll addSubview:self.paint6];
            }
            else{
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                self.lt2.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.bfView2 addSubview:self.paint6];
            }
           
        }
        if (offset==640) {

            if (IS_IPHONE_5_SCREEN) {
                self.bfView3.frame=CGRectMake(640, 0, 320, 300);
                video3.view.center=CGPointMake(800, 160);
                video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt3.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.view bringSubviewToFront:self.lt3];
                self.page.currentPage=2;
                [self.scroll addSubview:self.paint7];
            }
            else{
                self.bfView3.frame=CGRectMake(640, 0, 320, 297);
                video3.view.center=CGPointMake(800, 160);
                video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt3.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.view bringSubviewToFront:self.lt3];
                self.page.currentPage=2;
                [self.scroll addSubview:self.paint7];
            }
           
        }
        if (offset==960) {

            if (IS_IPHONE_5_SCREEN) {
                self.bfView4.frame=CGRectMake(960, 0, 320, 300);
                video4.view.center=CGPointMake(1120, 160);
                video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt4.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView4];
                [self.scroll addSubview:video4.view];
                self.lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView4 addSubview:self.lt4];
                [self.view bringSubviewToFront:self.lt4];
                self.page.currentPage=3;
                [self.scroll addSubview:self.paint8];
            }
            else{
                self.bfView4.frame=CGRectMake(960, 0, 320, 297);
                video4.view.center=CGPointMake(1120, 160);
                video4.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt4.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView4];
                [self.scroll addSubview:video4.view];
                self.lt4.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView4 addSubview:self.lt4];
                [self.view bringSubviewToFront:self.lt4];
                self.page.currentPage=3;
                [self.scroll addSubview:self.paint8];
            }
            
        }
    }
    if (total==1) {
        if (IS_IPHONE_5_SCREEN) {
            self.scroll.contentSize=CGSizeMake(320, 320);
        }else{
            self.scroll.contentSize=CGSizeMake(320, 317);
            
        }
        if (offset==0) {
            
            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0,0, 320, 300);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            else{
                self.bfView1.frame=CGRectMake(0,0, 320, 297);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            
            
            
        }
        
    }
    if (total==2) {
        if (IS_IPHONE_5_SCREEN) {
            self.scroll.contentSize=CGSizeMake(640, 320);
        }else{
            self.scroll.contentSize=CGSizeMake(640, 317);
            
        }
        if (offset==0) {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0,0, 320, 300);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }else{
                self.bfView1.frame=CGRectMake(0, 0, 320, 297);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            
        }
        if (offset==320) {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView2.frame=CGRectMake(320,0, 320, 300);
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt2.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.scroll addSubview:self.paint6];
            }else{
                self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt2.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.scroll addSubview:self.paint6];
            }
           
        }
    }
    if (total==3) {
        if (IS_IPHONE_5_SCREEN) {
            self.scroll.contentSize=CGSizeMake(960, 320);
        }else{
            self.scroll.contentSize=CGSizeMake(960, 317);
            
        }
        if (offset==0) {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView1.frame=CGRectMake(0,0, 320, 300);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }else{
                self.bfView1.frame=CGRectMake(0, 0, 320, 297);
                video1.view.center=CGPointMake(160, 160);
                video1.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt1.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView1];
                [self.scroll addSubview:video1.view];
                self.lt1.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView1 addSubview:self.lt1];
                [self.view bringSubviewToFront:self.lt1];
                self.page.currentPage=0;
                [self.scroll addSubview:self.paint5];
            }
            
           
        }
        if (offset==320) {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView2.frame=CGRectMake(320,0, 320, 300);
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt2.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.scroll addSubview:self.paint6];
            }else{
                self.bfView2.frame=CGRectMake(320, 0, 320, 297);
                video2.view.center=CGPointMake(480, 160);
                video2.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt2.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView2];
                [self.scroll addSubview:video2.view];
                self.lt2.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView2 addSubview:self.lt2];
                [self.view bringSubviewToFront:self.lt2];
                self.page.currentPage=1;
                [self.scroll addSubview:self.paint6];
            }
           
        }
        if (offset==640) {
            if (IS_IPHONE_5_SCREEN) {
                self.bfView3.frame=CGRectMake(640,0, 320, 300);
                video3.view.center=CGPointMake(800, 160);
                video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt3.frame=CGRectMake(0, 295, 320, 25);
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.view bringSubviewToFront:self.lt3];
                self.page.currentPage=2;
                [self.scroll addSubview:self.paint7];
            }else{
                self.bfView3.frame=CGRectMake(640, 0, 320, 297);
                video3.view.center=CGPointMake(800, 160);
                video3.view.transform=CGAffineTransformMakeScale(2.05, 2.3);
                self.lt3.frame=CGRectMake(0, 293, 320, 25);
                [self.scroll addSubview:self.bfView3];
                [self.scroll addSubview:video3.view];
                self.lt3.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
                [self.bfView3 addSubview:self.lt3];
                [self.view bringSubviewToFront:self.lt3];
                self.page.currentPage=2;
                [self.scroll addSubview:self.paint7];
            }
            
        }
        
    }
   
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self.focalView removeFromSuperview];
//    [self.focusView removeFromSuperview];
//    [self.haloView removeFromSuperview];
//    [self.consoleView removeFromSuperview];
//    [_ruleView removeFromSuperview];
    [_definitionView removeFromSuperview];
    [self.rootc.rootView removeFromSuperview];
}
@end
