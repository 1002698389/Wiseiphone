//
//  TYController.h
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaojingController;
@interface TYController : UIViewController

+ (id) movieViewControllerWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters;
@property (readonly) BOOL playing;

@end
