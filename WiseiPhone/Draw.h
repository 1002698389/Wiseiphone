//
//  Draw.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Draw : UIView
{
    CGPoint firstPoint;
    CGPoint secondPoint;
    NSMutableArray *pointArray1;
    NSMutableArray *pointArray2;
    NSMutableArray *pointArray3;
    NSMutableArray *pointArray4;
    NSMutableArray *pointAll;
   
}
@property (nonatomic)int type;

@end
