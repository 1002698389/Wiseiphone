//
//  DoublePaint.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-12-6.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "DoublePaint.h"
#import "Shape.h"
@implementation DoublePaint

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
    CGFloat width=self.iframe.size.width;
    CGFloat height=self.iframe.size.height;
    if (self.shapes.count>0) {
        for (int i=0; i<self.shapes.count; i++) {
            Shape * sp=[self.shapes objectAtIndex:i];
            if ([sp.name isEqualToString:@"警戒线"]||[sp.name isEqualToString:@"运动物体计数"]) {
                CGPoint begin=[[sp.points objectAtIndex:0] CGPointValue];
                CGPoint first;
                first.x=begin.x*width/320;
                first.y=begin.y*height/300;
                CGPoint end=[[sp.points objectAtIndex:1]CGPointValue];
                CGPoint last;
                last.x=end.x*width/320;
                last.y=end.y*height/300;
                [self drawLine:first two:last isenable:[[self.isenable objectAtIndex:i] intValue]];
                NSLog(@"执行划线");
            }
            if ([sp.name isEqualToString:@"进入指定区域"]||[sp.name isEqualToString:@"区域内物体失窃"]||[sp.name isEqualToString:@"车辆停止"]||[sp.name isEqualToString:@"车辆离开"]||[sp.name isEqualToString:@"区域内物体遗留"]) {
                CGPoint begin=[[sp.points objectAtIndex:0] CGPointValue];
                CGPoint first;
                first.x=begin.x*width/320;
                first.y=begin.y*height/300;
                CGPoint end=[[sp.points objectAtIndex:1]CGPointValue];
                CGPoint last;
                last.x=end.x*width/320;
                last.y=end.y*height/300;
                [self drawRectangle:first two:last isenable:[[self.isenable objectAtIndex:i] intValue]];
            }
            if ([sp.name isEqualToString:@"双重警戒线"]) {
                [self drawduplet:sp.points isenable:[[self.isenable objectAtIndex:i] intValue]];
            }
            
        }
    }
    
    
}
- (void)drawLine:(CGPoint)one two:(CGPoint)two isenable:(int)isenable
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isenable==1) {
         CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    }else{
    
         CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    }
   
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, one.x,one.y );
    CGContextAddLineToPoint(context, two.x, two.y);
    CGContextDrawPath(context, kCGPathStroke);
    
}
- (void)drawduplet:(NSMutableArray*)points isenable:(int)isenable
{
    if (points.count==4) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (isenable==1) {
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        }else{
            
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        }
     
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
- (void)drawRectangle:(CGPoint)one two:(CGPoint)two isenable:(int)isenable
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextStrokePath(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isenable==1) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    }else{
        
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    }
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeRect(context, CGRectMake(one.x, one.y, (two.x-one.x), (two.y-one.y)));
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch * touch=[touches anyObject];
    if (touch.tapCount==2) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isdouble" object:self];
        
    }



}
@end
