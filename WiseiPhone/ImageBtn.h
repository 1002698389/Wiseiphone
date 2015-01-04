//
//  ImageBtn.h
//  WiseiPhone
//
//  Created by fcw on 14-7-17.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBtn : UIImageView
{
    id _target;
    SEL _action;
}
@property(nonatomic,strong)UIImageView * imgv;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,strong)UILabel * nameLab;
- (id)initWithTarget:(id)target action:(SEL)action;
@end
