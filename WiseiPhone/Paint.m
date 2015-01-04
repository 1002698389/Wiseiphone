//
//  Paint.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-11-25.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Paint.h"

@implementation Paint

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
   
    if (self.begin==1) {
        [self allKindsShapes];
    }
   

}


- (void)allKindsShapes{
    
    if (self.shapes.count>0) {
        for (int i=0; i<self.shapes.count; i++) {
            Shape * sp=[self.shapes objectAtIndex:i];
            if ([sp.name isEqualToString:@"警戒线"]||[sp.name isEqualToString:@"运动物体计数"]) {
                CGPoint begin=[[sp.points objectAtIndex:0] CGPointValue];
                CGPoint first;
                first.x=begin.x*156/320;
                first.y=begin.y*139/300;
                CGPoint end=[[sp.points objectAtIndex:1]CGPointValue];
                CGPoint last;
                last.x=end.x*156/320;
                last.y=end.y*139/300;
                [self drawLine:first two:last];
                
            }
            if ([sp.name isEqualToString:@"进入指定区域"]||[sp.name isEqualToString:@"区域内物体失窃"]||[sp.name isEqualToString:@"车辆停止"]||[sp.name isEqualToString:@"车辆离开"]||[sp.name isEqualToString:@"区域内物体遗留"]) {
                CGPoint begin=[[sp.points objectAtIndex:0] CGPointValue];
                CGPoint first;
                first.x=begin.x*156/320;
                first.y=begin.y*139/300;
                CGPoint end=[[sp.points objectAtIndex:1]CGPointValue];
                CGPoint last;
                last.x=end.x*156/320;
                last.y=end.y*139/300;
                [self drawRectangle:first two:last];
            }
            if ([sp.name isEqualToString:@"双重警戒线"]) {
                [self drawduplet:sp.points];
            }
           
        }
    }
    
    
}
- (void)drawLine:(CGPoint)one two:(CGPoint)two
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, one.x,one.y );
    CGContextAddLineToPoint(context, two.x, two.y);
    CGContextDrawPath(context, kCGPathStroke);
    
}
- (void)drawduplet:(NSMutableArray*)points
{
    if (points.count==4) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 2.0);
        CGPoint point1 = [[points objectAtIndex:0]CGPointValue];
        CGPoint point2 = [[points objectAtIndex:1]CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGPoint point3=[[points objectAtIndex:2]CGPointValue];
        CGPoint point4=[[points objectAtIndex:3]CGPointValue];
        CGContextMoveToPoint(context, point3.x, point3.y);
        CGContextAddLineToPoint(context, point4.x, point4.y);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    
    
    
}
- (void)drawRectangle:(CGPoint)one two:(CGPoint)two
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGRect rectangle =CGRectMake(one.x,one.y, two.x-two.x, two.y-one.y);
    
    CGContextAddRect(ctx, rectangle);
    
    CGContextStrokePath(ctx);
    
}
@end
