//  SWVideoPlayer.m
//  ZSW_qiubai
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/23.
//  Copyright © 2017年 iSong. All rights reserved.
//



#import "SWVideoPlayer.h"
#import "SWPauseOrPlayView.h"
#import <MediaPlayer/MPVolumeView.h>

#import "SWControlView.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)



@interface SWVideoPlayer ()<UIGestureRecognizerDelegate,SWPauseOrPlayViewDelegate,SWControlViewDelegate>{
    id playbackTimerObserver;

    ///记录touch开始的点
    CGPoint _touchBeginPoint;
    //用来判断手势是否移动过
    BOOL _hasMoved;
    //记录触摸开始亮度
    float _touchBeginLightValue;
    //记录触摸开始的音量
    float _touchBeginVoiceValue;
    
    

}

//播放显示层
@property (nonatomic,strong) AVPlayer  * player;

//播放控制
@property (nonatomic,strong) AVPlayerItem * item;

//播放速率
@property (nonatomic,assign) CGFloat rate;

//播放图层
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

//添加标题
@property (nonatomic,strong) UILabel *titleLabel;


//添加播放暂停按钮
@property (nonatomic,strong) SWPauseOrPlayView * pauseOrPlayView;

//进度view

@property (nonatomic,strong) SWControlView * controlView;

//加载动画
@property (nonatomic,strong) UIActivityIndicatorView *activityIndeView;


//原始尺寸
@property (nonatomic,assign) CGRect oldFrame;

@end

static float count = 0;


@implementation SWVideoPlayer

//+(Class)layerClass{
//    return [AVPlayerLayer class];
//}
////MARK: Get方法和Set方法
//-(AVPlayer *)player{
//    return self.playerLayer.player;
//}
//-(void)setPlayer:(AVPlayer *)player{
//    self.playerLayer.player = player;
//}

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


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.oldFrame = frame;
    }
    return self;
    
}


-(instancetype)initWithUrl:(NSURL *)url{
    
    if (self = [super init]){
        

    }
    return self;
    
}

-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    [self setUrl:[NSURL URLWithString:urlString]];
}


-(void)setUrl:(NSURL *)url{
    _url = url;
    [self setupPlayerUI];
    [self assetWithURL:url];
    [self bringSubviewToFront:self.pauseOrPlayView];
    [self bringSubviewToFront:self.controlView];
    [self bringSubviewToFront:self.activityIndeView];
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!CMTIME_IS_INDEFINITE(self.avAsset.duration)) {
                        CGFloat second = self.avAsset.duration.value / self.avAsset.duration.timescale;
                        self.controlView.totalTime = [self convertTime:second];
                        self.controlView.minValue = 0;
                        self.controlView.maxValue = second;
                    }
                });
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
    
    
    
    //跟踪时间的改变
    [self addPeriodicTimeObserver];
    //添加KVO
    [self addKVO];
    
    
    
    
    //添加消息中心
    [self addNotificationCenter];
}

#pragma mark =============添加监听=============
//监控播放进度方法

//Tracking time,跟踪时间的改变
-(void)addPeriodicTimeObserver{
    
    
    __weak typeof(self) weakSelf = self;
    
    
    //一个周期的回调
    
    CMTime interval = CMTimeMake(1, 30);//self.item.currentTime.timescale > 60 ? CMTimeMake(1, 1) : CMTimeMake(1, 30);
    playbackTimerObserver = [self.player addPeriodicTimeObserverForInterval:interval queue:NULL usingBlock:^(CMTime time) {
        
        //播放的时间
        CGFloat currentTime = CMTimeGetSeconds(time);
        
        
        weakSelf.controlView.value = (double)weakSelf.item.currentTime.value/(double)weakSelf.item.currentTime.timescale;
    
        
        if (!CMTIME_IS_INDEFINITE(self.avAsset.duration)) {
            weakSelf.controlView.currentTime = [weakSelf convertTime:weakSelf.controlView.value];
            
        }
        
        if (count>=5) {
            [weakSelf setSubViewsIsHide:YES];
            
        }else{
            [weakSelf setSubViewsIsHide:NO];
        }
        
        count += 1.0/interval.timescale;
        
        
        
    }];
    
}

