//
//  BaojingController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "BaojingController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "InforCell.h"
#import "Getrules.h"
#import "AlertLog.h"
#import "YulanController.h"
@interface BaojingController ()

@end

@implementation BaojingController
{
    int y;
    BOOL _isClick;
    UIButton *_searchBar;
    UITableView *_tableView;
    NSMutableArray *_inforArray;
    NSMutableArray *_resultArray;
    int _row;
    NSMutableArray * _selectCells;
    UITapGestureRecognizer * tap2;
    UIView * viewLay2;
   // MyNavigationBar *mnb;
    NSMutableArray *indexs;
    NSMutableArray *rows;
    UIView * viewbar;
    int bj;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bj=0;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
        {
            y = 20;
            self.hidesBottomBarWhenPushed = NO;
        }
        else
            self.hidesBottomBarWhenPushed = YES;
        _inforArray=[NSMutableArray arrayWithCapacity:1];
    }
    indexs=[NSMutableArray arrayWithCapacity:1];
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.alert removeFromSuperview];
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
   //  mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"报警信息" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    _searchBar=[UIButton buttonWithType:UIButtonTypeSystem];
    _searchBar.frame = CGRectMake(0, 40+y, SCREEN_WIDTH, 40);
    _searchBar.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [_searchBar setTitle:@"编辑" forState:UIControlStateNormal];
    [_searchBar setTintColor:[UIColor colorWithRed:0.24f green:0.55f blue:0.78f alpha:1.00f]];
    [_searchBar addTarget:self action:@selector(deletealllog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchBar];
   
    _resultArray = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80+y, SCREEN_WIDTH, SCREEN_HEIGHT-120+y) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
  
    [self.view addSubview:_tableView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[Getrules shareRules]deletealert];
        _inforArray = [[Getrules shareRules]getalert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
   
    
    rows=[NSMutableArray arrayWithCapacity:1];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    _selectCells=[NSMutableArray arrayWithCapacity:1];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmisscontrol) name:@"changecontrol" object:nil];
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉刷新数据";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新";
    _tableView.headerRefreshingText = @"正在请求数据";
    
    _tableView.footerPullToRefreshText = @"上拉刷新数据";
    _tableView.footerReleaseToRefreshText = @"松开马上更新数据";
    _tableView.footerRefreshingText = @"正在请求数据";
}
- (void)headerRereshing
{
    // 1.添加假数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
         _inforArray = [[Getrules shareRules]getalert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView headerEndRefreshing];
        });
    });
    

}

- (void)footerRereshing
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        _inforArray = [[Getrules shareRules]getalert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView footerEndRefreshing];
        });
    });
}
- (void)dissmisscontrol{

    [[[[UIApplication sharedApplication]keyWindow ]rootViewController] dismissViewControllerAnimated:YES completion:nil];


}
- (void)addbutton{
    viewbar=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60+y, SCREEN_WIDTH, 40)];
    viewbar.backgroundColor=[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [self.view addSubview:viewbar];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 0, 100, 40);
   // btn.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [btn setTitle:@"全选" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.24f green:0.55f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [viewbar addSubview:btn];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 0, 100, 40);
   // btn2.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    [btn2 setTitle:@"删除" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:0.24f green:0.55f blue:0.78f alpha:1.00f] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick22) forControlEvents:UIControlEventTouchUpInside];
    [viewbar addSubview:btn2];

}

