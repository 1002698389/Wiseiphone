//
//  XTController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-3.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "XTController.h"
#import "yShi.h"
#import "MyNavigationBar.h"
#import "XitongController.h"
#import "Getrules.h"
#import "linker.h"
#import "LabelText.h"
#import "SocketServer.h"
#import "ListChannelController.h"
#import "XitongController.h"
#define NUMBERS @"1234567890\n"
#define CHARACT @"abcdefghijklmnopqlstuvwxyzABCDEFGHIJKLMNOPQLSTUVWXYZ1234567890\n"
#define IPCHARACT @"1234567890.\n"
extern int curnet;
extern NSString * bieming;
extern int hand;
@interface XTController ()

@end

@implementation XTController
{
    int y;
    BOOL _isClick;
    NSMutableArray *_titleArray;
    NSMutableArray *_ImageArray;
    UIView *_tableView;
    float offset;
    MyNavigationBar *mnb;
    UITextField * txt1;
    UITextField * txt2;
    UITextField * txt3;
    UITextField * txt4;
    UITextField * txt5;
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
- (void)viewWillAppear:(BOOL)animated{

    linker * link=[[Getrules shareRules] querycurlink];
    NSMutableArray * linkinfo=[NSMutableArray arrayWithCapacity:1];
    NSLog(@"linkinfo.byname=%@",link.byname);
    NSLog(@"linkinfo.address=%@",link.address);
    if (link!=nil) {
        
        [linkinfo addObject:link.byname];
        [linkinfo addObject:link.address];
        [linkinfo addObject:link.port];
        [linkinfo addObject:link.username];
        [linkinfo addObject:link.password];
        [linkinfo addObject:[NSNumber numberWithInt:0]];
      
    }
    NSLog(@"linkinfo=%@",linkinfo);
    if (linkinfo.count>0) {

        for (int i=0; i<linkinfo.count-1; i++) {
        UITextField * txt=(UITextField*)[self.view viewWithTag:100*(i+1)];
            if (linkinfo.count>0) {
               NSString * string=(NSString*)[linkinfo objectAtIndex:i];
               
                txt.text=string;
                
            }
        }
    }
    
    


}
- (MyNavigationBar*)mnb{
    if (!_mnb) {
        _mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60)];
    }
    return _mnb;
    
}
- (void)viewWillDisappear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.84 green:0.85 blue:0.86 alpha:1.00f];
    _isClick = YES;
  // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"添加连接" andLeftButtonImageName:nil andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 40)];
    headLabel.text = @"  当前操作";
    headLabel.font = [UIFont systemFontOfSize:20];
    headLabel.backgroundColor=[UIColor colorWithRed:0.84 green:0.85 blue:0.86 alpha:1];
    [self.view addSubview:headLabel];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH,210)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
 
    NSArray *nameArray = @[@"别名",@"地址",@"端口",@"用户名",@"密码",@"通道数"];
    int count = 6;
    double m = 0;
    double w = 320;
    double h = 30;
    for(int i=0;i<count;i++)
    {
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, m+(h*i), w, h)];
        nameLabel.text = nameArray[i];
        nameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        CALayer *layer = [nameLabel layer];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.borderWidth  = 1;
        bottomBorder.borderColor = [UIColor darkGrayColor].CGColor;
        bottomBorder.frame = CGRectMake(-1, layer.frame.size.height-1, layer.frame.size.width, 1);
        [bottomBorder setBorderColor:[UIColor grayColor].CGColor];
        [layer addSublayer:bottomBorder];
        nameLabel.userInteractionEnabled = YES;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80,110+m+(h*i), 230, h)];
       // textField.placeholder = @"请输入......";
        //textField.backgroundColor=[UIColor yellowColor];
        textField.delegate = self;
        textField.tag=100*(i+1);
        [backView addSubview:nameLabel];
        [self.view addSubview:textField];
        
    }
    
    NSArray *stateArray = @[@"连接状态：",@"登陆状态："];
    NSArray *lineArray = @[@"未连接",@"未登录"];
    UIView *lineBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 80)];
    lineBackView.backgroundColor = [UIColor colorWithRed:0.78 green:0.79 blue:0.80 alpha:1];
    [self.view addSubview:lineBackView];
    for(int j=0;j<2;j++)
    {
        UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*j, 100, 40)];
        stateLabel.text =stateArray[j];
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 40*j, 100, 40)];
        lineLabel.textColor = [UIColor redColor];
        lineLabel.text = lineArray[j];
        lineLabel.tag=50+j;
        [lineBackView addSubview:lineLabel];
        [lineBackView addSubview:stateLabel];
    }
    
    
    UIButton * comfirm=[UIButton buttonWithType:UIButtonTypeSystem];
    [comfirm setTitle:@"确认" forState:UIControlStateNormal];
    comfirm.backgroundColor=[UIColor colorWithRed:0.7 green:0.71 blue:0.71 alpha:1];
    [comfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    comfirm.tintColor=[UIColor grayColor];
    comfirm.frame=CGRectMake(0, 400, 320, 40);
    [comfirm addTarget:self action:@selector(addLink) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:comfirm];
    [self.view addSubview:self.mnb];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ssss) name:@"logsuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bbbb) name:@"logfail" object:nil];
}

