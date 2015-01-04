//
//  YulanController.h
//  WiseiPhone
//
//  Created by Michelle on 14-6-9.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "RootViewController.h"
#import "KxMovieViewController.h"
#import "QCheckBox.h"
#import "ScaleVideo.h"
#import "YLController.h"
#import "ImageBtn.h"
#import "SocketServer.h"
#import "PaintDraw.h"
#import "Shape.h"
#import "DoublePaint.h"
#import "KxMovieGLView.h"
#import "MyNavigationBar.h"
@class Dbcon;
@class LeftButtonList;
@class ActivityView;
@class Kxmovie;
@class MyView;
@class Rules;
@class MoveView;

@interface YulanController : RootViewController<KxMovieViewControllerDelegate,QCheckBoxDelegate,rootDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,delegateview>
{
    NSString *_lxName;
   
}

@property (nonatomic,strong)NSArray *views;
@property(nonatomic,strong)UIScrollView * optionview;
@property (nonatomic,strong)NSMutableArray *selectedTitle;
@property(nonatomic,strong)UIView * focalView;
@property(nonatomic,strong)UIView * focusView;
@property(nonatomic,strong)UIView * haloView;
@property(nonatomic,strong)UIView * consoleView;
@property(nonatomic,strong)UIView * ruleview1;
@property(nonatomic,strong)UIView * ruleview2;
@property(nonatomic,strong)RootViewController  * rootc;
@property(nonatomic,strong)UIView * movieview;
@property(nonatomic,assign)BOOL isClick;
//@property(nonatomic,strong)KxMovieViewController * video1;
//@property(nonatomic,strong)KxMovieViewController * video2;
//@property(nonatomic,strong)KxMovieViewController * video3;
//@property(nonatomic,strong)KxMovieViewController * video4;
@property(nonatomic,strong)MyView *bfView1;
@property(nonatomic,strong)MyView *bfView2;
@property(nonatomic,strong)MyView *bfView3;
@property(nonatomic,strong)MyView *bfView4;
@property(nonatomic,strong)UILabel *lt1;
@property(nonatomic,strong)UILabel *lt2;
@property(nonatomic,strong)UILabel *lt3;
@property(nonatomic,strong)UILabel *lt4;
@property(nonatomic,strong)UIImageView * focal1;
@property(nonatomic,strong)UIImageView * focal2;
@property(nonatomic,strong)UISlider * slider;
@property(nonatomic,strong)UILabel *litteltitle;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIButton * upbtn;
@property(nonatomic,strong)UIButton * downbtn;
@property(nonatomic,strong)UIButton * leftbtn;
@property(nonatomic,strong)UIButton * rightbtn;
@property(nonatomic,strong)UIPageControl * page;
@property(nonatomic,strong)UIView * backGround;
@property(nonatomic,strong)NSMutableArray *idx;
@property(nonatomic,strong)MoveView * iview;
@property(nonatomic,strong)UIActivityIndicatorView * activityIndicatorView;
@property(nonatomic,strong)UIView * maskview;
@property(nonatomic,strong)PaintDraw * paint1;
@property(nonatomic,strong)PaintDraw * paint2;
@property(nonatomic,strong)PaintDraw * paint3;
@property(nonatomic,strong)PaintDraw * paint4;
@property(nonatomic,strong)DoublePaint * paint5;
@property(nonatomic,strong)DoublePaint * paint6;
@property(nonatomic,strong)DoublePaint * paint7;
@property(nonatomic,strong)DoublePaint * paint8;
@property(nonatomic,strong)MyNavigationBar * mnb;
@end
