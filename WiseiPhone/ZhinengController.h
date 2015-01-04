//
//  ZhinengController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "Ruleview.h"
@class Rules;
@class Dbcon;
@class Getrules;
@class BaojingController;
#import "CustomCell.h"
#import "TableViewController.h"
#import "MoveView.h"
#import "MyNavigationBar.h"
@class DisplayList;

@interface ZhinengController : RootViewController<UITableViewDelegate,UITableViewDataSource,delegateview>

@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)CustomCell *mycell;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tc;
@property(nonatomic,strong)MoveView * iview;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
