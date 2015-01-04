//
//  ZhinengController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "ZhinengController.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "Rules.h"
#import "Dbcon.h"
#import "Getrules.h"
#import "DisplayList.h"
#import "PlayMovieController.h"
#import "kxmovie/KxMovieViewController.h"
#import "SocketServer.h"
#import "BaojingController.h"
#import "YulanController.h"
extern int isnetwork;
@interface ZhinengController ()

@end

@implementation ZhinengController
{
    int y;
    BOOL _isClick;
    UITapGestureRecognizer *tap4;
    UIView *viewLay4;
    NSMutableArray *_allrules;
    NSMutableArray * titlearray;
    NSMutableArray * selectarray;
    NSMutableDictionary * diction;
    NSMutableArray * contents;
    NSMutableArray * arr;
    NSMutableArray * routh;
    int channelid;
    int _ispresent;
    //MyNavigationBar *mnb;
    long btntag;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        btntag=0;
        titlearray=[NSMutableArray arrayWithCapacity:1];
        selectarray=[NSMutableArray arrayWithCapacity:1];
        diction=[NSMutableDictionary dictionaryWithCapacity:1];
        contents=[NSMutableArray arrayWithCapacity:1];
     
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
        {
            y = 20;
            self.hidesBottomBarWhenPushed = NO;
        }
        else{
            self.hidesBottomBarWhenPushed = YES;
        }
        //         _allrules=[NSMutableArray arrayWithCapacity:1];
        
    }
    return self;
}
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
- (void)freshdata{
    routh=[[Getrules shareRules] getroutharray];
    
    for (int i=0; i<routh.count; i++) {
        NSMutableArray * marray=[NSMutableArray arrayWithCapacity:1];
        int chanel=[[routh objectAtIndex:i]intValue];
        marray=[[Getrules shareRules]getRules:chanel];
        
        
        NSMutableArray * content=[NSMutableArray arrayWithCapacity:1];
        for (int j=0; j<marray.count; j++) {
            Rules * rule=[marray objectAtIndex:j];
            NSNumber * used=[NSNumber numberWithInt:rule.isused];
            NSMutableDictionary * ruledict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",rule.rulename,@"name",used,@"used",@"NO",@"state", rule,@"rule",nil];
            [content addObject:ruledict];
            
            
            
        }
        [diction setObject:content forKey:[NSString stringWithFormat:@"%d",[[routh objectAtIndex:i]intValue]]];
        //[contents removeAllObjects];
        
    }



}
- (void)initdatasource
{
    [titlearray removeAllObjects];
    [diction removeAllObjects];
    routh=[[Getrules shareRules] getroutharray];
    
    for (int m=0; m<routh.count; m++) {
        int rt=[[routh objectAtIndex:m]intValue];
        NSString * routhname=[NSString stringWithFormat:@"%d",rt+1];
        [titlearray addObject:routhname];
    }
    
   
    for (int i=0; i<routh.count; i++) {
        NSMutableArray * marray=[NSMutableArray arrayWithCapacity:1];
        int chanel=[[routh objectAtIndex:i]intValue];
        marray=[[Getrules shareRules]getRules:chanel];
        
        
       NSMutableArray * content=[NSMutableArray arrayWithCapacity:1];
        for (int j=0; j<marray.count; j++) {
            Rules * rule=[marray objectAtIndex:j];
            NSNumber * used=[NSNumber numberWithInt:rule.isused];
            NSMutableDictionary * ruledict=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",rule.rulename,@"name",used,@"used",@"NO",@"state", rule,@"rule",nil];
            [content addObject:ruledict];
            
            
            
        }
        [diction setObject:content forKey:[NSString stringWithFormat:@"%d",[[routh objectAtIndex:i]intValue]]];
        //[contents removeAllObjects];
        
    }
    NSLog(@"diction=%@",diction);
}
- (void)viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"notice" object:self];
    [diction removeAllObjects];
    [titlearray removeAllObjects];
    [self initdatasource];
    [self.tc reloadData];
    [self.view addSubview:self.iview];
    [self.view bringSubviewToFront:self.iview];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self setSelected:NO];
    [self.tc reloadData];
    
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
   // [self initdatasource];
    self.tc=[[UITableView alloc]init];
    self.tc.frame =CGRectMake(0,80+y, SCREEN_WIDTH, SCREEN_HEIGHT-100+y);
    self.tc.delegate=self;
    self.tc.dataSource=self;
    self.tc.separatorColor=[UIColor grayColor];
    self.tc.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    self.tc.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    [self.view addSubview:self.tc];
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
    _isClick = YES;
    [self.navigationController setNavigationBarHidden:YES];
   // mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:@"规则管理" andLeftButtonImageName:@"JKAtopMenu.png" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 40+y, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    [self.view addSubview:headView];
    UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(125, 5, 120, 30)];
    headLab.backgroundColor = [UIColor clearColor];
    headLab.text = @"已有规则";
    headLab.font = [UIFont systemFontOfSize:18];
    headLab.textColor=[UIColor colorWithRed:0.09 green:0.4 blue:0.76 alpha:1];
    [headView addSubview:headLab];
    //[self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takemsg:) name:@"selc" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:@"cancelrootview" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gomovie:) name:@"playmovie" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleterow:) name:@"editData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"update" object:nil];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return titlearray.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    NSLog(@"string000=%@",string);
    NSLog(@"selecttarray000=%@",selectarray);
    NSLog(@"titlearray000=%@",[titlearray objectAtIndex:0]);
    if ([selectarray containsObject:string]) {
        
        UIImageView *imageV = (UIImageView *)[self.tc viewWithTag:20000+section];
        imageV.image = [UIImage imageNamed:@"51智能设置已有规则-减号_03.png"];
        NSString * ss=[titlearray objectAtIndex:section];
//        NSRange range=[ss rangeOfString:@"路"];
//        NSRange range1=NSMakeRange(1, range.location-1);
//        NSString * loc=[ss substringWithRange:range1];
        int index=[ss intValue];
        int mas=index-1;
        NSString * coco=[NSString stringWithFormat:@"%d",mas];
        NSLog(@"coco=%@",coco);
        NSArray *array1 = diction[coco];
        NSLog(@"array1=%@",array1);
        return array1.count;
    }
    
  
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, tableView.frame.size.width-20, 30)];
    int sect=(int)section;
    NSString * rout=[titlearray objectAtIndex:sect];
    titleLabel.text = [NSString stringWithFormat:@"第%@路",rout] ;
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    imageView.tag = 20000+section;
    
    //判断是不是选中状态
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    
    if ([selectarray containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"51智能设置已有规则-减号_03.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"51智能设置已有规则-加号_07.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 40);
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    NSLog(@"section=%ld",section);
   
    UIButton * enablerule=[UIButton buttonWithType:UIButtonTypeSystem];
    enablerule.backgroundColor=[UIColor colorWithRed:0.27 green:0.3 blue:0.3 alpha:1];
    [enablerule setTintColor:[UIColor whiteColor]];
   
    int isection=[[routh objectAtIndex:section] intValue];
    NSMutableArray * uss=[[Getrules shareRules] getused:isection];
    NSNumber * yi=[NSNumber numberWithInt:1];
    if ([uss containsObject:yi]) {
     
        [enablerule setTitle:@"禁用所有规则" forState:UIControlStateNormal];
    }else{
        
        [enablerule setTitle:@"启用所有规则" forState:UIControlStateNormal];
    }
    enablerule.tag=900+section;
    enablerule.frame=CGRectMake(200, 0, 120, 40);
    [enablerule addTarget:self action:@selector(disablemyrule:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:enablerule];
    NSLog(@"这里验证分区");
    return view;
}
- (void)disablemyrule:(UIButton*)btn
{
    NSLog(@"btn.tag=%ld",btn.tag);
    if(isnetwork==1)
    {
    int chanlid=(int)(btn.tag-900);
        NSLog(@"chanlid=%d",chanlid);
        int routhy=[[titlearray objectAtIndex:chanlid] intValue]-1;
  
        NSLog(@"btn.titlelabel=%@",btn.titleLabel.text);
        BOOL txts=[btn.titleLabel.text isEqualToString:@"禁用所有规则"];
        NSLog(@"txts=%d",txts);
    if (txts) {
        
        [[Getrules shareRules]updateusedall:routhy isused:0];
        NSMutableArray * rulids=[[Getrules shareRules]takeruleid:routhy];
        for (int i=0; i<rulids.count;i++) {
            int ruleid=[[rulids objectAtIndex:i] intValue];
            [[SocketServer shareSocket] disablerule:routhy ruleid:ruleid];
        }
        [btn setTitle:@"启用所有规则" forState:UIControlStateNormal];
       
        NSLog(@"启用了规则");
    }else{
        [[Getrules shareRules]updateusedall:routhy isused:1];
        NSMutableArray * rulids=[[Getrules shareRules]takeruleid:routhy];
        for (int i=0; i<rulids.count; i++) {
            int ruleid=[[rulids objectAtIndex:i]intValue];
            [[SocketServer shareSocket] enablerule:routhy ruleid:ruleid];
        }
        [btn setTitle:@"禁用所有规则" forState:UIControlStateNormal];
      
        NSLog(@"禁用了所有规则");
        
    }
    [diction removeAllObjects];
    [titlearray removeAllObjects];
    [self initdatasource];
    [self.tc reloadData];
        [self.tc reloadSections:[NSIndexSet indexSetWithIndex:chanlid] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有连接不能操作规则" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    
    
    }


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *title=[titlearray objectAtIndex:indexPath.section];
    
    int index=[title intValue];
    int mas=index-1;
    NSString * coco=[NSString stringWithFormat:@"%d",mas];
    if ([diction[coco][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        
        static NSString *CellIdentifier = @"MainCell";
        
        DisplayList *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[DisplayList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor=[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        if ([selectarray containsObject:indexStr]) {
           cell.list.text=diction[coco][indexPath.row][@"name"];
            NSNumber * isuses=diction[coco][indexPath.row][@"used"];
            int ius=[isuses intValue];
            if (ius==1) {
                cell.uselab.text=@"已启用";
            }else{
            
                cell.uselab.text=@"已禁用";
            }
            cell.imgv.image=[UIImage imageNamed:@"JKAmoreShow.png"];
            
        }
        
          
        
        return cell;
    }
    else if([diction[coco][indexPath.row][@"cell"] isEqualToString:@"AttachedCell"]){
        
        static NSString *CellIdentifier = @"AttachedCell";
        
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        return cell;
    }
    
    return nil;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self.tc deselectRowAtIndexPath:indexPath animated:YES];
    
// NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *title=[titlearray objectAtIndex:indexPath.section];

    int index=[title intValue];
    int mas=index-1;
    NSString * coco=[NSString stringWithFormat:@"%d",mas];
    NSIndexPath *path = nil;
    
    if ([diction[coco][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
        
    }
    else
    {
        path = indexPath;
    }
    
    if ([diction[coco][indexPath.row][@"state"] boolValue]) {
        
        // 关闭附加cell
        NSIndexPath * indexpath;
        if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[CustomCell class]]) {
             indexpath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
        }else{
            indexpath=indexPath;
        
        }
       
        DisplayList * cell=(DisplayList*)[tableView cellForRowAtIndexPath:indexpath];
        cell.imgv.image=[UIImage imageNamed:@"JKAmoreShow.png"];

        arr=[diction objectForKey:coco];
        [arr[path.row-1] setValue:@"NO" forKey:@"state"];
        [arr removeObjectAtIndex:path.row];
        NSLog(@"arr2=%@",arr);
        [self.tc beginUpdates];
        [self.tc deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tc endUpdates];
        
    }
    else
    {
        // 打开附加cell
        
        DisplayList * cell=(DisplayList*)[tableView cellForRowAtIndexPath:indexPath];
        cell.imgv.image=[UIImage imageNamed:@"JKAmoreHide.png"];

        arr=[diction objectForKey:coco];
        [arr[path.row-1] setValue:@"YES" forKey:@"state"];
        NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AttachedCell",@"cell",@"YES",@"state",nil];
        [arr insertObject:nameAndStateDic1 atIndex:path.row];
     
        [self.tc beginUpdates];
        [self.tc insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tc endUpdates];
        Rules * rul=[arr objectAtIndex:indexPath.row][@"rule"];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:rul,@"rule", nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"takedata" object:self userInfo:dic];
        
    }
    return nil;

}

- (void)deleteattach
{
    for (int i=0; i<arr.count; i++) {
        if ([[arr objectAtIndex:i][@"cell"] isEqualToString:@"AttachedCell"]) {
            [arr removeObjectAtIndex:i];
        }
        if ([[arr objectAtIndex:i][@"state"] boolValue]) {
            [[arr objectAtIndex:i] setValue:@"NO" forKey:@"state"];
        }
        
    }

}
- (void)dododo{

    NSString *string = [NSString stringWithFormat:@"%ld",btntag-100];
    [selectarray addObject:string];
    
    [self.tc reloadData];




}
- (void)doButton:(UIButton*)sender
{
   // btntag=sender.tag;
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag-100];
    NSLog(@"string=%@",string);
    NSLog(@"selectarray=%@",selectarray);
    NSLog(@"arr=%@",arr);
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if (btntag>0) {
        [selectarray removeAllObjects];
        btntag=0;
    }else{
    if ([selectarray containsObject:string])
    {
      NSLog(@"select=%@",selectarray);
        for (int i=0; i<arr.count; i++) {
            NSLog(@"i=%d",i);
            if ([[arr objectAtIndex:i][@"state"] boolValue]) {
                [[arr objectAtIndex:i] setValue:@"NO" forKey:@"state"];
            }
          
            
        }
        for (int j=0; j<arr.count; j++) {
            if ([[arr objectAtIndex:j][@"cell"] isEqualToString:@"AttachedCell"]) {
                [arr removeObjectAtIndex:j];
            }
        }
        [selectarray removeObject:string];
    }
    else
    {
        NSLog(@"select=%@",selectarray);
        [selectarray addObject:string];
    }
    }
    [self.tc reloadData];


}
- (void)deleterow:(NSNotification*)info
{
    if (isnetwork==1) {
        Rules * rl=[[info userInfo]valueForKey:@"rule"];
        int i=rl.Rid;
        int chindex=rl.channlid;
        int rulid=rl.ruleid;
        NSLog(@"rlid=%d",i);
        [[Getrules shareRules] deleteRules:i];
        [self initdatasource];
        [self.tc reloadData];
        [[SocketServer shareSocket] deleterule:chindex ruleid:rulid];
        NSNumber * count=[NSNumber numberWithInt:1];
        NSDictionary * dic=[NSDictionary dictionaryWithObjectsAndKeys:count,@"ct", nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tableupdate" object:self userInfo:dic];
    }else{
       
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有连接不能操作规则" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    
    
    }
    
    
}
- (void)remove:(NSNotification*)info
{
    BOOL isOk=[[[info userInfo]valueForKey:@"isc"] boolValue];
    if (isOk==YES) {
        [self setSelected:NO];
        [self.rootc.rootView removeFromSuperview];
        _isClick = YES;
    }
    
}
- (void)takemsg:(NSNotification*)info
{
    _isClick=[[[info userInfo]valueForKey:@"ck"] boolValue];
    
}
- (void)gomovie:(NSNotification*)info
{
    if (isnetwork==1) {
//    NSString * status=@"movie";
    Rules *rl=[[info userInfo]valueForKey:@"mynum"];
        if (rl.isused==0) {
            [[Getrules shareRules] updateused:rl isused:1];
            [[SocketServer shareSocket] enablerule:rl.channlid ruleid:rl.ruleid];
            [titlearray removeAllObjects];
            [diction removeAllObjects];
            //[selectarray removeAllObjects];
            [self initdatasource];
            btntag=1;
            
        }else{
            [[Getrules shareRules] updateused:rl isused:0];
            [[SocketServer shareSocket] disablerule:rl.channlid ruleid:rl.ruleid];
            [titlearray removeAllObjects];
            [diction removeAllObjects];
            //[selectarray removeAllObjects];
            [self initdatasource];
            btntag=1;
        }
       
       [self.tc reloadData];
        
       
   
    }else{
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有连接不能操作规则" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
}
- (void)update:(NSNotification*)info
{
    if (isnetwork==1) {
        NSString *status=@"update";
        Rules *rl=[[info userInfo]valueForKey:@"dat"];
        PlayMovieController *playmc=[[PlayMovieController alloc]init];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromTop";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        playmc.playrule=rl;
        playmc.isUpdate=status;
        [self presentViewController:playmc animated:NO completion:nil];
    }else{
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有连接不能操作规则" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
   
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}
#pragma mark - Menu 方法
- (RootViewController*)rootc{
    if (!_rootc) {
        _rootc=[[RootViewController alloc]init];
    }
    return _rootc;
}
- (void)removeroot
{
    [viewLay4 removeFromSuperview];
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

@end
