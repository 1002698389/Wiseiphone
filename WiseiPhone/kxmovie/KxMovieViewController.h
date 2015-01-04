//
//  ViewController.h
//  kxmovieapp
//
//  Created by Kolyvan on 11.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import <UIKit/UIKit.h>
@class KxMovieDecoder;
@class KxMovieGLView;
extern NSString * const KxMovieParameterMinBufferedDuration;    // Float
extern NSString * const KxMovieParameterMaxBufferedDuration;    // Float
extern NSString * const KxMovieParameterDisableDeinterlacing;   // BOOL

@protocol KxMovieViewControllerDelegate <NSObject>

- (void)clickTap:(UIViewController *)viewController;

@end

@interface KxMovieViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

+ (id) movieViewControllerWithContentPath: (NSString *) path
                               parameters: (NSDictionary *) parameters;

@property (nonatomic,weak)id <KxMovieViewControllerDelegate> delegate;
@property (readonly) BOOL playing;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)KxMovieGLView * glView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)NSString * path;
- (void) play;
- (void) pause;
- (void) deleteself;
- (void) clearBuffer;
@end
