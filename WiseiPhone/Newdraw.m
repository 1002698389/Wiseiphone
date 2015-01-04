//
//  Newdraw.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-8-1.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Newdraw.h"

@implementation Newdraw

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, self.first.x,self.first.y );
    CGContextAddLineToPoint(context, self.end.x, self.end.y);
    CGContextDrawPath(context, kCGPathStroke);

}
- (void)drawduplet
{
   


}
- (void)drawRectangle
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGRect rectangle =CGRectMake(self.first.x,self.first.y, self.end.x-self.first.x, self.end.y-self.first.y);
    
    CGContextAddRect(ctx, rectangle);
    
    CGContextStrokePath(ctx);

}
- (void)drawRect:(CGRect)rect
{
    if ([self.drawName isEqualToString:@"警戒线"]) {
        [self drawLine];
    }
    if ([self.drawName isEqualToString:@"进入指定区域"]) {
        [self drawRectangle];
    }
    if ([self.drawName isEqualToString:@"区域内物体失窃"]) {
        [self drawRectangle];
    }
    if ([self.drawName isEqualToString:@"运动物体计数"]) {
        [self drawLine];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
