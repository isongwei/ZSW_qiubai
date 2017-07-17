//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by xc on 15/3/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Frame.h"
#import "NSString+Extension.h"
@implementation UIBarButtonItem (Extension)

+ (instancetype)BarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    
    return [[self alloc] initWithTitle:title style:style target:target action:action];
    
}
+ (instancetype)BarButtonItemWithBackgroudImageName:(NSString *)backgroudImage highBackgroudImageName:(NSString *)highBackgroudImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:backgroudImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highBackgroudImageName] forState:UIControlStateHighlighted];
  
    // 设置按钮的尺寸为背景图片的尺寸
    
//    [button sizeToFit];
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
/**
 *  设置tarbuttoonItem
 *
 *  @param imageName     图片名称
 *  @param highImageName 高亮图片名称
 *  @param title         标题
 *  @param target        回调对象
 *  @param action        回调方法
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)BarButtonItemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

        
    }
    // 设置按钮的尺寸为背景图片的尺寸+文字大小
    button.width = button.currentImage.size.width +[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    button.height = button.currentImage.size.height;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


@end