-(void)addKVO{
    //监听状态属性
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
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
    
    [self setSubViewsIsHide:NO];
    count = 0;
    [self pause];
    self.controlView.value = 0;
    [self.pauseOrPlayView.imageBtn setSelected:NO];
    
}

-(void)deviceOrientationDidChange:(NSNotification *)notification{
    

    //获取状态栏的方向
    UIInterfaceOrientation _interfaceOrientation=[[UIApplication sharedApplication]statusBarOrientation];
    
    switch (_interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            _isFullScreen = YES;


            [UIView animateWithDuration:kTransitionTime delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0. options:UIViewAnimationOptionTransitionCurlUp animations:^{
                
                self.frame = [UIApplication sharedApplication].keyWindow.bounds;
                
                
            } completion:nil];
            
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationPortrait:
        {
            _isFullScreen = NO;
            [UIView animateWithDuration:kTransitionTime delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0. options:UIViewAnimationOptionTransitionCurlUp animations:^{
                
                self.frame = self.oldFrame;
                
                
            } completion:nil];
            
        }
            break;
            
        default:
            break;
    }
    
}


-(void)willResignActive:(NSNotification *)notification{
    
    if (_isPlaying) {
        [self setSubViewsIsHide:NO];
        count = 0;
        [self pause];
        [self.pauseOrPlayView.imageBtn setSelected:NO];
    }
    
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        
        AVPlayerItemStatus  itemStatus = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (itemStatus) {
            case AVPlayerItemStatusUnknown:
            {
                _status = SWPlayerStatusUnknown;
                [MBManager showError:@"AVPlayerItemStatusUnknown"];
                NSLog(@"AVPlayerItemStatusUnknown");
                
                self.pauseOrPlayView.imageBtn.selected = NO;
                [self pause];
            }
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
                _status = SWPlayerStatusReadyToPlay;
                [MBManager showError:@"AVPlayerItemStatusReadyToPlay"];
                NSLog(@"AVPlayerItemStatusReadyToPlay");
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                _status = SWPlayerStatusFailed;
                [MBManager showError:@"AVPlayerItemStatusFailed"];
                NSLog(@"AVPlayerItemStatusFailed");
                self.pauseOrPlayView.imageBtn.selected = NO;
                [self pause];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    
    //监听播放器的下载进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        NSArray * loadTimeRanges = [self.item loadedTimeRanges];
        NSLog(@"%@",loadTimeRanges);
        
        //获取缓冲进度
        CMTimeRange timeRange = [loadTimeRanges.firstObject CMTimeRangeValue];
        
        
        float startSecond = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        
        //计算缓冲进度
        NSTimeInterval timeInterval = startSecond + durationSeconds;
        
        
        CMTime duration = self.item.duration;
        
//        //视频当前的播放进度
//        NSTimeInterval current = CMTimeGetSeconds(_player.currentTime);
        //视频的总长度
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        NSLog(@"开始:%f,持续:%f,总时间:%f", startSecond, durationSeconds, timeInterval);
        NSLog(@"视频的加载进度是:%%%f", durationSeconds / totalDuration *100);
        
        //缓冲值
        self.controlView.bufferValue = timeInterval/totalDuration;
        
        //获取播放状态
        //只有播放状态变成AVPlayerItemStatusReadyToPlay时才可以获取视频播放的总时间，提前获取无效;
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            NSLog(@"准备播放");
            
        } else{
            NSLog(@"播放失败");
            
        }
 
    }
    
    
    //监听播放器在缓冲数据的状态
    if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        _status = SWPlayerStatusBuffering;
        
        if (!self.activityIndeView.isAnimating) {
            [self.activityIndeView startAnimating];
            
        }
    }
    
    
    
    if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        NSLog(@"缓冲达到可播放");
        
        [self.activityIndeView stopAnimating];
        //由于 AVPlayer 缓存不足就会自动暂停，所以缓存充足了需要手动播放，才能继续播放
        [self play];
    }
    
    
    if ([keyPath isEqualToString:@"rate"]) {
        //当rate==0时为暂停,rate==1时为播放,当rate等于负数时为回放
    
        if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue] >= 0) {
            _isPlaying = false;
            _status = SWPlayerStatusPlaying;
        }else{
            _isPlaying = true;
            _status = SWPlayerStatusStopped;
        }
    }
    
    
    
    
    
}


