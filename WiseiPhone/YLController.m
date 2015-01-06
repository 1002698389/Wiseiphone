//
//  YLController.m
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "YLController.h"
#import "yShi.h"
#import "MyNavigationBar.h"
#import "MyLineCell.h"
#import "saveIndex.h"
#import "YulanController.h"
#import "SocketServer.h"
#import "Getrules.h"
#import "BaojingController.h"
#import "Indexpath.h"
extern NSString *bieming;
extern int isinterest;
extern int isnetwork;
extern int istunel;
extern NSMutableArray * idxpaths;
@interface YLController ()

@end

@implementation YLController
{
    int y;
    BOOL _isClick;
    NSMutableArray *_titleArray;
    UITableView *_tableView;
    NSMutableArray *_pathArray;
    int _tongdaos;
    NSMutableDictionary *dict;
    NSMutableArray * _index;
    NSMutableArray * _namearr;
    //MyNavigationBar *mnb;
    NSMutableArray * indexpaths;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _namearr=[NSMutableArray arrayWithCapacity:1];
        _index=[NSMutableArray arrayWithCapacity:1];
        indexpaths=[NSMutableArray arrayWithCapacity:1];
        [[SocketServer shareSocket] sendStatus];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adddata:) name:@"serverstatus" object:nil];
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

    [_tableView reloadData];
    NSLog(@"idxpaths=%@",idxpaths);

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
  
    _tongdaos=0;
    _isClick = YES;
   // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"通道列表" andLeftButtonImageName:nil andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    //idxpaths=[[NSMutableArray alloc]initWithCapacity:1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+y, SCREEN_WIDTH, SCREEN_HEIGHT-100+y) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    // 数据源
    _titleArray = [[NSMutableArray alloc] initWithCapacity:1];
   
      dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    if (bieming.length==0) {
        [dict setValue:[NSString stringWithFormat:@"正式通道"] forKey:@"name"];
    }else{
    
        [dict setValue:[NSString stringWithFormat:@"%@",bieming] forKey:@"name"];
    }
    
    NSMutableArray * arr=[NSMutableArray arrayWithCapacity:1];
    
        // section 状态 ：YES打开 NO关闭
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"state"];
        [dict setValue:arr forKey:@"contents"];
        [_titleArray addObject:dict];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-60+y, SCREEN_WIDTH, 40);
    btn.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [btn setTitle:@"开始预览" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.24f green:0.55f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBegan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
- (void)baojing{

    BaojingController * baojin=[[BaojingController alloc]init];
    
    [self presentViewController:baojin animated:NO completion:nil];

}


- (void)adddata:(NSNotification*)info
{
    //[self takeurlinfoma];
    NSMutableArray * mydata=[[info userInfo]valueForKey:@"status"];
    NSLog(@"mydata=%@",mydata);
    [dict removeObjectForKey:@"contents"];
    [dict setValue:mydata forKey:@"contents"];
    [_tableView reloadData];
}
#pragma mark - UITableView方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
   MyLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
       // cell = [[[NSBundle mainBundle]loadNibNamed:@"MyLineCell" owner:self options:nil]lastObject];
        cell=[[MyLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
       
       
    }
    if ([indexpaths containsObject:indexPath]) {
        [cell setSelected:YES];
        [cell.btn setImage:[UIImage imageNamed:@"JKAselectOn.png"]];
    }else{
        cell.selected=NO;
         [cell.btn setImage:[UIImage imageNamed:@"JKAselectOff.png"]];
    }
    NSLog(@"cellselect=%d",cell.selected);
    [cell.imageIcon setImage:[UIImage imageNamed:@"JKAiconCamera.png"]];
    NSString * string=[[[_titleArray objectAtIndex:indexPath.section] objectForKey:@"contents"] objectAtIndex:indexPath.row];
    NSArray * array=[string componentsSeparatedByString:@"."];
    NSString * chname=[array objectAtIndex:0];
    int status=[[array objectAtIndex:2] intValue];
  
    if (status>=515) {
         cell.isinfo.text=@"有信号";
        cell.isinfo.textColor=[UIColor blackColor];
        cell.userInteractionEnabled=YES;
        
    }else{
         cell.isinfo.text=@"无信号";
        cell.isinfo.textColor=[UIColor lightGrayColor];
        cell.userInteractionEnabled=NO;
    }
    cell.titleName.text =chname;
   
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * infos=[[Getrules shareRules]takeurlinfo];
    NSMutableArray * channels=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<infos.count; i++) {
        urlinfo * uif=[[urlinfo alloc]init];
        uif=[infos objectAtIndex:i];
        [channels addObject:[NSNumber numberWithInt:uif.index]];
    }

    MyLineCell * mycell=(MyLineCell*)[tableView cellForRowAtIndexPath:indexPath];
   // mycell.btn.enabled=NO;
    if (mycell.selected==YES) {
      
            [mycell.btn setImage:[UIImage imageNamed:@"JKAselectOff.png"]];
            mycell.selected=NO;
       
        _tongdaos--;
        NSString * string=[[[_titleArray objectAtIndex:indexPath.section] objectForKey:@"contents"] objectAtIndex:indexPath.row];
        NSArray * array=[string componentsSeparatedByString:@"."];
        NSString * index=[array objectAtIndex:1];

        if ([_index containsObject:index]) {
            [_index removeObject:index];
           
        }

        [indexpaths removeObject:indexPath];
      
    }else{
        
        
        if (_tongdaos>4) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"最多只能选择四个通道" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
           
        }else{
          //  mycell.btn.enabled=YES;
            [mycell.btn setImage:[UIImage imageNamed:@"JKAselectOn.png"]];
            mycell.selected=YES;
            _tongdaos++;
            
            NSString * string=[[[_titleArray objectAtIndex:indexPath.section] objectForKey:@"contents"] objectAtIndex:indexPath.row];
            NSArray * array=[string componentsSeparatedByString:@"."];
            NSString * index=[array objectAtIndex:1];
            
       if (![_index containsObject:index]) {
            [_index addObject:index];
           
            }
          [indexpaths addObject:indexPath];

        }
    
        
        
    }
    NSLog(@"channels=%@",channels);
    NSLog(@"index=%@",_index);
    for (int n=0; n<channels.count; n++) {
        NSString * elem=[NSString stringWithFormat:@"%@",[channels objectAtIndex:n]];
        
        BOOL kk=[_index containsObject:elem];
        NSLog(@"kk=%d",kk);
      
        
        if (kk==0) {
            [[Getrules shareRules]deleteurlinfo:[[channels objectAtIndex:n] intValue]];
        }
    }
    NSMutableArray * oinfo=[[Getrules shareRules]takeoriginfo];
    NSMutableArray * ochan=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<oinfo.count; i++) {
        urlinfo * oif=[[urlinfo alloc]init];
        oif=[oinfo objectAtIndex:i];
        [ochan addObject:[NSNumber numberWithInt:oif.index]];
    }
    for (int m=0; m<_index.count; m++) {
          int kkk=[[Getrules shareRules]checkorigininfo:[[_index objectAtIndex:m]intValue]];
          int ppp=[[Getrules shareRules]checkselectinfo:[[_index objectAtIndex:m]intValue]];
        NSNumber * channell=[NSNumber numberWithInt:[[_index objectAtIndex:m] intValue]];
        BOOL ddd=[ochan containsObject:channell];
        if (kkk>0&&ddd==1&&ppp==0) {
            [[Getrules shareRules] appendinfo:[[_index objectAtIndex:m] intValue]];
        }
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
    [button addTarget:self action:@selector(changesection:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 150, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor purpleColor];
    title.text = [[_titleArray objectAtIndex:section] objectForKey:@"name"];
    [button addSubview:title];
    return button;
}


- (void)changesection:(UIButton *)btn
{
    int section = (int)btn.tag;
    if ([[[_titleArray objectAtIndex:section] objectForKey:@"state"] boolValue])
    {
        [[_titleArray objectAtIndex:section] setValue:[NSNumber numberWithBool:NO] forKey:@"state"];
    } else {
        [[_titleArray objectAtIndex:section] setValue:[NSNumber numberWithBool:YES] forKey:@"state"];
    }
    [_tableView reloadData];
    // 刷新指定组号的cell
   //[_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//    NSLog(@"idxpaths_______________整个已选索引=%@",idxpaths);
//    for (int i=0; i<idxpaths.count; i++) {
//        MyLineCell * cell=(MyLineCell*)[_tableView cellForRowAtIndexPath:[idxpaths objectAtIndex:i]];
//        cell.selected=YES;
//        cell.btn.selected=YES;
//        //[cell.btn setImage:[UIImage imageNamed:@"JKAselectOn.png"] forState:UIControlStateSelected];
//    }
}
#pragma mark - UIButton方法
- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}
- (void)btnBegan
{
    
    if (isnetwork==1) {
        istunel=1;
        NSLog(@"_index=%@",_index);
        if(_index.count!=0){
        [[SocketServer shareSocket] sendInterest:_index];
        isinterest=1;
        }else{
            [[Getrules shareRules] deleteurlinfo];
        
        }
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        YulanController * yc=[[YulanController alloc]init];
        // yc.indexs=_index;
        [_index removeAllObjects];
      //  [idxpaths removeAllObjects];
  
        
       // idxpaths=[[NSMutableArray alloc]initWithArray:idarr];
     
        [indexpaths removeAllObjects];
        
        [self presentViewController:yc animated:NO completion:nil];
    }else{
    
        return;
    
    }
    
    
    
}
- (void)bbiClick:(UIButton *)btn
{
   
    
   // [self.YLDelegate  beginfirst:_tongdaos indexarray:_index];
    
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromBottom";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    YulanController * yulan=[[YulanController alloc]init];
    [self presentViewController:yulan animated:NO completion:nil];
    //[self dismissViewControllerAnimated:NO completion:nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
