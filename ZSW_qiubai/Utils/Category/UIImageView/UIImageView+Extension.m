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

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock{
    
    [self sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:placeholder options:(SDWebImageCacheMemoryOnly) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock) {
            progressBlock(receivedSize,expectedSize);
        }
    } completed:nil];
    

    
    
    
    
}

-(void)setImageWithURL:(NSURL *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock{

    
    [self sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:nil options:(SDWebImageCacheMemoryOnly) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock) {
            progressBlock(receivedSize,expectedSize);
        }
    } completed:nil];
    
}

-(void)setProgressImageWithURLStr:(NSString*)urlStr{
    
    UIProgressView * pro = [[UIProgressView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth-30, 5))];
    pro.tintColor = [UIColor orangeColor];
    
    [self addSubview:pro];
    
    [self sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:(SDWebImageCacheMemoryOnly) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        pro.progress = (float)receivedSize/(float)expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [pro removeFromSuperview];
        
    }];
    
}


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