- (void)addLink
{
    NSLog(@"网络接口连接");
   
    hand=1;
    linker * linkinfo=[[linker alloc]init];
    txt1=(UITextField*)[self.view viewWithTag:100];
    txt2=(UITextField*)[self.view viewWithTag:200];
    txt3=(UITextField*)[self.view viewWithTag:300];
    txt4=(UITextField*)[self.view viewWithTag:400];
    txt5=(UITextField*)[self.view viewWithTag:500];
  //  UITextField * txt6=(UITextField*)[self.view viewWithTag:600];
    NSString *regexip = @"((([1-9]?|1\\d)\\d|2([0-4]\\d|5[0-5]))\\.){3}(([1-9]?|1\\d)\\d|2([0-4]\\d|5[0-5]))";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexip];
    
    BOOL isMatch=[pred evaluateWithObject:txt2.text];
 

        int port1=[txt3.text intValue];

    if (txt1.text.length==0) {
        linkinfo.byname=@"我的服务器";
    }
    if (!isMatch) {
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"ip格式不对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
     }
    if (port1<0||port1>65535) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"端口不对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (txt4.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"用户名为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (txt5.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
            
    
    
        NSString * isconect=[SocketServer shareSocket].isConnect;
        if ([isconect isEqualToString:@"成功"]) {
            [[SocketServer shareSocket] disConnect];
            
        }
    
       [[SocketServer shareSocket] setupConnection:txt2.text port:[txt3.text intValue]];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"netclick" object:self];
    UILabel * lab=(UILabel*)[self.view viewWithTag:50];
    lab.text=@"连接中...";

  
     [[NSNotificationCenter defaultCenter]postNotificationName:@"linkrefresh" object:self];
}
- (void)ssss{
    
    
    UILabel * lab=(UILabel*)[self.view viewWithTag:50];
    lab.text=@"连接成功";
    lab.textColor=[UIColor greenColor];
    UILabel * lab2=(UILabel*)[self.view viewWithTag:51];
    lab2.text=@"已登录";
    lab2.textColor=[UIColor greenColor];
    NSMutableArray * ports=[NSMutableArray arrayWithCapacity:1];
    NSMutableArray * addresss=[NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray * linkers=[[Getrules shareRules] listlinks];
    
    for (int i=0; i<linkers.count; i++) {
        linker * lin=[linkers objectAtIndex:i];
        [ports addObject:lin.port];
        [addresss addObject:lin.address];
        
    }
    UITextField * byname=(UITextField*)[self.view viewWithTag:100];
    UITextField * address=(UITextField*)[self.view viewWithTag:200];
    UITextField * port=(UITextField*)[self.view viewWithTag:300];
    UITextField * username=(UITextField*)[self.view viewWithTag:400];
    UITextField * password=(UITextField*)[self.view viewWithTag:500];
    NSLog(@"ports=%@",ports);
    NSLog(@"addressarra=%@",addresss);
    NSLog(@"address=%@",address.text);
    NSLog(@"port=%@",port.text);
    if ([addresss containsObject:address.text]) {
        linker * link=[[linker alloc]initWithLinkid:0 byname:byname.text address:address.text port:port.text type:@"网络连接" username:username.text password:password.text channelnum:0 isopen:@"1"];
        NSLog(@"byname=%@",byname.text);
        NSLog(@"username=%@",username.text);
        bieming=byname.text;
        [[Getrules shareRules] deletecurlink];
         [[Getrules shareRules] addcurlink:link];
        [[Getrules shareRules] updatelinkfrom:link];
        [[Getrules shareRules] updatelinkall];
        [[Getrules shareRules] updatelink:address.text];
    }else{
        linker * link=[[linker alloc]init];
        link.byname=byname.text;
        link.address=address.text;
        link.port=port.text;
        link.username=username.text;
        link.password=password.text;
        link.type=@"网络接口";
        link.isopen=@"1";
        [[Getrules shareRules] deletecurlink];
        [[Getrules shareRules] addlink:link];
        [[Getrules shareRules] addcurlink:link];
        [[Getrules shareRules] updatelinkall];
        [[Getrules shareRules] updatelink:link.address];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
   
    
      //  [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)bbbb{
 
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"连接失败不能保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    UILabel * lab=(UILabel*)[self.view viewWithTag:50];
    lab.text=@"未连接";
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet * cs=nil;
    NSString * filtered=nil;
    if (textField.tag==100) {
        cs=[[NSCharacterSet characterSetWithCharactersInString:CHARACT]invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    }
    if (textField.tag==200) {
        cs=[[NSCharacterSet characterSetWithCharactersInString:IPCHARACT]invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    }
    if (textField.tag==300) {
        cs=[[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        
    }
    if (textField.tag==400) {
        cs=[[NSCharacterSet characterSetWithCharactersInString:CHARACT]invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    }
    if (textField.tag==500) {
        cs=[[NSCharacterSet characterSetWithCharactersInString:CHARACT]invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    }
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==200||textField.tag==0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    if (textField.tag>=300&&self.view.frame.origin.y>-150) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame=CGRectMake(0, self.view.frame.origin.y-50, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
       
    }
    
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    }];
    
    return YES;
}
#pragma mark - UIButton方法
- (void)bbiClick:(UIButton *)btn
{
    ListChannelController * xit=[[ListChannelController alloc]init];
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromTop";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    [self presentViewController:xit animated:NO completion:nil];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