#pragma mark =============点击全屏=============
//旋转方向
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    
    if (orientation == UIInterfaceOrientationLandscapeRight||orientation == UIInterfaceOrientationLandscapeLeft) {
        // 设置横屏
    } else if (orientation == UIInterfaceOrientationPortrait) {
        // 设置竖屏
    }else if (orientation == UIInterfaceOrientationPortraitUpsideDown){
        //
    }
    
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

-(SWPauseOrPlayView *)pauseOrPlayView{
    
    if (!_pauseOrPlayView) {
        _pauseOrPlayView = [[SWPauseOrPlayView alloc]initWithFrame:(CGRectMake(0, 0, 66, 66))];
        self.pauseOrPlayView.center =self.center;
        _pauseOrPlayView.delegate = self;
        _pauseOrPlayView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin|
        UIViewAutoresizingFlexibleRightMargin|
        UIViewAutoresizingFlexibleTopMargin|
        UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return _pauseOrPlayView;
    
}

#pragma mark =============添加辅助图=============
-(void)pauseOrPlayView:(SWPauseOrPlayView *)pauseOrPlayView withState:(BOOL)state{
    count = 0;
    if (state) {
        [self play];
    }else{
        [self pause];
    }
}


-(SWControlView *)controlView{
    
    if (!_controlView) {
        _controlView = [[SWControlView alloc]initWithFrame:(CGRectMake(0, self.frame.size.height-44, self.frame.size.width, 44))];
        _controlView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth|
        UIViewAutoresizingFlexibleTopMargin;
        _controlView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        _controlView.delegate = self;
    }
    return _controlView;
}


#pragma mark =============视图布局setupPlayerUI=============
-(void)setupPlayerUI{
    
    self.backgroundColor = [UIColor blackColor];
    
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
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
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
    
    [self addSubview:self.pauseOrPlayView];
    
    
                                                 
}


-(void)addControlView{
    
    [self addSubview:self.controlView];
    
}

//添加加载视图

-(void)addLoadingView{
    
    
    [self addSubview:self.activityIndeView];
    
    self.activityIndeView.userInteractionEnabled  = NO;
    self.activityIndeView.frame = CGRectMake(0, 0, 80, 80);
    _activityIndeView.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height* 0.5);
    _activityIndeView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleBottomMargin;
    
    
}

