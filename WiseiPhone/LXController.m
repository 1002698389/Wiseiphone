//
//  LXController.m
//  WiseiPhone
//
//  Created by Michelle on 14-5-28.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "LXController.h"
#import "yShi.h"
#import "MyNavigationBar.h"
#import "LuxianController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "KxMovieDecoder.h"
#import "KxAudioManager.h"
#import "KxMovieGLView.h"

static NSMutableDictionary * gHistory;

#define LOCAL_MIN_BUFFERED_DURATION   0.2
#define LOCAL_MAX_BUFFERED_DURATION   0.4
#define NETWORK_MIN_BUFFERED_DURATION 2.0
#define NETWORK_MAX_BUFFERED_DURATION 4.0
@interface LXController ()
{
    KxMovieDecoder      *_decoder;
    dispatch_queue_t    _dispatchQueue;
    NSMutableArray      *_videoFrames;
    NSMutableArray      *_audioFrames;
    NSData              *_currentAudioFrame;
    NSUInteger          _currentAudioFramePos;
    CGFloat             _moviePosition;
    
    NSTimeInterval      _tickCorrectionTime;
    NSTimeInterval      _tickCorrectionPosition;
    BOOL                _interrupted;
    
    KxMovieGLView       *_glView;
    UIImageView         *_imageView;
    
    UIActivityIndicatorView *_activityIndicatorView;
    UILabel             *_subtitlesLabel;
    
    CGFloat             _bufferedDuration;
    CGFloat             _minBufferedDuration;
    CGFloat             _maxBufferedDuration;
    BOOL                _buffered;
    
    NSDictionary        *_parameters;
    
    UIView *_view;
}
@property (readwrite) BOOL playing;
@property (readwrite, strong) KxArtworkFrame *artworkFrame;
@end

@implementation LXController

{
    int y;
    BOOL _isClick;
    UIView *_timeView;
    UILabel *_timeLabel;
    UIView *_scaleView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.21f blue:0.22f alpha:1.00f];
        // Custom initialization
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
        {
            y = 20;
            self.hidesBottomBarWhenPushed = NO;
        }
        else
            self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
+ (void)initialize
{
    if (!gHistory)
        gHistory = [NSMutableDictionary dictionary];
}

+ (id) movieViewControllerWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters
{
    id<KxAudioManager> audioManager = [KxAudioManager audioManager];
    [audioManager activateAudioSession];
    return [[LXController alloc] initWithContentPath: path parameters: parameters];
}

