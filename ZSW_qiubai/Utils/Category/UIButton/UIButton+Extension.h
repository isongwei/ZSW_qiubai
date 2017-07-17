//
//  UIButton+Extension.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (Extension)

#pragma mark - 新增title属性
@property (nonatomic, copy) NSString *title;
@property (nonatomic,strong) UIActivityIndicatorView * activityIndicator;

@property (nonatomic,assign) UIFont * font;

//开始请求时，UIActivityIndicatorView 提示
- (void)startQueryAnimate;
- (void)stopQueryAnimate;




#pragma mark - 初始化
+ (id)buttonWithFrame:(CGRect)frame;

+ (id)buttonWithFrame:(CGRect)frame
              title:(NSString *)title;

-(void)setTitle:(NSString *)title
                color:(UIColor *)color
                sColor:(UIColor *)sColor
                hColor:(UIColor *)hColor;


-(void)setImage:(UIImage *)image
       sImage:(UIImage *)sImage
       hImage:(UIImage *)hImage;


-(void)setBGImage:(UIImage *)BGImage
       sBGImage:(UIImage *)sBGImage
       hBGImage:(UIImage *)hBGImage;

#pragma mark - 设置圆角
- (void)setCornerRadius:(CGFloat)Radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor *)borderColor;







@end
