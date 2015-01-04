//
//  MyView.m
//  WiseiPhone
//
//  Created by fcw on 14-7-1.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "MyView.h"

@implementation MyView

{
    BOOL  _isbegin;
    BOOL _selected;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.label = [[UILabel alloc]initWithFrame:CGRectMake(1, self.bounds.size.height-19, self.bounds.size.width-3, 18)];
//        self.label.backgroundColor = [UIColor  colorWithRed:68.0f/255.0f green:127.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
//        //[self addSubview:self.label];
//        self.label.text = @"我的服务器1，视频1(开始播放)";
//        self.label.adjustsFontSizeToFitWidth = YES;
//        self.label.textColor = [UIColor whiteColor];
//        //[self addSubview:self.label];
//        self.label.contentMode=UIViewContentModeScaleAspectFill;
//        self.label.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch * itouch=[touches anyObject];
    if (itouch.tapCount==1) {
        
        if (_selected==YES) {
            _selected=NO;
        }else
        {
            _selected=YES;
        
        }
        _isbegin=YES;
       
        NSNumber * isselect=[NSNumber numberWithBool:YES];
        NSNumber * isbegin=[NSNumber numberWithBool:YES];
        NSNumber *  tag=[NSNumber numberWithInt:(int)self.tag];
        NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:isselect,@"ist",isbegin,@"isb",tag,@"tag", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kx" object:nil userInfo:dict];
        [self setNeedsDisplay];
    }
    if (itouch.tapCount==2) {
        NSLog(@"viewtag=%ld",self.tag);
        NSNumber *  tag=[NSNumber numberWithInt:(int)self.tag];
        NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:tag,@"tag", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doubleclick" object:self userInfo:dict];
    }
    
    
}
- (void)takestate
{
    
    _isbegin=YES;
    _selected=YES;
    [self setNeedsDisplay];

}
- (void)takeoff
{
    _isbegin=YES;
    _selected=NO;
    [self setNeedsDisplay];
}
- (void)drawRectangl
{
    
    if (_selected==YES) {
        CGContextRef ctx=UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, 1.0);
        
//        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.01f green:0.49f blue:0.78f alpha:1.00f].CGColor);
        CGContextSetStrokeColorWithColor(ctx, [UIColor yellowColor].CGColor);
        CGRect rectangle =CGRectMake(self.bounds.origin.x,self.bounds.origin.y, self.frame.size.width, self.frame.size.height);
        
        CGContextAddRect(ctx, rectangle);
        
        CGContextStrokePath(ctx);
    }else{
    
        CGContextRef ctx=UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(ctx, 2.0);
        
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        
        CGRect rectangle =CGRectMake(self.bounds.origin.x,self.bounds.origin.y, self.frame.size.width, self.frame.size.height);
        
        CGContextAddRect(ctx, rectangle);
        
        CGContextStrokePath(ctx);
    
    
    }
    
    
    
}


- (void)drawRect:(CGRect)rect
{
    if (_isbegin==YES) {
        [self drawRectangl];
    }
}


@end