- (id) initWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters
{
    NSAssert(path.length > 0, @"empty path");
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        _moviePosition = 0;
        
        _parameters = parameters;
        
        __weak LXController *weakSelf = self;
        
        KxMovieDecoder *decoder = [[KxMovieDecoder alloc] init];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSError *error = nil;
            [decoder openFile:path error:&error];
            
            __strong LXController *strongSelf = weakSelf;
            if (strongSelf) {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [strongSelf setMovieDecoder:decoder withError:error];
                });
            }
        });
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isClick = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController setNavigationBarHidden:YES];
    MyNavigationBar *mnb = [[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 20+y, SCREEN_WIDTH, 40)];
    [mnb createNavigationBarWithImage:@"录像管理" andLeftButtonImageName:nil andRightButtonImageName:@"JKAtopReturn.png" andSEL:@selector(bbiClick:) andClass:self];
    [self.view addSubview:mnb];
    
    
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 90, 320, 280)];
    _view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_view];
    
    if (self.playing == NO)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.frame = CGRectMake(140, 120, 40, 40);
        _activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [_view addSubview:_activityIndicatorView];
    }else
    {
        [_activityIndicatorView stopAnimating];
    }
    
    //时间轴
    _timeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-86+y, SCREEN_WIDTH, 50)];
    _timeView.backgroundColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
    [self.view addSubview:_timeView];
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 0, 200, 30)];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.text = @"2014-08-13 21:15:21";
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:17];
    [_timeView addSubview:_timeLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 2)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_timeView addSubview:lineView];
    UIView *times = [[UIView alloc]initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, 18)];
    times.backgroundColor = [UIColor blackColor];
    [_timeView addSubview:times];
    NSArray *timeArray = [[NSArray alloc]initWithObjects:@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];
    for (int i=0; i<5; i++)
    {
        UILabel *schedule = [[UILabel alloc]initWithFrame:CGRectMake(10+i*60, 2, 36, 14)];
        schedule.backgroundColor = [UIColor clearColor];
        schedule.text = timeArray[i];
        schedule.textAlignment = NSTextAlignmentCenter;
        schedule.font = [UIFont systemFontOfSize:11];
        schedule.textColor = [UIColor whiteColor];
        [times addSubview:schedule];
    }
    _scaleView = [[UIView alloc]initWithFrame:CGRectMake(159, 0, 2, 50)];
    _scaleView.backgroundColor = [UIColor colorWithRed:0.00f green:0.52f blue:0.81f alpha:1.00f];
    [_timeView addSubview:_scaleView];
    
    //选项条
    UIScrollView *optionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, 320, 40)];
    optionView.backgroundColor = [UIColor colorWithRed:0.15f green:0.16f blue:0.18f alpha:1.00f];
    optionView.contentSize = CGSizeMake(64*6, 40);
    optionView.showsVerticalScrollIndicator = NO;
    optionView.pagingEnabled = NO;
    [self.view addSubview:optionView];
    NSMutableArray *opImage = [[NSMutableArray alloc]initWithObjects:@"JKAbottomJP.png",@"JKAbottomJQ.png",@"JKAbottomZT.png",@"JKAbottomSYoff.png",@"JKAbottomFD.png", nil];
    NSMutableArray *opImageSelected = [[NSMutableArray alloc]initWithObjects:@"",@"",@"JKAbottomBF.png",@"JKAbottomSYon.png",@"JKAbottomSX.png", nil];
    for (int i=0; i<[opImage count]; i++)
    {
        UIButton *opBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        opBtn.frame = CGRectMake(12+i*64, 0, 40, 40);
        opBtn.backgroundColor = [UIColor clearColor];
        [opBtn setImage:[UIImage imageNamed:[opImage objectAtIndex:i]] forState:UIControlStateNormal];
        [opBtn setImage:[UIImage imageNamed:[opImageSelected objectAtIndex:i]] forState:UIControlStateSelected];
        opBtn.tag = 11+i;
        [opBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [optionView addSubview:opBtn];
    }
}
- (void)bbiClick:(UIButton *)btn
{
//    LuxianController *lu = [[LuxianController alloc]init];
    CATransition *ca = [CATransition animation];
    ca.delegate = self;
    ca.type = @"cube";
    ca.subtype = @"fromBottom";
    ca.timingFunction = UIViewAnimationCurveEaseInOut;
    ca.duration = 0.3;
    ca.startProgress = 0;
    ca.endProgress = 1;
    [self.view.window.layer addAnimation:ca forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
//    [self.navigationController pushViewController:lu animated:YES];
    
}
- (void)sliderChange:(UISlider *)slider
{
    
}
# pragma mark - UIButton方法
- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 13)
    {
        if (self.playing)
            [self pause];
        else
            [self play];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.playing) {
        
        [self pause];
        [self freeBufferedFrames];
        
        if (_maxBufferedDuration > 0) {
            
            _minBufferedDuration = _maxBufferedDuration = 0;
            [self play];
            
            NSLog(@"didReceiveMemoryWarning, disable buffering and continue playing");
            
        } else {
            // force ffmpeg to free allocated memory
            [_decoder closeFile];
            [_decoder openFile:nil error:nil];
            
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failure", nil)
                                        message:NSLocalizedString(@"Out of memory", nil)
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Close", nil)
                              otherButtonTitles:nil] show];
        }
        
    } else {
        
        [self freeBufferedFrames];
        [_decoder closeFile];
        [_decoder openFile:nil error:nil];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    // NSLog(@"viewDidAppear");
    
    [super viewDidAppear:animated];
    
    if (_decoder)
    {
        [self restorePlay];
    } else
    {
        [_activityIndicatorView startAnimating];
    }
}
#pragma mark - public
-(void) play
{
    self.playing = YES;
    _interrupted = NO;
    
    _tickCorrectionTime = 0;
    
    [self asyncDecodeFrames];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self tick];
    });
    
    NSLog(@"play movie");
}

