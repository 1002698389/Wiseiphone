//
//  TestController.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-27.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "MyNavigationBar.h"
@class BaojingController;
@interface TestController : UIViewController
@property(nonatomic,strong)NSString * path;
@property(nonatomic,strong)MPMoviePlayerController *player;
@property(nonatomic,strong)NSString * ititle;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
