//
//  XitongController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "XitongController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "MyLineCell.h"
#import "XTController.h"
#import "ListChannelController.h"
#import "BaojingController.h"
#import "YulanController.h"
extern int isnetwork;
@interface XitongController ()

@end

@implementation XitongController
{
    int y;
    BOOL _isClick;
    NSMutableArray *_titleArray;
    NSMutableArray *_ImageArray;
    UITapGestureRecognizer *tap5;
    UIView * viewLay5;
    //MyNavigationBar *mnb;
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
    [self.mnb createNavigationBarWithImage:@"系统设置" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"我的收藏",@"本地配置",@"使用帮助",@"关于", nil];
    _ImageArray = [[NSMutableArray alloc]initWithObjects:@"JKAiconWDSC.png",@"JKAiconMMSZ.png",@"JKAiconSYBZ.png",@"JKAiconGY.png", nil];
    
    UITableView *_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+y, SCREEN_WIDTH, SCREEN_HEIGHT+y) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addIview) name:@"ialert" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onlinecolor) name:@"online" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changefail) name:@"logfail" object:nil];
}
- (void)presentviewnext{
    BaojingController * bo=[[BaojingController alloc]init];
    [self presentViewController:bo animated:YES completion:nil];
    
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
- (void)onlinecolor{
    
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
    
}
- (void)addIview{
    


    [self alertcolor];
    
}
- (void)alertcolor
{
    
    
    self.iview.image=[UIImage imageNamed:@"警报球2-2.png"];
    [self performSelector:@selector(changeimage) withObject:self afterDelay:0.2];
    
}
- (void)changefail{
    
    self.iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];
    
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
- (void)remove:(NSNotification*)info
{
    BOOL isOk=[[[info userInfo]valueForKey:@"isc"] boolValue];
    if (isOk==YES) {
        [self setSelected:NO];
        [self.rootc.rootView removeFromSuperview];
        _isClick = YES;
    }
    
    NSLog(@"移除这个东丁");
}
- (void)baojing{

    BaojingController * baojin=[[BaojingController alloc]init];
    
    [self presentViewController:baojin animated:NO completion:nil];

}
- (void)takemsg:(NSNotification*)info
{
    _isClick=[[[info userInfo]valueForKey:@"ck"]boolValue];

}
#pragma mark - UITableView方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    MyLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyLineCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.imageIcon setImage:[UIImage imageNamed:[_ImageArray objectAtIndex:indexPath.row]]];
    cell.titleName.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
      
    }
    if (indexPath.row == 1)
    {
//        XTController *xtvc = [[XTController alloc]init];
//        [self.navigationController pushViewController:xtvc animated:YES];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - UIButton 方法
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)removeroot
{
    [viewLay5 removeFromSuperview];
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
       // [self dismissViewControllerAnimated:NO completion:nil];
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