- (void) pause
{
    self.playing = NO;
}

- (void) setMoviePosition: (CGFloat) position
{
    BOOL playMode = self.playing;
    
    self.playing = NO;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self updatePosition:position playMode:playMode];
    });
}
#pragma mark - private
- (void) setMovieDecoder: (KxMovieDecoder *) decoder
               withError: (NSError *) error
{
    NSLog(@"setMovieDecoder");
    
    if (!error && decoder)
    {
        _decoder        = decoder;
        _dispatchQueue  = dispatch_queue_create("KxMovie", DISPATCH_QUEUE_SERIAL);
        _videoFrames    = [NSMutableArray array];
        _audioFrames    = [NSMutableArray array];
        
        if (self.isViewLoaded) {
            
            [self setupPresentView];
            
            if (_activityIndicatorView.isAnimating)
            {
                [_activityIndicatorView stopAnimating];
                [self restorePlay];
            }
        }
    } else
    {
        if (self.isViewLoaded && self.view.window)
        {
            [_activityIndicatorView stopAnimating];
            if (!_interrupted)
                [self handleDecoderMovieError: error];
        }
    }
}
- (void) restorePlay
{
    NSNumber *n = [gHistory valueForKey:_decoder.path];
    if (n)
        [self updatePosition:n.floatValue playMode:YES];
    else
        [self play];
}
- (void) setupPresentView
{
    
    if (_decoder.validVideo) {
        _glView = [[KxMovieGLView alloc] initWithFrame:CGRectMake(0, 0, 320, 280) decoder:_decoder];
    }
    if (!_glView)
    {
        NSLog(@"fallback to use RGB video frame and UIKit");
        [_decoder setupVideoFrameFormat:KxVideoFrameFormatRGB];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 280)];
    }
    UIView *frameView = [self frameView];
    frameView.contentMode = UIViewContentModeScaleAspectFill;
    frameView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    [_view insertSubview:frameView atIndex:0];
}
- (UIView *) frameView
{
    return _glView ? _glView : _imageView;
    
}
- (void) audioCallbackFillData: (float *) outData
                     numFrames: (UInt32) numFrames
                   numChannels: (UInt32) numChannels
{
    //fillSignalF(outData,numFrames,numChannels);
    //return;
    
    if (_buffered) {
        memset(outData, 0, numFrames * numChannels * sizeof(float));
        return;
    }
    
    @autoreleasepool
    {
        
        while (numFrames > 0)
        {
            if (!_currentAudioFrame)
            {
                @synchronized(_audioFrames)
                {
                    NSUInteger count = _audioFrames.count;
                    if (count > 0)
                    {
                        KxAudioFrame *frame = _audioFrames[0];
                        if (_decoder.validVideo)
                        {
                            const CGFloat delta = _moviePosition - frame.position;
                            if (delta < -2.0)
                            {
                                memset(outData, 0, numFrames * numChannels * sizeof(float));
                                break; // silence and exit
                            }
                            [_audioFrames removeObjectAtIndex:0];
                        } else
                        {
                            [_audioFrames removeObjectAtIndex:0];
                            _moviePosition = frame.position;
                            _bufferedDuration -= frame.duration;
                        }
                        _currentAudioFramePos = 0;
                        _currentAudioFrame = frame.samples;
                    }
                }
            }
            if (_currentAudioFrame)
            {
                const void *bytes = (Byte *)_currentAudioFrame.bytes + _currentAudioFramePos;
                const NSUInteger bytesLeft = (_currentAudioFrame.length - _currentAudioFramePos);
                const NSUInteger frameSizeOf = numChannels * sizeof(float);
                const NSUInteger bytesToCopy = MIN(numFrames * frameSizeOf, bytesLeft);
                const NSUInteger framesToCopy = bytesToCopy / frameSizeOf;
                
                memcpy(outData, bytes, bytesToCopy);
                numFrames -= framesToCopy;
                outData += framesToCopy * numChannels;
                
                if (bytesToCopy < bytesLeft)
                    _currentAudioFramePos += bytesToCopy;
                else
                    _currentAudioFrame = nil;
                
            } else
            {
                memset(outData, 0, numFrames * numChannels * sizeof(float));
                break;
            }
        }
    }
}
- (BOOL) addFrames: (NSArray *)frames
{
    if (_decoder.validVideo) {
        
        @synchronized(_videoFrames) {
            
            for (KxMovieFrame *frame in frames)
                if (frame.type == KxMovieFrameTypeVideo) {
                    [_videoFrames addObject:frame];
                    _bufferedDuration += frame.duration;
                }
        }
    }
    
    if (_decoder.validAudio) {
        
        @synchronized(_audioFrames) {
            
            for (KxMovieFrame *frame in frames)
                if (frame.type == KxMovieFrameTypeAudio) {
                    [_audioFrames addObject:frame];
                    if (!_decoder.validVideo)
                        _bufferedDuration += frame.duration;
                }
        }
        if (!_decoder.validVideo) {
            
            for (KxMovieFrame *frame in frames)
                if (frame.type == KxMovieFrameTypeArtwork)
                    self.artworkFrame = (KxArtworkFrame *)frame;
        }
    }
    return self.playing && _bufferedDuration < _maxBufferedDuration;
}

