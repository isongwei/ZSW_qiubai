//
//  UIImageView+Extension.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/17.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImage+ImageEffects.h"


@implementation UIImageView (Extension)



- (void)setImageToBlur:(UIImage *)image
       completionBlock:(void(^)(void))completion{
    
    [self setImageToBlur:image
              blurRadius:20.0
         completionBlock:completion];
}

/**
 根据模糊程度来处理图片
 
 @param image 要处理的图片
 @param blurRadius 模糊度
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(void(^)(void))completion {
    if (!image) {
        return;
    }
    NSParameterAssert(image);
    blurRadius = (blurRadius <= 0) ? 20 : blurRadius;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:1.8
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
    
}


/** 播放Image*/
- (void)playGifAnimationWithImages:(NSArray *)images {
    
    if (!images.count) {
        return;
    }
    self.animationImages = images;
    self.animationDuration = 0.5;
    self.animationRepeatCount = 0;//无限循环
    [self startAnimating];
}
/** 停止动画*/
- (void)stopGifAnimation {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}

@end
