//
//  PlayMovieController.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "PlayMovieController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "SocketServer.h"
#import "saveIndex.h"
#import "BaojingController.h"
#import "ZhinengController.h"
@interface PlayMovieController ()

@end

@implementation PlayMovieController

{
    int y;
    Draw *_draw;
    Newdraw * _newdraw;
    UIView * _ruleView;
    NSMutableArray *_leiXing;
    NSMutableArray *checkBoxs;
    NSMutableArray *_fangan;
    UILabel *_lab;
    NSString *_typename;
    NSMutableArray *imG;
    NSMutableArray *displayImgs;
    NSMutableArray *faCode;
    NSString *pointstring;
    UILabel *_info;
    BOOL _isSelect;
    int _checktag;
    UILabel *tint;
    MyNavigationBar *mnb;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.ruleview1 removeFromSuperview];
    [self.ruleview2 removeFromSuperview];
    [self.viewbar removeFromSuperview];
    [_draw removeFromSuperview];
    [_info removeFromSuperview];
    [_newdraw removeFromSuperview];
    [self.player deleteitself];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
- (void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString * path=self.playrule.path;
        self.player=[MovieViewController movieViewControllerWithContentPath:path parameters:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.isUpdate isEqualToString:@"movie"]) {
                
                if (IS_IPHONE_5_SCREEN) {
                    self.player.view.frame=CGRectMake(0, 100, 320, 300);
                    [self.view addSubview:self.player.view];
                    _newdraw=[[Newdraw alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
                    [self.view addSubview:_newdraw];
                    [self.view setNeedsDisplay];
                    [self drawAuto];
                    UIView * viw=[[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, 320, 50)];
                    viw.backgroundColor=[UIColor whiteColor];
                    UIButton * usebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [usebtn setTitle:@"启用" forState:UIControlStateNormal];
                    [usebtn addTarget:self action:@selector(changeuse:) forControlEvents:UIControlEventTouchUpInside];
                    usebtn.tag=8000;
                    usebtn.frame=CGRectMake(100, 5, 60, 40);
                    [viw addSubview:usebtn];
                    UIButton * nusebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [nusebtn setTitle:@"禁用" forState:UIControlStateNormal];
                    [nusebtn addTarget:self action:@selector(changeuse:) forControlEvents:UIControlEventTouchUpInside];
                    nusebtn.tag=9000;
                    nusebtn.frame=CGRectMake(180, 5, 60, 40);
                    [viw addSubview:nusebtn];
                    [self.view addSubview:viw];
                }else{
                    self.player.view.frame=CGRectMake(0, 60, 320, 290);
                    [self.view addSubview:self.player.view];
                    _newdraw=[[Newdraw alloc]initWithFrame:CGRectMake(0, 60, 320, 290)];
                    [self.view addSubview:_newdraw];
                    [self.view setNeedsDisplay];
                    [self drawAuto];
                }
                
            }
            if ([self.isUpdate isEqualToString:@"update"]) {
                [self tinters];
                NSString * path=self.playrule.path;
                self.player=[MovieViewController movieViewControllerWithContentPath:path parameters:nil];
                if (IS_IPHONE_5_SCREEN) {
                    self.player.view.frame=CGRectMake(0, 100, 320, 300);
                    [self.view addSubview:self.player.view];
                    _newdraw=[[Newdraw alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
                    [self.view addSubview:_newdraw];
                    [self.view setNeedsDisplay];
                    [self drawAuto];
                }else{
                    self.player.view.frame=CGRectMake(0, 60, 320, 290);
                    [self.view addSubview:self.player.view];
                    _newdraw=[[Newdraw alloc]initWithFrame:CGRectMake(0, 60, 320, 290)];
                    [self.view addSubview:_newdraw];
                    [self.view setNeedsDisplay];
                    [self drawAuto];
                }
                [self editstatus];
            }
        });
    });


}
- (void)changeuse:(UIButton*)btn
{
    Rules * rl=self.playrule;
    if (btn.tag==8000) {
        
 //       [[Getrules shareRules]updateused:rl.Rid isused:1];
        [[SocketServer shareSocket] enablerule:rl.channlid ruleid:rl.ruleid];
    }
    if (btn.tag==9000) {
//        [[Getrules shareRules]updateused:rl.Rid isused:0];
        [[SocketServer shareSocket] disablerule:rl.channlid ruleid:rl.ruleid];
    }
   
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.player deleteitself];
    
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
    _isSelect=YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
   // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"监控设置" andLeftButtonImageName:@"" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
