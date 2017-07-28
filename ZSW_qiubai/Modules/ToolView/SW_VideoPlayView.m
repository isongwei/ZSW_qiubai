//
//  SW_VideoPlayView.m
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/20.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_VideoPlayView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SW_VideoPlayView ()
@property (nonatomic,strong) UIView * ctrlView;

@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) AVPlayerLayer * livelayer;


@end

@implementation SW_VideoPlayView



-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
      
    }
    return self;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    static BOOL i =  YES;
    if (i) {
        _ctrlView.hidden = i;
    }
    i=!i;

}


#pragma mark =============创建UI=============
-(void)createUI{
    self.backgroundColor = [UIColor redColor];
    self.backgroundColor = [UIColor colorWithPatternImage:[self thumbnailImageRequest:2.0 url:nil]]   ;return;
    
    
 //播放Button
    
    _ctrlView.frame = self.bounds;
    [self addSubview:_ctrlView];
    
    
    UIButton * playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    playBtn.frame = CGRectMake(0, 0, 60, 60);
    playBtn.center = self.center;
    [playBtn addTarget:self action:@selector(play:) forControlEvents:(UIControlEventTouchUpInside)];
    [_ctrlView addSubview:playBtn];
    
    
    [self play:nil];
    
    
}


#pragma mark =============<#详情#>=============
-(void)play:(UIButton *)btn{
    
    
    
    
    //1.从mainBundle获取test.mp4的具体路径
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"150511_JiveBike" ofType:@"mov"];
//    //2.文件的url
//    NSURL * url = [NSURL fileURLWithPath:path];
    
    //3.根据url创建播放器(player本身不能显示视频)
    
    _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://circle-video.qiushibaike.com/video/l0525352xwb.mp4"]];
    
    //4.根据播放器创建一个视图播放的图层
    _livelayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    //5.设置图层的大小
    _livelayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    
    //6.添加到控制器的view的图层上面
    [self.layer addSublayer:_livelayer];
    
    //7.开始播放
    [_player play];
    
    
    
    
}

#pragma mark - ===============缩略图===============
-(UIImage *)thumbnailImageRequest:(CGFloat)timeBySecond url:(NSString *)urlStr{
    
    NSURL * url = [NSURL URLWithString:@"http://qiubai-video.qiushibaike.com/CZWULA3CUG4VMR2P_3g.mp4"];
    
    AVURLAsset * urlAsset = [AVURLAsset assetWithURL:url];
    AVAssetImageGenerator * imageGen = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    /*
     requestTime  缩略图创建时间
     actualTime 缩略图实际生成时间
     */
    
    NSError * error = nil;
    
    //视频第几秒
    //每秒帧数
    CMTime time  = CMTimeMakeWithSeconds(timeBySecond, 10);
    CMTime actualTime;
    
    CGImageRef cgImage = [imageGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if (error) {
        DLog(@"截取视频缩略图发生错误:%@",error.localizedDescription);
        return nil;
    }
    
    CMTimeShow(actualTime);
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    
    
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    CGImageRelease(cgImage);
    return image;
    
}




@end
