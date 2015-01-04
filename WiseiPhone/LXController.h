//
//  LXController.h
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaojingController;
@interface LXController : UIViewController
{
    CGPoint firstPoint;
}
+ (id) movieViewControllerWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters;
@end
