//
//  YLController.h
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MyNavigationBar.h"
@class BaojingController;
//@protocol yldelegate<NSObject>
//- (void)beginfirst:(int)count indexarray:(NSMutableArray*)indexarray;
//@end
@interface YLController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,assign)id <yldelegate>YLDelegate;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
