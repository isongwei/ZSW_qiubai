//  SWVideoPlayer.m
//  ZSW_qiubai
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/23.
//  Copyright © 2017年 iSong. All rights reserved.
//



#import "SWVideoPlayer.h"

@interface SWVideoPlayer ()<UIGestureRecognizerDelegate>


//播放图层
@property (nonatomic,strong) AVPlayerLayer *playerLayer;



//添加标题
@property (nonatomic,strong) UILabel *titleLabel;

//加载动画
@property (nonatomic,strong) UIActivityIndicatorView *activityIndeView;

@end




@implementation SWVideoPlayer



-(CGFloat)rate{
    return self.player.rate;
}

-(void)setRate:(CGFloat)rate{
    self.player.rate = rate;
    
}



//-(void)drawRect:(CGRect)rect{
//    
//    [self setupPlayerUI];
//    
//}


#pragma mark =============实例化=============


-(instancetype)initWithUrl:(NSURL *)url{
    
    if (self = [super init]){
        

    }
    return self;
    
}

-(void)setUrl:(NSURL *)url{
    _url = url;
    [self setupPlayerUI];
    [self assetWithURL:url];
}


-(void)assetWithURL:(NSURL *)url{
    
    NSDictionary * option = @{AVURLAssetPreferPreciseDurationAndTimingKey : @YES};
    self.avAsset = [[AVURLAsset alloc]initWithURL:url options:option];
    NSArray * keys = @[@"duration"];
    [self.avAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        
        NSError * error = nil;
        AVKeyValueStatus tracksStatus = [self.avAsset statusOfValueForKey:@"duration" error:&error];
        /*
         AVKeyValueStatusUnknown,
         AVKeyValueStatusLoading,
         AVKeyValueStatusLoaded,
         AVKeyValueStatusFailed,
         AVKeyValueStatusCancelled
         */
        switch (tracksStatus) {
            case AVKeyValueStatusLoaded:
            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (!CMTIME_IS_INDEFINITE(self.avAsset.duration)) {
//                        CGFloat second = self.avAsset.duration.value / self.avAsset.duration.timescale;
//                        
//                    }
//                });
            }
                break;
            case AVKeyValueStatusLoading:
            {
                NSLog(@"AVKeyValueStatusLoading正在加载");
            }
                break;
            case AVKeyValueStatusFailed:
            {
                NSLog(@"AVKeyValueStatusFailed失败,请检查网络,或查看plist中是否添加App Transport Security Settings");
            }
                break;
            case AVKeyValueStatusCancelled:
            {
                NSLog(@"AVKeyValueStatusCancelled取消");
            }
                break;
                
            case AVKeyValueStatusUnknown:
            {
                 NSLog(@"AVKeyValueStatusUnknown未知");
            }
                break;
                
            default:
                break;
        }
        
    }];
    
    [self setupPlayerWithAsset:self.avAsset];
    
}

-(void)setupPlayerWithAsset:(AVURLAsset *)asset{
    
    self.item = [[AVPlayerItem alloc]initWithAsset:asset];
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerLayer.frame = self.bounds;//CGRectMake(0, 100, 375, 375*0.3);
    
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.layer addSublayer:self.playerLayer];
    [self play];
    //跟踪时间的改变
//    [self addPeriodicTimeObserver];
    //添加KVO
//    [self addKVO];
    
    
    
    
    //添加消息中心
//    [self addNotificationCenter];
}

#pragma mark =============添加监听=============

-(void)addKVO{
    //监听状态属性
    [self.item addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听网络加载情况属性
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听播放的区域是否为空
    [self.item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    
    //缓存可以播放的时候调用
    [self.item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听暂停或者播放中
    [self.item addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)addNotificationCenter{
    //播放状态结束
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SWPlayerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    //转屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //app激活相关信息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}


#pragma mark =============对应的通知方法=============

-(void)SWPlayerItemDidPlayToEndTimeNotification:(NSNotification *)notification{
    
    [self.item seekToTime:kCMTimeZero];
    [self pause];
    
}

-(void)deviceOrientationDidChange:(NSNotification *)notification{
    
    
}


-(void)willResignActive:(NSNotification *)notification{
    
    
}



#pragma mark =============懒加载=============

-(UIActivityIndicatorView *)activityIndeView{
    if (!_activityIndeView) {
        _activityIndeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        
        _activityIndeView.hidesWhenStopped = YES;
    }
    return _activityIndeView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}



#pragma mark =============setupPlayerUI=============
-(void)setupPlayerUI{
    
    self.backgroundColor = [UIColor redColor];
    
    [self.activityIndeView startAnimating];
    
    //添加标题
    [self addTitle];
    //添加点击事件
    [self addGestureEvent];
    //添加播放和暂停按钮
    [self addPauseAndPlayBtn];
    //添加控制视图
    [self addControlView];
    //添加加载视图
    [self addLoadingView];
    //初始化时间
//    [self initTimeLabels];
    
    
}

-(void)addTitle{
    
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(0, 12, self.bounds.size.width,52 );
    
}


-(void)addGestureEvent{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

-(void)addPauseAndPlayBtn{
    
                                                 
                                                 
}


-(void)addControlView{
    
    
    
}

//添加加载视图

-(void)addLoadingView{
    
    
    [self addSubview:self.activityIndeView];
    self.activityIndeView.frame = CGRectMake(0, 0, 60, 60);
    _activityIndeView.center = CGPointMake(self.size.width*0.5, self.size.height* 0.5);
    
    
}





#pragma mark =============handleTapAction=============处理控制事件
-(void)handleTapAction:(UIGestureRecognizerState*)tap{
    

    
}

#pragma mark =============播放方法=============


//播放
-(void)play{
    if (self.player) {
        [self.player play];
    }
}
//暂停
-(void)pause{
    if (self.player) {
        [self.player pause];
    }
}
//停止 （移除当前视频播放下一个或者销毁视频，需调用Stop方法）
-(void)stop{
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    if (self.player) {
        [self pause];
        self.avAsset = nil;
        self.item = nil;
        self.player = nil;
        self.activityIndeView = nil;
        [self removeFromSuperview];
    }
    
}






@end
