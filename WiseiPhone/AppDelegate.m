//
//  AppDelegate.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "AppDelegate.h"
#import "YulanController.h"
#import "SocketServer.h"
#import "Getrules.h"
#import "yShi.h"
extern int isinterest;
@implementation AppDelegate
{
    UIImageView * imageview;


}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    YulanController *yu = [[YulanController alloc]init];
    [application setStatusBarHidden:YES];
    UINavigationController * navigate=[[UINavigationController alloc]initWithRootViewController:yu];
    navigate.delegate=self;
    self.window.rootViewController = navigate;
    
    NSUserDefaults * userdf=[NSUserDefaults standardUserDefaults];
    NSString * address=[userdf objectForKey:@"address"];
    int port=[[userdf objectForKey:@"port"] intValue];
    [[Getrules shareRules] updatelinkall];
    if (address.length!=0&&port!=0) {
        [[Getrules shareRules]deleteurlinfo];
        [[Getrules shareRules]deleteoriginfo];
        isinterest=0;
    }

    self.window.rootViewController=yu;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    imageview.image=[UIImage imageNamed:@"JKAloginBg.png"];
    [[application keyWindow] addSubview:imageview];
    [self performSelector:@selector(removetitle) withObject:self afterDelay:1];
    return YES;
}
- (void)removetitle{

    [imageview removeFromSuperview];

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSUserDefaults * usf=[NSUserDefaults standardUserDefaults];
    [usf setObject:@"一" forKey:@"av"];
    [usf synchronize];
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
