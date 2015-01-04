//
//  MyNavigationBar.h
//  意林News
//
//  Created by Michelle on 14-3-3.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationBar : UIView

- (void)createNavigationBarWithImage:(NSString *)name andLeftButtonImageName:(NSString *)leftImageName andRightButtonImageName:(NSString *)rightImageName andSEL:(SEL)sel andClass:(id)classObject;
@end
