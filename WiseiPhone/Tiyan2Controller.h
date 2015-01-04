//
//  Tiyan2Controller.h
//  WiseiPhone
//
//  Created by chou an on 14-8-7.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "TestController.h"
#import  "ImgBtn.h"
#import "MoveView.h"
#import "MyNavigationBar.h"
@class BaojingController;
@interface Tiyan2Controller : RootViewController<delegateview>
@property (nonatomic,retain)MPMoviePlayerController *player;
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)ImgBtn * btn;
@property(nonatomic,strong)MoveView * iview;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
