//
//  MoveView.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-18.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol delegateview<NSObject>

- (void)presentviewnext;
@end
@interface MoveView : UIImageView
@property(nonatomic,assign)id <delegateview> iviewdelegate;
@end
