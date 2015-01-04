//
//  Draw.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Draw.h"
#import "yShi.h"

@implementation Draw
{
    NSString *point1x;
    NSString *point1y;
    NSString *point2x;
    NSString *point2y;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        pointArray1 = [[NSMutableArray alloc]init];
        pointArray2 = [[NSMutableArray alloc]init];
        pointArray3 = [[NSMutableArray alloc]init];
        pointArray4 = [[NSMutableArray alloc]init];
        pointAll=[NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (_type == Mongline)
    {
        [self mongLine];
        
       // [self drawMulines];
        [self drawLines];
    }
    if (_type == Duplet)
    {
        [self duplet];
        [self drawLines];
    }
    if (_type == Orthogon)
    {
        [self orthogon];
    }
    if (_type == Erose)
    {
        [self erose];
    }
}
- (void)drawMulines
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    if ([pointArray2 count]>2 && [pointArray2 count]<=100)
    {
        CGPoint point1 = [[pointArray2 objectAtIndex:0]CGPointValue];
        CGPoint point2 = [[pointArray2 objectAtIndex:1]CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextDrawPath(context, kCGPathStroke);
    }else if ([pointArray2 count]>100)
    {
        [pointArray2 removeObjectAtIndex:0];
        [pointArray2 removeObjectAtIndex:0];
    }
    
}
- (void)drawLines
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, firstPoint.x,firstPoint.y );
    CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
    CGContextDrawPath(context, kCGPathStroke);
}
//单线
- (void)mongLine
{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
   
    if ([pointArray1 count]==2)
    {
        CGPoint point1 = [[pointArray1 objectAtIndex:0]CGPointValue];
        
       
        CGPoint point2 = [[pointArray1 objectAtIndex:1]CGPointValue];
      
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextDrawPath(context, kCGPathStroke);
    }else if ([pointArray1 count]>2)
    {
        [pointArray1 removeObjectAtIndex:0];
        [pointArray1 removeObjectAtIndex:0];
    }
   

}
//双线
- (void)duplet
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    if ([pointArray2 count]>2 && [pointArray2 count]<=4)
    {
        CGContextSaveGState(context);
        CGPoint point1 = [[pointArray2 objectAtIndex:0]CGPointValue];
        CGPoint point2 = [[pointArray2 objectAtIndex:1]CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextDrawPath(context, kCGPathStroke);
    }else if ([pointArray2 count]>4)
    {
        [pointArray2 removeObjectAtIndex:0];
        [pointArray2 removeObjectAtIndex:0];
    }
    
}
//矩形
- (void)orthogon
{
 
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    if ([pointArray3 count]<=2)
    {
        CGContextStrokeRect(context, CGRectMake(firstPoint.x, firstPoint.y, (secondPoint.x-firstPoint.x), (secondPoint.y-firstPoint.y)));
        
    }else if ([pointArray3 count]>2)
    {
        [pointArray3 removeObjectAtIndex:0];
        [pointArray3 removeObjectAtIndex:0];
    }
    
}
- (void)erose
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, [[pointArray4 objectAtIndex:0]CGPointValue].x, [[pointArray4 objectAtIndex:0]CGPointValue].y);
    
    for (int i = 1; i <[pointArray4 count]; i++)
    {
        
        CGContextAddLineToPoint(context, [[pointArray4 objectAtIndex:i]CGPointValue].x, [[pointArray4 objectAtIndex:i]CGPointValue].y);
    }
    
    CGContextAddLineToPoint(context, [[pointArray4 objectAtIndex:0]CGPointValue].x, [[pointArray4 objectAtIndex:0]CGPointValue].y);
    
    CGContextDrawPath(context, kCGPathStroke);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [pointAll addObject:[NSValue valueWithCGPoint:firstPoint]];
    
    if (_type == Mongline)
    {
        firstPoint = point;
        point1x=nil;
        point1y=nil;
        point1x=[NSString stringWithFormat:@"%f",point.x];
        point1y=[NSString stringWithFormat:@"%f",point.y];
        [pointArray1 addObject:[NSValue valueWithCGPoint:firstPoint]];
    }
    if (_type == Duplet)
    {
        firstPoint = point;
        [pointArray2 addObject:[NSValue valueWithCGPoint:firstPoint]];
    }
    if (_type == Orthogon)
    {
        point1x=nil;
        point1y=nil;
        point1x=[NSString stringWithFormat:@"%f",point.x];
        point1y=[NSString stringWithFormat:@"%f",point.y];
        firstPoint = point;
        [pointArray3 addObject:[NSValue valueWithCGPoint:firstPoint]];
    }
    else
        return ;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
   

    if (point.x<0)
        point.x = 0;
    if (point.x >320)
        point.x = 320;
    if (point.y < 0)
        point.y = 0;
    if (point.y>300)
        point.y=300;
    secondPoint = point;
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    
    if (_type == Mongline)
    {
        point = secondPoint;
        point2x=nil;
        point2y=nil;
        point2x=[NSString stringWithFormat:@"%f",point.x];
        point2y=[NSString stringWithFormat:@"%f",point.y];
        [pointArray1 addObject:[NSValue valueWithCGPoint:point]];
        [pointAll addObject:[NSValue valueWithCGPoint:point]];
    }
    if (_type == Duplet)
    {
        point = secondPoint;
        [pointArray2 addObject:[NSValue valueWithCGPoint:point]];
    }
    if (_type == Orthogon)
    {
        point = secondPoint;
        [pointArray3 addObject:[NSValue valueWithCGPoint:point]];
        point2x=nil;
        point2y=nil;
        point2x=[NSString stringWithFormat:@"%f",point.x];
        point2y=[NSString stringWithFormat:@"%f",point.y];
    }
    if (_type == Erose)
    {
        [pointArray4 addObject:[NSValue valueWithCGPoint:point]];
        
    }
    
//         [pointall addObject:[NSValue valueWithCGPoint:point]];
//        NSLog(@"allpoint=%@",pointall);
    
    [self setNeedsDisplay];
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:point1x,@"fx",point1y,@"fy",point2x,@"ex",point2y,@"ey",nil];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"mongline" object:self userInfo:dict];
    NSDictionary * dict2=[NSDictionary dictionaryWithObjectsAndKeys:point1x,@"fx",point1y,@"fy",point2x,@"ex",point2y,@"ey",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orthogon" object:self userInfo:dict2];
}

@end
