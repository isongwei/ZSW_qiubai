//
//  UIImageView+Extension.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/17.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)



/**
 带进度的图片加载

 @param url url
 @param placeholder 替代图
 @param progressBlock 返回进度
 */
-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock;

/**
 带进度的图片加载
 
 @param url url
 @param progressBlock 返回进度
 */
-(void)setImageWithURL:(NSURL *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock;

-(void)setProgressImageWithURLStr:(NSString*)urlStr;


/****************   模糊效果   ****************/
/**
 根据模糊程度来处理图片
 
 @param image 要处理的图片
 @param blurRadius 模糊度
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(void(^)(void))completion;

/**
 图片模糊效果处理
 
 @param image 要处理的图片
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(void(^)(void))completion;








/****************   处理GIF   ****************/
/** 播放Image*/
- (void)playGifAnimationWithImages:(NSArray *)images;
/** 停止动画*/
- (void)stopGifAnimation;


@end
