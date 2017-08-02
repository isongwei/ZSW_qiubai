//
//  SWVideoPlayer.h
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/23.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//横竖屏的时候过渡动画时间，设置为0.0则是无动画
#define kTransitionTime 0.2

//播放状态枚举值
typedef NS_ENUM(NSInteger,SWPlayerStatus){
    SWPlayerStatusUnknown,
    SWPlayerStatusFailed,
    SWPlayerStatusReadyToPlay,
    SWPlayerStatusPlaying,
    SWPlayerStatusPause,       // 暂停播放//暂停播放
    SWPlayerStatusBuffering,
    SWPlayerStatusFinished,        //暂停播放
    SWPlayerStatusStopped,
};


@interface SWVideoPlayer : UIView


@property (nonatomic,assign,readonly) CMTime totalTime;
@property (nonatomic,assign,readonly) CMTime currentTime;


//当前播放avAsset
@property (nonatomic,strong) AVURLAsset * avAsset;

//当前播放url
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *urlString;



//播放状态
@property (nonatomic,assign,readonly) SWPlayerStatus  status;
//是否正在播放
@property (nonatomic,assign,readonly) BOOL isPlaying;
//是否全屏
@property (nonatomic,assign,readonly) BOOL isFullScreen;
//设置标题
@property (nonatomic,strong) NSString * title;




//与url初始化
//-(instancetype)initWithUrl:(NSURL *)url;
////将播放url放入资产中初始化播放器
//-(void)assetWithURL:(NSURL *)url;



////公用同一个资产请使用此方法初始化
//+(instancetype)viewWithAsset:(AVURLAsset *)asset;




//播放
-(void)play;
//暂停
-(void)pause;
//停止 （移除当前视频播放下一个或者销毁视频，需调用Stop方法）
-(void)stop;



@end