- (BOOL) decodeFrames
{
    //NSAssert(dispatch_get_current_queue() == _dispatchQueue, @"bugcheck");
    
    NSArray *frames = nil;
    
    if (_decoder.validVideo ||
        _decoder.validAudio) {
        
        frames = [_decoder decodeFrames:0];
    }
    
    if (frames.count) {
        return [self addFrames: frames];
    }
    return NO;
}

- (void) asyncDecodeFrames
{
    __weak LXController *weakSelf = self;
    __weak KxMovieDecoder *weakDecoder = _decoder;
    
    const CGFloat duration = _decoder.isNetwork ? .0f : 0.1f;
    
    dispatch_async(_dispatchQueue, ^{
        
        {
            __strong LXController *strongSelf = weakSelf;
            if (!strongSelf.playing)
                return;
        }
        
        BOOL good = YES;
        while (good) {
            
            good = NO;
            
            @autoreleasepool {
                
                __strong KxMovieDecoder *decoder = weakDecoder;
                
                if (decoder && (decoder.validVideo || decoder.validAudio)) {
                    
                    NSArray *frames = [decoder decodeFrames:duration];
                    if (frames.count) {
                        
                        __strong LXController *strongSelf = weakSelf;
                        if (strongSelf)
                            good = [strongSelf addFrames:frames];
                    }
                }
            }
        }
    });
}

- (void) tick
{
    if (_buffered && ((_bufferedDuration > _minBufferedDuration) || _decoder.isEOF)) {
        
        _tickCorrectionTime = 0;
        _buffered = NO;
        [_activityIndicatorView stopAnimating];
    }
    
    CGFloat interval = 0;
    if (!_buffered)
        interval = [self presentFrame];
    
    if (self.playing) {
        
        const NSUInteger leftFrames =
        (_decoder.validVideo ? _videoFrames.count : 0) +
        (_decoder.validAudio ? _audioFrames.count : 0);
        
        if (0 == leftFrames) {
            
            if (_decoder.isEOF) {
                
                [self pause];
                return;
            }
            
            if (_minBufferedDuration > 0 && !_buffered) {
                
                _buffered = YES;
                [_activityIndicatorView startAnimating];
            }
        }
        
        if (!leftFrames ||
            !(_bufferedDuration > _minBufferedDuration)) {
            
            [self asyncDecodeFrames];
        }
        
        const NSTimeInterval correction = [self tickCorrection];
        const NSTimeInterval time = MAX(interval + correction, 0.01);
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self tick];
        });
    }
}