#pragma mark =============SWControlViewDelegate=============
// 点击UISlider获取点击点
-(void)controlView:(SWControlView *)controlView pointSliderLocationWithCurrentValue:(CGFloat)value{
    count = 0;
    CMTime  pointTime = CMTimeMake(value * self.item.currentTime.timescale, self.item.currentTime.timescale);
    [self.item seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    
}

//拖拽UISlider的knob的时间响应代理方法

-(void)controlView:(SWControlView *)controlView draggedPositionWithSlider:(UISlider *)slider {
    count = 0;
  
    CMTime  pointTime = CMTimeMake(controlView.value * self.item.currentTime.timescale, self.item.currentTime.timescale);
    [self.item seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
}

//点击放大按钮的响应事件
 
-(void)controlView:(SWControlView *)controlView withLargeButton:(UIButton *)button{
    count = 0;
    if (kScreenWidth < kScreenHeight) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }

}


#pragma mark =============UIGestureRecognizer=============
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch{
    
    if ([touch.view isKindOfClass:[SWControlView class]]) {
        return NO;
    }
    return YES;
    
}



#pragma mark =============处理View点击控制事件=============
-(void)handleTapAction:(UIGestureRecognizerState*)tap{
    
    if (count >= 5) {
        count = 3;
    }
    
    
    if (count <= 2) {
        [self setSubViewsIsHide:YES];
        count = 5;
    }else{
        [self setSubViewsIsHide:NO];
        count = 0;
    }
    
    
    
}

-(void)setSubViewsIsHide:(BOOL)isHide{
    
    self.controlView.hidden = isHide;
    self.pauseOrPlayView.hidden = isHide;
    self.titleLabel.hidden = isHide;
    
}



#pragma mark =============处理音量和亮度=============左边亮度 右边音量

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //用来判断多个手指不响应
    
    UITouch * touch = touches.anyObject;
    if (touches.count > 1 || [touch tapCount] > 1 || event.allTouches.count > 1) {
        return;
    }
    //    这个是用来判断, 手指点击的是不是本视图, 如果不是则不做出响应
    if (![[(UITouch *)touches.anyObject view] isEqual:self]) {
        return;
    }
    [super touchesBegan:touches withEvent:event];

    
    //触摸开始, 初始化一些值
    _hasMoved = NO;
    //位置
    _touchBeginPoint = [touches.anyObject locationInView:self];
    //亮度
    _touchBeginLightValue = [UIScreen mainScreen].brightness;
    //声音
    _touchBeginVoiceValue = [self getSystemVolumSlider].value;
    
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //用来判断多个手指不响应
    
    UITouch * touch = touches.anyObject;
    if (touches.count > 1 || [touch tapCount] > 1 || event.allTouches.count > 1) {
        return;
    }
    //    这个是用来判断, 手指点击的是不是本视图, 如果不是则不做出响应
    if (![[(UITouch *)touches.anyObject view] isEqual:self]) {
        return;
    }
    [super touchesMoved:touches withEvent:event];
    //如果移动的距离过于小, 就判断为没有移动
    CGPoint tempPoint = [touches.anyObject locationInView:self];
    if (fabs(tempPoint.x - _touchBeginPoint.x) < 15 && fabs(tempPoint.y - _touchBeginPoint.y) < 15) {
        return;
    }
    _hasMoved = YES;
    
    //如果还没有判断出使什么控制手势, 就进行判断
    //滑动角度的tan值
    float tan = fabs(tempPoint.y - _touchBeginPoint.y)/fabs(tempPoint.x - _touchBeginPoint.x);
    if (tan < 1/sqrt(3)) {    //当滑动角度小于30度的时候, 进度手势
//        _controlType = progressControl;
        //            _controlJudge = YES;
    }else if(tan > sqrt(3)){  //当滑动角度大于60度的时候, 声音和亮度
        //判断是在屏幕的左半边还是右半边滑动, 左侧控制为亮度, 右侧控制音量
        if (_touchBeginPoint.x < self.bounds.size.width/2) {   //如果是亮度手势
            //显示音量控制的view
            [self hideTheLightViewWithHidden:NO];
            if (self.isFullScreen) {
                //根据触摸开始时的亮度, 和触摸开始时的点来计算出现在的亮度
                float tempLightValue = _touchBeginLightValue - ((tempPoint.y - _touchBeginPoint.y)/self.bounds.size.height);
                if (tempLightValue < 0) {
                    tempLightValue = 0;
                }else if(tempLightValue > 1){
                    tempLightValue = 1;
                }
                //        控制亮度的方法
                [UIScreen mainScreen].brightness = tempLightValue;
                //        实时改变现实亮度进度的view
                NSLog(@"亮度调节 = %f",tempLightValue);
            }else{
                
            }
        }else{    //如果是音量手势
            if (self.isFullScreen) {//全屏的时候才开启音量的手势调节
                
                //根据触摸开始时的音量和触摸开始时的点去计算出现在滑动到的音量
                float voiceValue = _touchBeginVoiceValue - ((tempPoint.y - _touchBeginPoint.y)/self.bounds.size.height);
                //判断控制一下, 不能超出 0~1
                if (voiceValue < 0) {
                    [self getSystemVolumSlider].value = 0;
                }else if(voiceValue > 1){
                    [self getSystemVolumSlider].value = 1;
                }else{
                    [self getSystemVolumSlider].value = voiceValue;
                }
                
            }else{
                return;
            }
        }
        
    }else{     //如果是其他角度则不是任何控制
        
        return;
    }
    
    
}

