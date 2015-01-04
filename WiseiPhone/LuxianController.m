//
//  LuxianController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "LuxianController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "MyLineCell.h"
#import "LXController.h"

@interface LuxianController ()

@end

@implementation LuxianController
{
    int y;
    BOOL _isClick;
    UIButton *_startbtn;
    UIButton *_endbtn;
   
    NSMutableArray *_titleArray;
    UITableView *_tableView;
    UIDatePicker *_datePick1;
    UIDatePicker *_datePick2;
    NSMutableArray *_pathArray;
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
    [self.view addSubview:self.rootc.rootView];
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    _isClick = YES;
    //mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"通道列表" andLeftButtonImageName:@"JKAtopMenu.png"  andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    
    
    NSString *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"起：YYYY-MM-dd hh:mm"];
    date = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow: -(24 * 60 * 60)]];
    
    _startbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startbtn.frame = CGRectMake(0, 40+y, SCREEN_WIDTH, 40);
    _startbtn.backgroundColor = [UIColor colorWithRed:226.0/255 green:229.0/255 blue:229.0/255 alpha:1];
    [_startbtn setTitle:date forState:UIControlStateNormal];
    [_startbtn setTitleColor:[UIColor colorWithRed:0.00f green:0.45f blue:0.77f alpha:1.00f] forState:UIControlStateNormal];
    _startbtn.tag = 10;
    [_startbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startbtn];
    
    NSString *date2;
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"止：YYYY-MM-dd hh:mm"];
    date2 = [formatter2 stringFromDate:[NSDate date]];
    
    _endbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _endbtn.frame = CGRectMake(0, 80+y, SCREEN_WIDTH, 40);
    _endbtn.backgroundColor = [UIColor colorWithRed:226.0/255 green:229.0/255 blue:229.0/255 alpha:1];
    [_endbtn setTitle:date2 forState:UIControlStateNormal];
    [_endbtn setTitleColor:[UIColor colorWithRed:0.00f green:0.45f blue:0.77f alpha:1.00f] forState:UIControlStateNormal];
    _endbtn.tag = 11;
    [_endbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endbtn];
    
    
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"服务器01",@"服务器02", nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120+y, SCREEN_WIDTH, SCREEN_HEIGHT-100+y) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    // 数据源
    _titleArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i<2; i++)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        NSMutableArray *contents = [[NSMutableArray alloc] initWithCapacity:1];
        for (int j = 0; j<3; j++)
        {
            [contents addObject:[NSString stringWithFormat:@"摄像头 %d",j+1]];
        }
        [dict setValue:[NSString stringWithFormat:@"%d组",i+1] forKey:@"name"];
        // section 状态 ：YES打开 NO关闭
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"state"];
        [dict setValue:contents forKey:@"contents"];
        [_titleArray addObject:dict];
    }
    
    _pathArray = [[NSMutableArray alloc]initWithObjects:@"rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?",@"rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?",@"2",@"3", nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-60+y, SCREEN_WIDTH, 40);
    btn.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [btn setTitle:@"开始回放" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.24f green:0.55f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(playBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
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
    _isClick=[[[info userInfo] valueForKey:@"ck"] boolValue];

}
#pragma mark - UITableView方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    MyLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyLineCell" owner:self options:nil]lastObject];
      
        cell.btn.frame = CGRectMake(208, 11, 22, 22);
//        if (cell.selected) {
//             [cell.btn setImage:[UIImage imageNamed:@"JKAselectOn.png"]];
//        }else{
        cell.btn.image=[UIImage imageNamed:@"JKAselectOff.png"];
       // [cell.btn setImage:[UIImage imageNamed:@"JKAselectOff.png"]];
        
       // }
        
       
     
        [cell addSubview:cell.btn];
    }
    [cell.imageIcon setImage:[UIImage imageNamed:@"JKAiconCamera.png"]];
    cell.titleName.text = [[[_titleArray objectAtIndex:indexPath.section] objectForKey:@"contents"] objectAtIndex:indexPath.row];
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyLineCell * mycell=(MyLineCell*)[tableView cellForRowAtIndexPath:indexPath];
   // mycell.btn.enabled=NO;
    if (mycell.selected==YES) {
        
        [mycell.btn setImage:[UIImage imageNamed:@"JKAselectOff.png"]];
        mycell.selected=NO;
        
        
        
    }else{
      //  mycell.btn.enabled=YES;
        [mycell.btn setImage:[UIImage imageNamed:@"JKAselectOn.png"]];
        mycell.selected=YES;
        NSString *path = _pathArray[indexPath.section];
        LXController *lu = [LXController movieViewControllerWithContentPath:path parameters:nil];
        [self presentViewController:lu animated:YES completion:nil];
        
    }
  
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[_titleArray objectAtIndex:section] objectForKey:@"state"] boolValue])
    {
        return [[[_titleArray objectAtIndex:section] objectForKey:@"contents"] count];
    } else
    {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_titleArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    button.userInteractionEnabled = YES;
    button.tag = section;
    [button addTarget:self action:@selector(改变:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 70, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor purpleColor];
    title.text = [[_titleArray objectAtIndex:section] objectForKey:@"name"];
    [button addSubview:title];
    return button;
}


- (void)改变:(UIButton *)btn
{
    int section = (NSInteger)btn.tag;
    if ([[[_titleArray objectAtIndex:section] objectForKey:@"state"] boolValue])
    {
        [[_titleArray objectAtIndex:section] setValue:[NSNumber numberWithBool:NO] forKey:@"state"];
    } else {
        [[_titleArray objectAtIndex:section] setValue:[NSNumber numberWithBool:YES] forKey:@"state"];
    }
    // 刷新指定组号的cell
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - UIButton方法
- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 10)
    {
        _datePick2.hidden = YES;
        if (btn.selected)
        {
            _datePick1 = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80+y, SCREEN_WIDTH, 218)];
            _datePick1.datePickerMode = UIDatePickerModeDateAndTime;
            _datePick1.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
            _datePick1.tag = 1;
            [_datePick1 addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:_datePick1];
        }
