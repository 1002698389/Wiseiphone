//
//  RootViewController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YulanController;
@class LuxianController;
@class BaojingController;
@class TiyanController;
@class ZhinengController;
@class XitongController;
@class LXController;
@class TestController;
@class PlayMovieController;
@class ListChannelController;
@protocol rootDelegate <NSObject>
@optional
- (void)clearVideo:(long)i;

@end
@interface RootViewController : UIViewController
@property (nonatomic,assign)id<rootDelegate>RtvDelegate;
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)YulanController *yuvc;
@property (nonatomic,strong)LuxianController *luvc;
@property (nonatomic,strong)BaojingController *baovc;
@property (nonatomic,strong)LXController *lxvc;
@property (nonatomic,strong)TiyanController *tivc;
@property (nonatomic,strong)ZhinengController *zhivc;
@property (nonatomic,strong)XitongController *xivc;
@property (nonatomic,strong)PlayMovieController *xtvc;
@property (nonatomic,strong)ListChannelController *lccvc;
@property (nonatomic,strong)UIView *viewLayer;
- (void)setSelected:(BOOL)selected;
@end
