//
//  XTController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-3.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavigationBar.h"
@class BaojingController;
@interface XTController : UIViewController<UITextFieldDelegate>

@property (nonatomic)int type;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