- (CGFloat) tickCorrection
{
    if (_buffered)
        return 0;
    
    const NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    
    if (!_tickCorrectionTime) {
        
        _tickCorrectionTime = now;
        _tickCorrectionPosition = _moviePosition;
        return 0;
    }
    
    NSTimeInterval dPosition = _moviePosition - _tickCorrectionPosition;
    NSTimeInterval dTime = now - _tickCorrectionTime;
    NSTimeInterval correction = dPosition - dTime;
    
    if (correction > 1.f || correction < -1.f) {
        
        NSLog(@"tick correction reset %.2f", correction);
        correction = 0;
        _tickCorrectionTime = 0;
    }
    
    return correction;
}

- (CGFloat) presentFrame
{
    CGFloat interval = 0;
    
    if (_decoder.validVideo) {
        
        KxVideoFrame *frame;
        
        @synchronized(_videoFrames) {
            
            if (_videoFrames.count > 0) {
                
                frame = _videoFrames[0];
                [_videoFrames removeObjectAtIndex:0];
                _bufferedDuration -= frame.duration;
            }
        }
        
        if (frame)
            interval = [self presentVideoFrame:frame];
        
    }
    else if (_decoder.validAudio) {
        
        //interval = _bufferedDuration * 0.5;
        
        if (self.artworkFrame) {
            
            _imageView.image = [self.artworkFrame asImage];
            self.artworkFrame = nil;
        }
    }
    return interval;
}
#pragma mark - 显示视频
- (CGFloat) presentVideoFrame: (KxVideoFrame *) frame
{
    if (_glView)
        
        [_glView render:frame];
    
    else
    {
        KxVideoFrameRGB *rgbFrame = (KxVideoFrameRGB *)frame;
        _imageView.image = [rgbFrame asImage];
    }
    
    _moviePosition = frame.position;
    
    return frame.duration;
}

- (void) setMoviePositionFromDecoder
{
    _moviePosition = _decoder.position;
}
- (void) setDecoderPosition: (CGFloat) position
{
    _decoder.position = position;
}
- (void) updatePosition: (CGFloat) position
               playMode: (BOOL) playMode
{
    [self freeBufferedFrames];
    
    position = MIN(_decoder.duration - 1, MAX(0, position));
    
    __weak LXController *weakSelf = self;
    
    dispatch_async(_dispatchQueue, ^{
        
        if (playMode) {
            {
                __strong LXController *strongSelf = weakSelf;
                if (!strongSelf) return;
                [strongSelf setDecoderPosition: position];
            }
        } else {
            {
                __strong LXController *strongSelf = weakSelf;
                if (!strongSelf) return;
                [strongSelf setDecoderPosition: position];
                [strongSelf decodeFrames];
            }
        }
    });
}
- (void) freeBufferedFrames
{
    @synchronized(_videoFrames) {
        [_videoFrames removeAllObjects];
    }
    
    @synchronized(_audioFrames) {
        
        [_audioFrames removeAllObjects];
        _currentAudioFrame = nil;
    }
    _bufferedDuration = 0;
}
- (void) handleDecoderMovieError: (NSError *) error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failure", nil)
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Close", nil)
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_timeView];
    _scaleView.frame = CGRectMake(point.x, 0, 2, 50);
    
//    _timeLabel.text = [NSString stringWithFormat:@"2014-06-13"];
}

@end
