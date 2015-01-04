//
//  XitongController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//
#import "MoveView.h"
#import "RootViewController.h"
#import "MyNavigationBar.h"
@class BaojingController;
@interface XitongController : RootViewController<UITableViewDataSource,UITableViewDelegate,delegateview>
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)MoveView * iview;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
