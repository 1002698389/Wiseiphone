//
//  MoveView.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-18.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "MoveView.h"
#import "AppDelegate.h"
#import "BaojingController.h"
#import "YulanController.h"
#import "ZhinengController.h"
#import "SocketServer.h"
@implementation MoveView
{
    CGPoint startPoint;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=25;
        self.layer.masksToBounds=YES;
        
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  //  保存触摸起始点位置
//    CGPoint point = [[touches anyObject] locationInView:self];
//    startPoint = point;
//    
//    //该view置于最前
//    [[self superview] bringSubviewToFront:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
//    CGPoint point = [[touches anyObject] locationInView:self];
//    float dx = point.x - startPoint.x;
//    float dy = point.y - startPoint.y;
//    
//    //计算移动后的view中心点
//    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
////
////    
////    /* 限制用户不可将视图托出屏幕 */
//    float halfx = CGRectGetMidX(self.bounds);
//    //x坐标左边界
//    newcenter.x = MAX(halfx, newcenter.x);
//    //x坐标右边界
//    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
//    
//    //y坐标同理
//    float halfy = CGRectGetMidY(self.bounds);
//    newcenter.y = MAX(halfy, newcenter.y);
//    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
//    
//    //移动view
//    self.center = newcenter;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    if (touch.tapCount==1) {

//        if ([[SocketServer shareSocket].isConnect isEqualToString:@"失败"]) {
//            NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//            NSString * netaddr=[user objectForKey:@"address"];
//            int netport=[[user objectForKey:@"port"] intValue];
//            [[SocketServer shareSocket] setupConnection:netaddr port:netport];
//        }
 //      BaojingController * baoj=[[BaojingController alloc]init];
//        UIViewController* curctrl=[self curcontroller];
//       [[[UIApplication sharedApplication] keyWindow] addSubview:curctrl.view];
//
 //   [self.cont presentViewController:baoj animated:YES completion:nil];
 //[[NSNotificationCenter defaultCenter] postNotificationName:@"changecontrol" object:self];
        [self pushnextview];
        //[self removeFromSuperview];
//        NSLog(@"%@",curctrl);
//        if ([curctrl isKindOfClass:[BaojingController class]]) {
//            NSLog(@"点击了我");
//          
//        }else{
//            UIViewController * control=[[UIApplication sharedApplication] keyWindow].rootViewController;
//            
//           [control presentViewController:baoj animated:NO completion:nil];
//        }
        
    }

}
- (void)pushnextview{

    [self.iviewdelegate presentviewnext];

}
- (UIViewController*)curcontroller
{
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[RootViewController class]])
    {
        result = nextResponder;
      result=window.rootViewController;
    }
    else{
        result = window.rootViewController;
    }
    return result;
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
