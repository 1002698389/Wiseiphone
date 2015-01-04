//
//  PlayMovieController.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-30.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieViewController.h"
#import "Newdraw.h"
#import "Rules.h"
#import "QCheckBox.h"
#import "Draw.h"
#import "Getrules.h"
#import "MyNavigationBar.h"
@class BaojingController;
@interface PlayMovieController : UIViewController
@property(nonatomic,strong)MovieViewController * player;
@property(nonatomic,strong)Rules * playrule;
@property(nonatomic,strong)NSString *isUpdate;
@property(nonatomic,strong)UIView *ruleview1;
@property(nonatomic,strong)UIView *ruleview2;
@property(nonatomic,strong)UIView * viewbar;
@property(nonatomic,strong)UIView * backGround;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
