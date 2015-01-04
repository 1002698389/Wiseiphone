//
//  ListChannelController.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-15.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
#import "RootViewController.h"
#import "MoveView.h"
@class BaojingController;
@interface ListChannelController : RootViewController<UITableViewDataSource,UITableViewDelegate,delegateview>
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;
@property(nonatomic,strong)UIView * maskview;
@property(nonatomic,assign)int iclick;
@property(nonatomic,assign)BOOL isClick;
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)MoveView * iview;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
