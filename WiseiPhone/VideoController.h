//
//  VideoController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-12.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KxMovieDecoder;

@interface VideoController : UIViewController

+ (id) movieViewControllerWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters;

- (void) playDidTouch: (id) sender;
- (void) play;
- (void) pause;
@end
