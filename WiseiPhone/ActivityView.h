//
//  ActivityView.h
//  WiseiPhone
//
//  Created by fcw on 14-7-4.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIActivityIndicatorView
{
    id _target;
    SEL _action;
}
- (id)initWithTarget:(id)target action:(SEL)action;
@end
