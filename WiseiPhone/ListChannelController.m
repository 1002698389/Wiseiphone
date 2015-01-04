//
//  ListChannelController.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-15.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "ListChannelController.h"
#import "yShi.h"
#import "XTController.h"
#import "Getrules.h"
#import "LinkListCell.h"
#import "SocketServer.h"
#import "BaojingController.h"
#import "YulanController.h"
extern NSString * bieming;
extern int isnetwork;
extern int hand;
@interface ListChannelController ()
{
    UITableView * listLink;
    NSMutableArray * links;
    NSString * _info;
    NSIndexPath * _indexpath;
    //MyNavigationBar *mnb;
    NSMutableArray * _linklist;
    LinkListCell * llc;
    linker * lk;
    NSIndexPath * myidxpth;
}
@end

@implementation ListChannelController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        links=[NSMutableArray arrayWithCapacity:1];
        self.isClick=NO;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{


    links=[[Getrules shareRules] listlinks];

    [listLink reloadData];
  
    [self.view addSubview:self.iview];
    [self.view bringSubviewToFront:self.iview];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self setSelected:NO];
    
}
- (void)dealloc{

    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    links=[NSMutableArray arrayWithCapacity:1];
    [self.navigationController setNavigationBarHidden:YES];
    self.isClick=YES;
   // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"设备管理" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    self.view.backgroundColor=[UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    hand=0;
    UIView * vv=[[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 40)];
    vv.backgroundColor=[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    [self.view addSubview:vv];
    UILabel * lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 120, 40)];
    lbl.text=@"当前服务器设备";
    lbl.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
    [self.view addSubview:lbl];
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"JKAaddcamera.png"] forState:UIControlStateNormal];
        button.frame=CGRectMake(280,10, 20, 20);
        [button addTarget:self action:@selector(createLine) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:button];
   listLink=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, 320, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    listLink.backgroundColor=[UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    listLink.delegate=self;
    listLink.dataSource=self;
    links=[[Getrules shareRules] listlinks];
    NSLog(@"links=%@",links);
    [self.view addSubview:listLink];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeallviews) name:@"logsuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveoffline) name:@"logfail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievelogon:) name:@"logsuccess" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveonline:) name:@"online" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadlink) name:@"linkrefresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addIview) name:@"ialert" object:nil];
}
- (void)presentviewnext{
    BaojingController * bo=[[BaojingController alloc]init];
    [self presentViewController:bo animated:YES completion:nil];
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadlink
{
    links=[[Getrules shareRules] listlinks];
    [listLink reloadData];

}
- (void)recievelogon:(NSNotification*)info
{
    links=[[Getrules shareRules] listlinks];
 
    [listLink reloadData];
    self.iview.image=[UIImage imageNamed:@"警报球1-2.png"];
}
- (void)receiveoffline
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];
    LinkListCell * cell=(LinkListCell*)[listLink cellForRowAtIndexPath:myidxpth];
    
    cell.lab6.text=@"未连接";
    
    [listLink reloadData];

   self.iview.image=[UIImage imageNamed:@"tiker_img_2 .png"];
}
- (void)createLine
{
    XTController * xtset=[[XTController alloc]init];
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromBottom";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    [self presentViewController:xtset animated:NO completion:nil];
   

}
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)remove:(NSNotification*)info
{
    BOOL isOk=[[[info userInfo]valueForKey:@"isc"] boolValue];
    if (isOk==YES) {
        [self setSelected:NO];
        self.isClick = YES;
    }
    
    
}