//        else if (_datePick2.hidden == NO)
//        {
//            _datePick2.hidden = YES;
//        }
        else
            _datePick1.hidden = YES;
        
    }
    if (btn.tag == 11)
    {
        _datePick1.hidden = YES;
        if (btn.selected)
        {
            _datePick2 = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 120+y, SCREEN_WIDTH, 218)];
            _datePick2.datePickerMode = UIDatePickerModeDateAndTime;
            _datePick2.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
            _datePick2.tag = 2;
            [_datePick2 addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:_datePick2];
        }
//        else if (_datePick1.hidden == NO)
//        {
//            _datePick1.hidden = YES;
//        }        
        else
            _datePick2.hidden = YES;
    }
}
- (void)playBack
{
    LXController *lx = [[LXController alloc]init];
    [self.navigationController pushViewController:lx animated:YES];
}
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)removeroot
{
   
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
            
            _isClick = NO;
            [self.mnb.superview bringSubviewToFront:self.mnb];
        }else
        {
           
            [self setSelected:NO];
          
            _isClick = YES;
        }
    }
    if (btn.tag == 1)
    {
        [self setSelected:NO];
        _isClick=YES;
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
- (void)selectDate:(UIDatePicker *)datePicker
{
    NSDate *select = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (datePicker.tag == 1)
    {
        [dateFormatter setDateFormat:@"起：yyyy-MM-dd HH:mm"];
        NSString *dateAndTime =  [dateFormatter stringFromDate:select];
        [_startbtn setTitle:dateAndTime forState:UIControlStateNormal];
    }
    if (datePicker.tag == 2)
    {
        [dateFormatter setDateFormat:@"止：yyyy-MM-dd HH:mm"];
        NSString *dateAndTime =  [dateFormatter stringFromDate:select];
        [_endbtn setTitle:dateAndTime forState:UIControlStateNormal];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_datePick1 removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