//    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSelect:)];
//    tap.numberOfTapsRequired=1;
//    [self.view addGestureRecognizer:tap];
    _lab=[[UILabel alloc]initWithFrame:CGRectMake(14, 8, 120, 30)];
    _lab.textAlignment=NSTextAlignmentLeft;
    _lab.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    imG=[NSMutableArray arrayWithCapacity:1];
    displayImgs=[NSMutableArray arrayWithCapacity:1];
    faCode=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<4; i++) {
        UIImageView * ivg=[[UIImageView alloc]initWithFrame:CGRectMake(10+35*i, 40, 30, 30)];
        [displayImgs addObject:ivg];
    }
    _leiXing=[NSMutableArray arrayWithCapacity:1];
    _fangan=[NSMutableArray arrayWithCapacity:1];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pointstr:) name:@"mongline" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Recpoint:) name:@"orthogon" object:nil];
}
- (void)baojing{
 
    BaojingController * baojin=[[BaojingController alloc]init];
    
    [self presentViewController:baojin animated:NO completion:nil];

}
- (UIView*)backGround
{
    if (!_backGround) {
        _backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGround.backgroundColor = [UIColor colorWithRed:12.0/255.0f green:13.0/255.0f blue:15.0/255.0f alpha:0.7f];
    }
    
    
    return _backGround;
}
- (void)cancelSelect:(UITapGestureRecognizer*)tapz
{
    [[self backGround] removeFromSuperview];
    [self.ruleview1 removeFromSuperview];
    [self.ruleview2 removeFromSuperview];

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
- (void)drawAuto
{
  
    _newdraw.drawName=self.playrule.rulename;
    NSArray * arr=[self.playrule.points componentsSeparatedByString:@","];
    CGPoint one;
    one.x=[[arr objectAtIndex:0] floatValue];
    one.y=[[arr objectAtIndex:1] floatValue];
    CGPoint sec;
    sec.x=[[arr objectAtIndex:2] floatValue];
    sec.y=[[arr objectAtIndex:3] floatValue];
    _newdraw.first=one;
    _newdraw.end=sec;
}
- (void)editstatus
{
    
    if (IS_IPHONE_5_SCREEN) {
        _ruleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
    }
    else{
        _ruleView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
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
}
- (void)playstatus:(UIButton*)btn
{
    btn.selected=!btn.selected;
    if (_isSelect==YES) {
        
        _isSelect=NO;
        [self.player pause];
    }
    if (_isSelect==NO) {
        
        _isSelect=YES;
        [self.player play];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)bbiClick:(UIButton*)btn
{
    if (btn.tag==1) {
        ZhinengController * zhin=[[ZhinengController alloc]init];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        
        [self presentViewController:zhin animated:NO completion:nil];
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
        QCheckBox * qbtn1=(QCheckBox*)[self.ruleview1 viewWithTag:50];
        QCheckBox * qbtn2=(QCheckBox*)[self.ruleview1 viewWithTag:51];
        QCheckBox * qbtn3=(QCheckBox*)[self.ruleview1 viewWithTag:52];
        QCheckBox * qbtn4=(QCheckBox*)[self.ruleview1 viewWithTag:53];
        if ([self.playrule.rulename isEqualToString:@"警戒线"]) {
            qbtn1.checked=YES;
            qbtn2.checked=NO;
            qbtn3.checked=NO;
            qbtn4.checked=NO;
        }
        if ([self.playrule.rulename isEqualToString:@"进入指定区域"]) {
            qbtn1.checked=NO;
            qbtn2.checked=YES;
            qbtn3.checked=NO;
            qbtn4.checked=NO;
        }
        if ([self.playrule.rulename isEqualToString:@"区域内物体失窃"]) {
            qbtn1.checked=NO;
            qbtn2.checked=NO;
            qbtn3.checked=YES;
            qbtn4.checked=NO;
        }
        if ([self.playrule.rulename isEqualToString:@"运动物体计数"]) {
            qbtn1.checked=NO;
            qbtn2.checked=NO;
            qbtn3.checked=NO;
            qbtn4.checked=YES;
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
            checkBox.tag=60+i;
            checkBox.frame = CGRectMake(0, 45+46*i, 230, 45);
            checkBox.backgroundColor = [UIColor whiteColor];
            [checkBox setTitle:[_fangan objectAtIndex:i] forState:UIControlStateNormal];
            [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [checkBox.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [checkBox addTarget:self action:@selector(selImage:) forControlEvents:UIControlEventTouchUpInside];
            [_ruleview2 addSubview:checkBox];
            [checkBox setChecked:NO];
            
        }
       
        NSArray * preceptarr=[self.playrule.precept componentsSeparatedByString:@","];
        NSMutableArray * precepta=[[NSMutableArray alloc]initWithArray:preceptarr];
        [precepta removeLastObject];
        NSLog(@"preceptarr=%@",precepta);
        [imG removeAllObjects];
        for (int t=0; t<4; t++) {
             QCheckBox * qtbn=(QCheckBox*)[self.ruleview2 viewWithTag:60+t];
            qtbn.checked=NO;
        }
        for (int k=0; k<precepta.count; k++) {
            int tag=[[preceptarr objectAtIndex:k] intValue];
            QCheckBox * qtbn=(QCheckBox*)[self.ruleview2 viewWithTag:60+tag];
            qtbn.checked=YES;
            [faCode addObject:[NSNumber numberWithInt:tag]];
            [checkBoxs addObject:qtbn];
            if (tag==0) {
                UIImage * img=[UIImage imageNamed:@"JKAbottomBJ.png"];
                [imG addObject:img];
            }
            if (tag==1) {
                UIImage * img=[UIImage imageNamed:@"JKAbottomJP.png"];
                [imG addObject:img];
            }
            if (tag==2) {
                UIImage * img=[UIImage imageNamed:@"JKAbottomLX.png"];
                [imG addObject:img];
            }
            if (tag==3) {
                UIImage * img=[UIImage imageNamed:@"JKAbottomSYon.png"];
                [imG addObject:img];
            }
        }
        NSLog(@"checkboxs个数=%lu",checkBoxs.count);
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
    NSLog(@"执行了这一步");
    [self.ruleview1 removeFromSuperview];
    self.ruleview1=nil;
    [self.view addSubview:self.ruleview2];
    [self.view bringSubviewToFront:self.ruleview2];
    _lab.text=_typename;
    if (IS_IPHONE_5_SCREEN) {
        [_ruleView addSubview:_lab];
    }
    
}
- (void)selectQcheck:(QCheckBox*)btn
{
    _checktag=(int)btn.tag;
    
    [_newdraw removeFromSuperview];
    if (IS_IPHONE_5_SCREEN) {
        _draw = [[Draw alloc]initWithFrame:CGRectMake(0, 150, 320, 320)];
    }else{
        
        _draw=[[Draw alloc]initWithFrame:CGRectMake(0, 60, 320, 290)];
        
    }
    
    _draw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_draw];
    [self.view bringSubviewToFront:self.ruleview1];
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
//    NSLog(@"checkboxs=%lu",checkBoxs.count);
//    NSLog(@"img=%lu",imG.count);
//    if (IS_IPHONE_5_SCREEN) {
//        for (int j=0; j<checkBoxs.count; j++) {
//            QCheckBox * checked=(QCheckBox*)[checkBoxs objectAtIndex:j];
//            checked.checked=NO;
//        }
//        for (int k=0; k<displayImgs.count; k++) {
//            UIImageView * oldview=(UIImageView*)[displayImgs objectAtIndex:k];
//            [oldview removeFromSuperview];
//        }
//        for (int i=0; i<checkBoxs.count; i++) {
//            NSLog(@"img.count=%lu",(unsigned long)imG.count);
//            NSLog(@"display.img=%lu",displayImgs.count);
////            UIImageView * igv=(UIImageView*)[displayImgs objectAtIndex:i];
////            UIImage * img=(UIImage *)[imG objectAtIndex:i];
////            igv.image=img;
////            [_ruleView addSubview:igv];
//            
//        }
//        
//    }
    [self.backGround removeFromSuperview];
    self.backGround = nil;
    [checkBoxs removeAllObjects];
    [imG removeAllObjects];
    [self.ruleview2 removeFromSuperview];
    [self drawClick];
    [self tinters];
    
}
- (void)tinters
{ if(IS_IPHONE_5_SCREEN){
    tint=[[UILabel alloc]initWithFrame:CGRectMake(110, 70, 320, 30)];
    }
  else{
    tint=[[UILabel alloc]initWithFrame:CGRectMake(110, 360, 320, 30)];
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
    
    if (_checktag == 50 || _checktag == 58|| _checktag == 53)
    {
        
        _draw.type = 1;
        
        
    }
    
    if (_checktag == 52 ||_checktag==51)
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
- (UIView*)viewbar
{
    if (!_viewbar) {
        _viewbar=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-54, 320, 54)];
        _viewbar.backgroundColor=[UIColor whiteColor];
    }
    return _viewbar;

}
- (void)btnClick2:(UIButton*)btn
{
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

    if (btn.tag==33) {
        
        [[self backGround] removeFromSuperview];
       // NSString *rulename=_typename;
        NSLog(@"typename=%@",_typename);
//         [faCode removeAllObjects];
//        for (int f=0;f<4; f++) {
//            QCheckBox * qcb=(QCheckBox*)[self.ruleview2 viewWithTag:60+f];
//            NSLog(@"qcb.checked=%d",qcb.checked);
//            if (qcb.checked==YES) {
//                [faCode addObject:[NSNumber numberWithInt:f]];
//            }
//        }
        NSLog(@"facode=%@",faCode);
        NSMutableString *fazh=[NSMutableString stringWithCapacity:1];
        for (int n=0; n<faCode.count; n++) {
            NSString * str=[NSString stringWithFormat:@"%@,",[faCode objectAtIndex:n]];
            [fazh appendString:str];
            
        }
       
       
        Rules * rul=[[Rules alloc]init];
        rul.Rid=self.playrule.Rid;
        rul.rulename=_lab.text;
        rul.precept=fazh;
        rul.points=pointstring;
        rul.descript=_lab.text;
        NSLog(@"myid=%d",rul.Rid);
        NSLog(@"rulename=%@",rul.rulename);
        NSLog(@"point=%@",rul.points);
        NSLog(@"precept=%@",rul.precept);
        int indexid=self.playrule.channlid;
        int rulid=self.playrule.ruleid;
        
        if (rul.precept.length==0) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"此次修改未选择方案" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            rul.precept=self.playrule.precept;
            return;
        }
        if (rul.points.length==0) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"此次修改未划线" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            rul.points=self.playrule.points;
            return;
        }
        if (rul.rulename.length==0) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"此次修改未选择规则" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
            rul.rulename=self.playrule.rulename;
            return;
        }
        if (rul.descript.length==0) {
            rul.descript=self.playrule.descript;
        }
        [[Getrules shareRules]updateRules:rul];
        [saveIndex shareindex].sendRule=rul;
        [[SocketServer shareSocket] deleterule:indexid ruleid:rulid];
        [[SocketServer shareSocket] sendRule];
        if (rul.precept.length!=0&&rul.rulename.length!=0&&rul.points.length!=0) {
            [UIView animateWithDuration:0.2 animations:^{
                _info=[[UILabel alloc]initWithFrame:CGRectMake(90, 200, 160, 50)];
                _info.backgroundColor=[UIColor whiteColor];
                _info.textAlignment=NSTextAlignmentCenter;
                _info.layer.cornerRadius=5;
                _info.layer.masksToBounds=YES;
                _info.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
                _info.text=@"修改成功";
                [self.view addSubview:_info];
            }];
        }
        [self performSelector:@selector(removeinfo) withObject:self afterDelay:1];
        [tint removeFromSuperview];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }

}
- (void)removeinfo
{
    [_info removeFromSuperview];

}
- (void)drawClick:(UIButton *)btn
{
    
    [_ruleView addSubview:_lab];
    if (btn.tag == 50 || btn.tag == 58)
    {
        [self.ruleview1 removeFromSuperview];
        _draw.type = 1;
        if (btn.tag==50) {
            if (IS_IPHONE_5_SCREEN) {
                _lab.text=nil;
                _lab.text=btn.titleLabel.text;
                _typename=btn.titleLabel.text;
            }
            _typename=btn.titleLabel.text;
            
            
        }
        
    }
    if (btn.tag == 51)
    {
        [self.ruleview1 removeFromSuperview];
        _draw.type = 2;
        if (IS_IPHONE_5_SCREEN) {
            _lab.text=nil;
            _lab.text=btn.titleLabel.text;
            _typename=btn.titleLabel.text;
        }
        _typename=btn.titleLabel.text;
    }
    if (btn.tag == 52 || btn.tag == 53)
    {
        
        if (IS_IPHONE_5_SCREEN) {
            _lab.text=nil;
            _lab.text=btn.titleLabel.text;
            _typename=btn.titleLabel.text;
        }
        _typename=btn.titleLabel.text;
        [self.ruleview1 removeFromSuperview];
        _draw.type = 3;
    }
    if (btn.tag == 54 || btn.tag == 55 || btn.tag == 56 || btn.tag == 58)
    {
        [self.ruleview1 removeFromSuperview];
        _draw.type = 4;
    }
    
    if (btn.tag == 60 || btn.tag == 61 || btn.tag == 62 || btn.tag == 63)
    {
        //        btn.selected = !btn.selected;
        //        _view2.hidden = YES;
        //        NSLog(@"%d",btn.tag);
    }
    if (btn.tag == 64)
    {
        
        
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
        [checkBoxs removeAllObjects];
        [imG removeAllObjects];
        [self.ruleview2 removeFromSuperview];
        
    }
    
}

- (void)selImage:(QCheckBox*)cbn
{
   NSLog(@"checkbox选中状态=%d",cbn.checked);
    if ([cbn.titleLabel.text isEqualToString:@"实时日志"]&&cbn.checked==YES) {
        UIImage * img=[UIImage imageNamed:@"JKAbottomBJ.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        NSNumber * num=[NSNumber numberWithInt:0];
        [faCode addObject:num];
        NSLog(@"执行添加第一个方案");
         [checkBoxs addObject:cbn];
    }
    if ([cbn.titleLabel.text isEqualToString:@"实时日志"]&&cbn.checked==NO) {
        UIImage * img=[UIImage imageNamed:@"JKAbottomBJ.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG removeObject:img];
        }
        [checkBoxs removeObject:cbn];
        NSNumber * num=[NSNumber numberWithInt:0];
        [faCode removeObject:num];
        NSLog(@"执行删除第一个方案");
    }
    if ([cbn.titleLabel.text isEqualToString:@"截图"]&&cbn.checked==YES) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomJP.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        [checkBoxs addObject:cbn];
        NSNumber * num=[NSNumber numberWithInt:1];
        [faCode addObject:num];
        
        NSLog(@"执行添加第二个方案");
    }
    if ([cbn.titleLabel.text isEqualToString:@"截图"]&&cbn.checked==NO) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomJP.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG removeObject:img];
        }
        [checkBoxs removeObject:cbn];
           NSNumber * num=[NSNumber numberWithInt:1];
        [faCode removeObject:num];
        NSLog(@"执行删除第二个方案");
    }
    
    if ([cbn.titleLabel.text isEqualToString:@"触发报警录像"]&&cbn.checked==YES) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomLX.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        [checkBoxs addObject:cbn];
           NSNumber * num=[NSNumber numberWithInt:2];
            [faCode addObject:num];
        NSLog(@"执行添加第三个方案");
    }
    if ([cbn.titleLabel.text isEqualToString:@"触发报警录像"]&&cbn.checked==NO) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomLX.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG removeObject:img];
        }
        [checkBoxs removeObject:cbn];
           NSNumber * num=[NSNumber numberWithInt:2];
        [faCode removeObject:num];
       NSLog(@"执行删除第三个方案");
    }
    if ([cbn.titleLabel.text isEqualToString:@"触发警铃"]&&cbn.checked==YES) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomSYon.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG addObject:img];
        }
        [checkBoxs addObject:cbn];
           NSNumber * num=[NSNumber numberWithInt:3];
            [faCode addObject:num];
        NSLog(@"执行添加第四个方案");
    }
    if ([cbn.titleLabel.text isEqualToString:@"触发警铃"]&&cbn.checked==NO) {
        
        UIImage * img=[UIImage imageNamed:@"JKAbottomSYon.png"];
        if (IS_IPHONE_5_SCREEN) {
            [imG removeObject:img];
        }
        [checkBoxs removeObject:cbn];
           NSNumber * num=[NSNumber numberWithInt:3];
        [faCode removeObject:num];
        NSLog(@"执行删除第四个方案");
    }
   
}



@end
