//
//  LuxianController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "MyNavigationBar.h"
@class BaojingController;
@interface LuxianController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