- (void)deletealllog:(UIButton*)btn{
    if (bj==0) {
        [self addbutton];
        bj=1;
        [_searchBar setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        bj=0;
        [viewbar removeFromSuperview];
        [_searchBar setTitle:@"编辑" forState:UIControlStateNormal];
    }
   
    //[[Getrules shareRules] deletealertlogs];
    //_inforArray=[[Getrules shareRules] getalert];
    [_tableView reloadData];

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
#pragma mark - UITableView方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    InforCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"InforCell" owner:self options:nil]lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    AlertLog * alert=[_inforArray objectAtIndex:indexPath.row];

    if (bj==1) {
        
        NSNumber * idx=[NSNumber numberWithLong:indexPath.row];
        
        if([_selectCells containsObject:idx]){
            cell.Iconmg.image=[UIImage imageNamed:@"JKAselectOn.png"];
            cell.backgroundColor=[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1];
            [cell.contentView addSubview:cell.Iconmg];
        
        }else{
            cell.Iconmg.image=[UIImage imageNamed:@"JKAselectOff.png"];
            [cell.contentView addSubview:cell.Iconmg];
            cell.backgroundColor=[UIColor whiteColor];
        }
     
    }
    
    NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *picp=[directorypath stringByAppendingPathComponent:alert.picpath];
    UIImage * img=[UIImage imageWithContentsOfFile:picp];
    if (img==nil) {
        cell.defaultpic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 60, 60)];
        img=[UIImage imageNamed:@"JKAaddcamera.png"];
        [cell.defaultpic setImage:img];
        [cell addSubview:cell.defaultpic];
    }else{
        [cell.alertpic setImage:img];
    }
    cell.titleName.text = alert.rulename;
    NSLog(@"第%d路",alert.chindex);
    int channel=alert.chindex+1;
    cell.titleType.text = [NSString stringWithFormat:@"第%d路",channel];
    cell.titleType.textColor=[UIColor lightGrayColor];
    NSString * str1=alert.alerttime;
    cell.titleTime.text = str1;
    cell.titleTime.textColor=[UIColor lightGrayColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_inforArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        // 删除操作
//        // 1.删除数据源
//        [_inforArray removeObjectAtIndex:indexPath.row];
//        // 2.更新tableView(执行删除动画)
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    }
//   
//    
//}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (bj==0) {
   
        [rows addObject:indexPath];
       
       
       InforCell * selCell=(InforCell*)[tableView cellForRowAtIndexPath:indexPath];
        selCell.backgroundColor=[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1];
        if (rows.count>2) {
            [rows removeObjectAtIndex:0];
            InforCell * oldcell=(InforCell*)[tableView cellForRowAtIndexPath:[rows objectAtIndex:0]];
            oldcell.backgroundColor=[UIColor whiteColor];
        }
        if (rows.count==2) {
            InforCell * oldone=(InforCell*)[tableView cellForRowAtIndexPath:[rows objectAtIndex:0]];
            oldone.backgroundColor=[UIColor whiteColor];
        }
        AlertLog * alert=[_inforArray objectAtIndex:indexPath.row];
        NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *picp=[directorypath stringByAppendingPathComponent:alert.bigpicpath];
        UIImage * img=[UIImage imageWithContentsOfFile:picp];
        [self.view addSubview:self.alert];
        [self.alert createAlertView:self action:@selector(disablealert)];
        self.alert.imgv.image=nil;
        self.alert.imgv.image=img;
        self.alert.layer.borderColor=[UIColor grayColor].CGColor;
        self.alert.layer.borderWidth=1;
        self.alert.lab.text=nil;
        self.alert.lab.font=[UIFont systemFontOfSize:12];
        self.alert.lab.text=alert.rulename;
        self.alert.tlab.text=nil;
        self.alert.tlab.font=[UIFont systemFontOfSize:10];
        self.alert.tlab.text=alert.alerttime;
    }else{
       
    InforCell * selCell=(InforCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (selCell.selected==YES) {
       
        selCell.Iconmg.image=[UIImage imageNamed:@"JKAselectOff.png"];
        selCell.backgroundColor=[UIColor whiteColor];
        [_selectCells removeObject:[NSNumber numberWithLong:indexPath.row]];
        [selCell setSelected:NO];
     
    }else{
     
        selCell.Iconmg.image=[UIImage imageNamed:@"JKAselectOn.png"];
        [selCell setSelected:YES];
        selCell.backgroundColor=[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1];
        NSNumber * row=[NSNumber numberWithLong:indexPath.row];
        [_selectCells addObject:row];
        NSLog(@"%@",_selectCells);
    }
    
    }
    
    return nil;
}
- (AlertView*)alert
{
    if (!_alert) {
        _alert=[[AlertView alloc]initWithFrame:CGRectMake(35,100, 252, 342)];
        _alert.backgroundColor=[UIColor whiteColor];
        
    }
    return _alert;
}
- (void)disablealert
{
    
    [self.alert removeFromSuperview];
    self.alert=nil;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//    return UITableViewCellEditingStyleDelete;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)removeroot
{
    [viewLay2 removeFromSuperview];
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
       // [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)btnClick{
   
    CGRect frametb=CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.contentSize.width, _tableView.contentSize.height);
    NSValue * va=[NSValue valueWithCGRect:frametb];
    NSLog(@"tablesize=%@",va);
    NSArray * indexpaths=[_tableView indexPathsForRowsInRect:frametb];
    
    for (int i=0; i<indexpaths.count; i++) {
        NSIndexPath * idp=[indexpaths objectAtIndex:i];
        NSNumber * ccr=[NSNumber numberWithLong:idp.row];
        [_selectCells addObject:ccr];
        InforCell * cell=(InforCell*)[_tableView cellForRowAtIndexPath:[indexpaths objectAtIndex:i]];
        [cell setSelected:YES];
        cell.backgroundColor=[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1];
        cell.Iconmg.image=[UIImage imageNamed:@"JKAselectOn.png"];
    }

}
- (void)btnClick22
{

    
    for (int i=0; i<_selectCells.count; i++) {
        AlertLog * alertlg=[_inforArray objectAtIndex:[[_selectCells objectAtIndex:i] integerValue]];
        NSLog(@"ruleid=%d",alertlg.ruleid);
        [[Getrules shareRules] deletelogbyindex:alertlg.picpath];
        [[Getrules shareRules] removeallpictures:alertlg.picpath];
        
    }
    [_selectCells removeAllObjects];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
         _inforArray=[[Getrules shareRules] getalert];
         dispatch_async(dispatch_get_main_queue(), ^{
              [_tableView reloadData];
         });
     });
    
   
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
