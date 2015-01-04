//
//  NewViewController.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-12-2.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "NewViewController.h"
#import "MoveView.h"
#import "BaojingController.h"
@interface NewViewController ()

@end

@implementation NewViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      
    // Do any additional setup after loading the view.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch * touch=[touches anyObject];
    if (touch.tapCount==1) {
        NSLog(@"跳转到别的地方");
        BaojingController * bj=[[BaojingController alloc]init];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:bj animated:YES completion:nil];
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
