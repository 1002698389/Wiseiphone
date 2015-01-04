//
//  BaojingController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "AlertView.h"
#import "MyNavigationBar.h"
#import "MJRefresh.h"
@interface BaojingController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)AlertView * alert;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