#pragma mark - 用来控制显示亮度的view, 以及毛玻璃效果的view
-(void)hideTheLightViewWithHidden:(BOOL)hidden{
//    if (self.isFullScreen) {//全屏才出亮度调节的view
//        if (hidden) {
//            [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                if (iOS8) {
//                    self.effectView.alpha = 0.0;
//                }
//            } completion:nil];
//            
//        }else{
//            if (iOS8) {
//                self.effectView.alpha = 1.0;
//            }
//        }
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//            self.effectView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.height)/2-155/2, ([UIScreen mainScreen].bounds.size.width)/2-155/2, 155, 155);
//        }
//    }else{
//        return;
//    }
    
}

/*
 *获取系统音量滑块
 */
-(UISlider*)getSystemVolumSlider{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(10, 50, 200, 4)];
        
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    return volumeViewSlider;
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
    [self.player removeTimeObserver:playbackTimerObserver];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    
    if (self.player) {
        [self pause];
        self.avAsset = nil;
        self.item = nil;
        self.player = nil;
        self.activityIndeView = nil;
        
    }
 
    [self removeFromSuperview];
}

#pragma mark =============//将数值转换成时间=============
- (NSString *)convertTime:(CGFloat)second{
 
    NSDate  *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"00:mm:ss"];
    }
    NSString * showTime = [formatter stringFromDate:d];
    return showTime;
    
}


#pragma mark =============获取当前屏幕显示的VC=============

- (UIViewController *)getCurrentVC
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
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
    
    
}


#pragma mark - ===============获取播放状态===============
//关于AVPlayer播放卡顿时如何获取此时的状态也是我遇到的难题，因为AVPlayer并没有给出这种状态，有人说根据AVPlayer的rate是1还是0判断，经测试这个方法不靠谱，即使卡顿时rate有时还是1，
-(void)LiveStatus{
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(upadte)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)upadte
{
    NSTimeInterval current = CMTimeGetSeconds(self.player.currentTime);
    
//    if (current!=self.lastTime) {
//        //没有卡顿
//        NSLog(@"没有卡顿");
//    }else{
//        //卡顿了
//        NSLog(@"卡顿了");
//    }
//    self.lastTime = current;
}


#pragma mark - ===============切换当前播放的内容===============

- (void)changeCurrentplayerItemWithModel:(id *)model
{
    if (self.player) {
        
        //由暂停状态切换时候 开启定时器，将暂停按钮状态设置为播放状态
//        self.link.paused = NO;
//        self.playButton.selected = NO;
        /*
        //移除当前AVPlayerItem对"loadedTimeRanges"和"status"的监听
        [self removeObserveWithPlayerItem:self.player.currentItem];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:model.url];
        [self addObserveWithPlayerItem:playerItem];
        self.avPlayerItem = playerItem;
        //更换播放的AVPlayerItem
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
        
        self.playButton.enabled = NO;
        self.slider.enabled = NO;
         */
    }
}


@end