- (void)takemsg:(NSNotification*)info
{
    self.isClick=[[[info userInfo]valueForKey:@"ck"] boolValue];
    
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
//- (void)bbiClick:(UIButton*)btn
//{
//    if (btn.tag==1) {
//        CATransition *ca = [CATransition animation];
//        ca.delegate = self;
//        ca.type = @"cube";
//        ca.subtype = @"fromTop";
//        ca.timingFunction = UIViewAnimationCurveEaseInOut;
//        ca.duration = 0.3;
//        ca.startProgress = 0;
//        ca.endProgress = 1;
//        [self.view.window.layer addAnimation:ca forKey:nil];
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }
//    if (btn.tag==0) {
//       
//    }
//   
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return links.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    LinkListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[LinkListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    linker * lin=[links objectAtIndex:indexPath.row];
    UIImageView * img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"JKAiconCamera.png"]];
    img.frame=CGRectMake(4, 30, 30, 30);
    [cell.contentView addSubview:img];
    cell.vv.frame=CGRectMake(0, 0, 320, 90);
    cell.lab1.text=[NSString stringWithFormat:@"%@(%@)",lin.byname,lin.address];
    cell.lab2.text=[NSString stringWithFormat:@"通道%d状态",lin.channelnum];
    cell.lpkbtn.tag=1000+indexPath.row;
    cell.tag=10000+indexPath.row;
    if ([lin.isopen isEqualToString:@"1"]) {
        cell.lab6.text=@"已连接";
        [cell.lpkbtn setTitle:@"断开" forState:UIControlStateNormal];
        cell.lab6.textColor=[UIColor colorWithRed:0 green:0.61 blue:0.4 alpha:1];
    }else{
       
        cell.lab6.text=@"未连接";
        [cell.lpkbtn setTitle:@"连接" forState:UIControlStateNormal];
        cell.lab6.textColor=[UIColor redColor];
    }
     [cell.lpkbtn addTarget:self action:@selector(onlinelink:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//- (void)offlinelink:(UIButton*)btn{
//  
//   
//
//}
- (void)onlinelink:(UIButton*)btn{
    
    hand=1;
    NSLog(@"btn.tag=%d",(int)btn.tag);
    long i=btn.tag-1000;
    lk=[links objectAtIndex:i];
    NSLog(@"lk=%@",lk);
    bieming=lk.byname;
    NSString * address=lk.address;
    int port=[lk.port intValue];
    llc=(LinkListCell*)[listLink viewWithTag:10000+i];
    NSString * sockaddress=[SocketServer shareSocket].iaddress;
    NSLog(@"sockaddress=%@",lk.address);
    if (sockaddress.length==0) {
        NSLog(@"连接中。。。");
        [[SocketServer shareSocket]setupConnection:address port:port];
        [self addlinkalert];
       llc.lab6.text=@"连接中...";
        
    }else{
        //[SocketServer shareSocket].clicknot=1;
        //[SocketServer shareSocket].iaddress=nil;
        [SocketServer shareSocket].isinterest=@"no";
        [[SocketServer shareSocket] disConnect];
        [[Getrules shareRules] updatelinkall];
        links=[[Getrules shareRules] listlinks];
        
        [listLink reloadData];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"netclick" object:self];
    NSUserDefaults * userdefault=[NSUserDefaults standardUserDefaults];
    [userdefault setObject:address forKey:@"address"];
    [userdefault setObject:[NSNumber numberWithInt:8000] forKey:@"port"];
    [userdefault synchronize];


}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    myidxpth=indexPath;
//    lk=[links objectAtIndex:indexPath.row];
//    NSLog(@"lk=%@",lk);
//    NSString * address=lk.address;
//    int port=[lk.port intValue];
//    llc=(LinkListCell*)[tableView cellForRowAtIndexPath:indexPath];
//    NSString * sockaddress=[SocketServer shareSocket].iaddress;
//    NSLog(@"sockaddress=%@",lk.address);
//    if (sockaddress.length==0) {
//        [[SocketServer shareSocket]setupConnection:address port:port];
//        [self addlinkalert];
//        llc.lab6.text=@"连接中";
//        
//    }else{
//        //[SocketServer shareSocket].clicknot=1;
//        [SocketServer shareSocket].iaddress=nil;
//        [SocketServer shareSocket].isinterest=@"no";
//        [[SocketServer shareSocket] disConnect];
//        [[Getrules shareRules] updatelinkall];
//        links=[[Getrules shareRules] listlinks];
//        
//        [listLink reloadData];
//        
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"netclick" object:self];
//    NSUserDefaults * userdefault=[NSUserDefaults standardUserDefaults];
//    [userdefault setObject:address forKey:@"address"];
//    [userdefault setObject:[NSNumber numberWithInt:8000] forKey:@"port"];
//    [userdefault synchronize];

}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return @"删除";
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    linker * lker=[links objectAtIndex:indexPath.row];
    NSString * conet=[SocketServer shareSocket].iaddress;
    if ([conet isEqualToString:lker.address]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"正在连接不能删除" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        [[Getrules shareRules] deletelinker:lker.address];
        links=[[Getrules shareRules] listlinks];
        [listLink reloadData];
        
    }

}
- (UIActivityIndicatorView*)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        
        _activityIndicatorView.center=self.view.center;
        _activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return _activityIndicatorView;
    
}
- (UIView *)maskview{
    if (!_maskview) {
        _maskview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _maskview.backgroundColor=[UIColor blackColor];
        _maskview.alpha=0.5;
    }
    return _maskview;
}
- (void)addlinkalert{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.maskview];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    [self performSelector:@selector(removeallviews) withObject:self afterDelay:10];
    
}

- (void)removeallviews{

    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.maskview removeFromSuperview];
    LinkListCell * cell=(LinkListCell*)[listLink cellForRowAtIndexPath:myidxpth];
    
    cell.lab6.text=@"已连接";
    
    [listLink reloadData];
}
- (void)refreshcell
{
   

}
@end
