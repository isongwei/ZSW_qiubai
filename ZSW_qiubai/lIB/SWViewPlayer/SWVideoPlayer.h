//
//  SWVideoPlayer.h
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/23.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//播放状态枚举值
typedef NS_ENUM(NSInteger,SWPlayerState){
    SWPlayerStateUnknown,
    SWPlayerStateFailed,
    SWPlayerStateReadyToPlay,
    SWPlayerStatePlaying,
    SWPlayerStatePause,       // 暂停播放//暂停播放
    SWPlayerStateSWuffering,
    SWPlayerStateFinished,        //暂停播放
    SWPlayerStateStopped,
};


@interface SWVideoPlayer : UIView



/**
 player
 */
@property (nonatomic,strong) AVPlayer  * player;
@property (nonatomic,strong) AVPlayerItem * item;
@property (nonatomic,assign) CMTime  totalTime;
@property (nonatomic,assign) CMTime currentTime;
@property (nonatomic,strong) AVURLAsset * avAsset;
@property (nonatomic,assign) CGFloat rate;
//当前播放url
@property (nonatomic,strong) NSURL *url;



//播放状态
@property (nonatomic,assign,readonly) SWPlayerState  state;
//是否正在播放
@property (nonatomic,assign,readonly) BOOL isPlaying;
//是否全屏
@property (nonatomic,assign,readonly) BOOL isFullScreen;
//设置标题
@property (nonatomic,strong) NSString * title;




//与url初始化
-(instancetype)initWithUrl:(NSURL *)url;
//将播放url放入资产中初始化播放器
-(void)assetWithURL:(NSURL *)url;
//公用同一个资产请使用此方法初始化
-(instancetype)initWithAsset:(AVURLAsset *)asset;




//播放
-(void)play;
//暂停
-(void)pause;
//停止 （移除当前视频播放下一个或者销毁视频，需调用Stop方法）
-(void)stop;



@end
