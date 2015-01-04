//
//  TableViewController.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "DisplayList.h"
#import "Getrules.h"

@interface TableViewController ()

@end

@implementation TableViewController
{
    NSMutableArray * _allrules;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadm:) name:@"tableupdate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTable) name:@"notice" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<_allrules.count; i++) {
        [array addObject:dic];
    }
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];


}
- (void)refreshTable
{
    
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<_allrules.count; i++) {
        [array addObject:dic];
    }
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];

}
- (void)reloadm:(NSNotification*)info
{
    
    
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<_allrules.count; i++) {
        [array addObject:dic];
    }
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        
        static NSString *CellIdentifier = @"MainCell";
        
        DisplayList *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[DisplayList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
          
        }
        NSLog(@"index=%d",indexPath.row);
        Rules * rule=[_allrules objectAtIndex:indexPath.row];
        NSString *content=rule.rulename;
        cell.list.text = [NSString stringWithFormat:@"大门口%@",content];
        cell.list.font=[UIFont systemFontOfSize:16];
        if (rule.isused==1) {
            cell.uselab.text=@"已启用";
        }else{
            cell.uselab.text=@"未启用";
        
        }
        
        [self.tableView setAllowsSelection:YES];
        return  cell;
        
    }else if([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
        
        static NSString *CellIdentifier = @"AttachedCell";
        [self.tableView setAllowsSelection:YES];
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
           
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中颜色不变
            
        }
        
        return cell;
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSString *url=@"rtsp://218.204.223.237:554/live/1/66251FC11353191F/e7ooqwcfbqjoo80j.sdp";
//    KxMovieViewController *vc=[KxMovieViewController movieViewControllerWithContentPath:url parameters:nil];
//    [self presentViewController:vc animated:YES completion:nil];
    NSIndexPath *path = nil;
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
        
    }else{
        path = indexPath;
        
    }
  
    if ([[self.dataArray[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
        // 关闭附加cell
        [_allrules removeLastObject];
        NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
        self.dataArray[(path.row-1)] = dic;
        [self.dataArray removeObjectAtIndex:path.row];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
        
    }else{
        // 打开附加cell
        Rules * rule=[[Rules alloc]init];
        rule.rulename=@"附加";
        rule.precept=@"0,";
        rule.points=@"0,0";
        rule.path=@"http://";
        rule.shapetype=0;
        rule.channlid=0;
        rule.descript=@"aa";
        rule.eventtype=0;
        rule.isused=1;
        [_allrules addObject:rule];
        NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(YES)};
        self.dataArray[(path.row-1)] = dic;
        NSDictionary * addDic = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
        [self.dataArray insertObject:addDic atIndex:path.row];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
       
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[_allrules objectAtIndex:indexPath.row],@"rule", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"takedata" object:self userInfo:dic];

   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        return 40;
    }else{
        return 54;
    }
}


@end
