//
//  VideoController.m
//  WiseiPhone
//
//  Created by Michelle on 14-6-12.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "VideoController.h"
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


@interface VideoController ()
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
    UITapGestureRecognizer *_doubleTapGestureRecognizer;
    UIActivityIndicatorView *_activityIndicatorView;
    UILabel             *_subtitlesLabel;
    
    CGFloat             _bufferedDuration;
    CGFloat             _minBufferedDuration;
    CGFloat             _maxBufferedDuration;
    BOOL                _buffered;
    
    NSDictionary        *_parameters;
    
}
@property (readwrite) BOOL playing;
@property (readwrite, strong) KxArtworkFrame *artworkFrame;
@end

@implementation VideoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    return [[VideoController alloc] initWithContentPath: path parameters: parameters];
}

- (id) initWithContentPath: (NSString *) path parameters: (NSDictionary *) parameters
{
    NSAssert(path.length > 0, @"empty path");
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        _moviePosition = 0;
        
        _parameters = parameters;
        
        __weak VideoController *weakSelf = self;
        
        KxMovieDecoder *decoder = [[KxMovieDecoder alloc] init];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSError *error = nil;
            [decoder openFile:path error:&error];
            
            __strong VideoController *strongSelf = weakSelf;
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
    
    self.view.backgroundColor = [UIColor blackColor];
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.center = self.view.center;
    _activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_activityIndicatorView];
    
    _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:_doubleTapGestureRecognizer];

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
- (void) handleTap: (UITapGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
         if (sender == _doubleTapGestureRecognizer)
         {
            UIView *frameView = [self frameView];
            
            if (frameView.contentMode == UIViewContentModeScaleAspectFit)
                frameView.contentMode = UIViewContentModeScaleAspectFill;
            else
                frameView.contentMode = UIViewContentModeScaleAspectFit;
            
        }
    }
}

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
- (void) playDidTouch: (id) sender
{
    if (self.playing)
        [self pause];
    else
        [self play];
}
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
        
        //            _bottomHUD.hidden       = NO;
        //            _leftLabel.hidden       = NO;
        //            _infoButton.hidden      = NO;
        
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
        _glView = [[KxMovieGLView alloc] initWithFrame:CGRectMake(0, 0, 160, 118) decoder:_decoder];
    }
    if (!_glView)
    {
        NSLog(@"fallback to use RGB video frame and UIKit");
        [_decoder setupVideoFrameFormat:KxVideoFrameFormatRGB];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 318, 268)];
    }
    UIView *frameView = [self frameView];
    frameView.contentMode = UIViewContentModeScaleAspectFill;
    frameView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view insertSubview:frameView atIndex:1];
    self.view.backgroundColor = [UIColor redColor];
}
- (UIView *) frameView
{
    return _glView ? _glView : _imageView;
    
}
- (void) audioCallbackFillData: (float *) outData
                     numFrames: (UInt32) numFrames
                   numChannels: (UInt32) numChannels
{
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
    
    __weak VideoController *weakSelf = self;
    __weak KxMovieDecoder *weakDecoder = _decoder;
    
    const CGFloat duration = _decoder.isNetwork ? .0f : 0.1f;
    
    dispatch_async(_dispatchQueue, ^{
        
        {
            __strong VideoController *strongSelf = weakSelf;
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
                        
                        __strong VideoController *strongSelf = weakSelf;
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
        
        interval = _bufferedDuration * 0.5;
        
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
    
    __weak VideoController *weakSelf = self;
    
    dispatch_async(_dispatchQueue, ^{
        
        if (playMode) {
            {
                __strong VideoController *strongSelf = weakSelf;
                if (!strongSelf) return;
                [strongSelf setDecoderPosition: position];
            }
        } else {
            {
                __strong VideoController *strongSelf = weakSelf;
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



@end
