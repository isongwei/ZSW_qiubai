//
//  UIImage+Extension.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/19.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Extension)
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color withFrame:(CGRect)aFrame;


-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

+ (UIImage *)imageWithFileType:(NSString *)fileType;

- (NSData *)dataSmallerThan:(NSUInteger)dataLength;
- (NSData *)dataForCodingUpload;
@end
