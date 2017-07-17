//
//  UIImageView+Extension.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/17.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)


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
