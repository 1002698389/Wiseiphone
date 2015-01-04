//
//  TestController.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-27.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "TestController.h"
#import "MyNavigationBar.h"
#import "yShi.h"
#import "BaojingController.h"
#import "TiyanController.h"
@interface TestController ()
{
 // MyNavigationBar *mnb;

}
@end

@implementation TestController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
   // self.mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [self.mnb createNavigationBarWithImage:self.ititle andLeftButtonImageName:@"" andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:self.mnb];
    NSURL *pathUrl=[NSURL fileURLWithPath:self.path];
    //   NSURL *pathUrl=[NSURL URLWithString:@"http://jq.v.ismartv.tv/cdn/1/81/95e68bbdce46b5b8963b504bf73d1b/normal/slice/index.m3u8"];
    self.player =[[MPMoviePlayerController alloc] initWithContentURL:pathUrl];
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay=YES;
    [self.player setControlStyle:MPMovieControlStyleDefault];
    self.player.view.frame=CGRectMake(0, 60, 320, SCREEN_HEIGHT-60);
  
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(baojing) name:@"changecontrol" object:nil];
    
//  MPMoviePlayerController *player1 =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//    [player1 prepareToPlay];
//    [self.view addSubview:player1.view];//设置写在添加之后
//    player1.shouldAutoplay=YES;
//    [player1 setControlStyle:MPMovieControlStyleFullscreen];
//    [player1.view setFrame:self.view.bounds];
//    [player1 play];
}
//- (void)play
//{
//    NSURL *pathUrl=[NSURL fileURLWithPath:self.path];
//     //   NSURL *pathUrl=[NSURL URLWithString:@"http://jq.v.ismartv.tv/cdn/1/81/95e68bbdce46b5b8963b504bf73d1b/normal/slice/index.m3u8"];
//    self.player =[[MPMoviePlayerController alloc] initWithContentURL:pathUrl];
//    [self.player prepareToPlay];
//    [self.view addSubview:self.player.view];
//    self.player.shouldAutoplay=YES;
//    [self.player setControlStyle:MPMovieControlStyleDefault];
//    self.player.view.frame=CGRectMake(0, 60, 320, SCREEN_HEIGHT-60);
//
//
//}
- (MyNavigationBar*)mnb{
    if (!_mnb) {
        _mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60)];
    }
    return _mnb;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baojing{

    BaojingController * baojin=[[BaojingController alloc]init];
    [self presentViewController:baojin animated:NO completion:nil];
}

- (void)bbiClick:(UIButton*)btn
{
  
    if (btn.tag==1) {
        TiyanController * tiy=[[TiyanController alloc]init];
        CATransition *ca = [CATransition animation];
        ca.delegate = self;
        ca.type = @"cube";
        ca.subtype = @"fromBottom";
        ca.timingFunction = UIViewAnimationCurveEaseInOut;
        ca.duration = 0.3;
        ca.startProgress = 0;
        ca.endProgress = 1;
        [self.view.window.layer addAnimation:ca forKey:nil];
        [self presentViewController:tiy animated:NO completion:nil];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
