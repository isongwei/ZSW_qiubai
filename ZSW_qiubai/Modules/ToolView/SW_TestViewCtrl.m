//
//  SW_TestViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/13.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_TestViewCtrl.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface SW_TestViewCtrl ()
{
    NSString *_flv;
}



/** 直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 播放器属性*/
@property (nonatomic, strong) IJKFFOptions *options;


@end

@implementation SW_TestViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
//    [self playWith:@"http://circle-video.qiushibaike.com/video/m0525cxdf6f.mp4"];return;
    [MBManager showLoading];
    [self playWith:NSStringFormat(@"%@",self.flv)];
    
    
    self.view.autoresizesSubviews = YES;
    
}

- (IJKFFOptions *)options {
    if (!_options) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        // 开启硬解码
        [options setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
//        [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
        // 帧速率(fps) 非标准桢率会导致音画不同步，所以只能设定为15或者29.97
        [options setPlayerOptionIntValue:29.97 forKey:@"r"];
        // 置音量大小，256为标准  要设置成两倍音量时则输入512，依此类推
        [options setPlayerOptionIntValue:256 forKey:@"vol"];
        _options = options;
    }
    return _options;
}



- (IJKFFMoviePlayerController *)moviePlayer {
    
    if (!_moviePlayer) {
        IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_flv withOptions:self.options];
        
        // 4.1 设置播放视频视图的frame与控制器的View的bounds一致
        _moviePlayer.view.frame = self.view.bounds;//CGRectMake(0, 0, KScreenWidth, KScreenWidth);//
        
        // 4.2 设置适配横竖屏(设置四边固定,长宽灵活)
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

        // 填充fill
        moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFit;//IJKMPMovieScalingModeAspectFit
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        moviePlayer.shouldAutoplay = NO;
        // 默认不显示
        moviePlayer.shouldShowHudView = NO;

        [moviePlayer prepareToPlay];
        
        _moviePlayer = moviePlayer;
    }
    return _moviePlayer;
}


#pragma mark =============开始=============

-(void)playWith:(NSString *)url
{
    
    _flv = url;
    if (_moviePlayer) {
   
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [self removeMovieNotificationObservers];
    }
    
    [self.view insertSubview:self.moviePlayer.view atIndex:0];
    
    
    //添加监听
    [self addObserveForMoviePlayer];

    
}


#pragma mark =============<#详情#>=============

//notification method emplemtation
- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _moviePlayer.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) { //shouldAutoplay 为yes 在这种状态下会自动开始播放
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            
        }
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) { //如果正在播放,会在此状态下暂停
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
    
    return;
    
    
    switch (_moviePlayer.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"停止");
            break;
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"打断");
            break;
        case IJKMPMoviePlaybackStateSeekingForward:
            NSLog(@"快进");
            break;
        case IJKMPMoviePlaybackStateSeekingBackward:
            NSLog(@"快退");
            break;
        default:
            break;
            
    }
    
    
    
}

- (void)moviePlayBackFinish:(NSNotification*)notification { //播放结束时,或者是用户退出时会触发
    
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {//播放状态改变时,会触发
    
    switch (_moviePlayer.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_moviePlayer.playbackState);
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            
            
            
            [MBManager hideAlert];
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward: {
            
        }
            break;
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_moviePlayer.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_moviePlayer.playbackState);
            break;
        }
    }
}


#pragma mark - Notification
- (void)addObserveForMoviePlayer {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
}


#pragma mark - 释放相关
- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_moviePlayer];
    
}

- (void)dealloc {
    DLog(@"dealloc方法被调用");
    if (_moviePlayer) {
        
        
        [_moviePlayer shutdown];
        
        
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        
    }
   [self removeMovieNotificationObservers];
}

@end
