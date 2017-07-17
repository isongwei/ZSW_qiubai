//
//  MBManager.m
//  MBProgressDemo
//
//  Created by hungryBoy on 16/1/23.
//  Copyright © 2016年 hungryBoy. All rights reserved.
//

#import "MBManager.h"

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
#define kDefaultRect     CGRectMake(0, 0, kScreen_width, kScreen_height)

#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]
#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"加载中";

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   kShowTime  = 2.0f;



/* 手势是否可用，默认NO，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = NO;

@implementation MBManager

UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景


#pragma mark -   类初始化
+ (void)initialize {
    if (self == [MBManager self]) {
        //该方法只会走一次
        [self customView];
    }
}
#pragma mark - 初始化gloomyView
+(void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    isShowGloomy = YES;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}
#pragma mark - 简短提示语

//定义字,自动消失 在View
+ (void) showBriefAlert:(NSString *) message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideAlert];
        prestrainView = view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.label.text = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        //HUD.yOffset = 200;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

#pragma mark - 网络加载提示用

//菊花加字(加载中...),在View
+ (void) showLoadingInView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = kLoadingMessage;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
       
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
       
    });
}

//菊花加自定义字,在View
+ (void)showWaitingWithTitle:(NSString *)title inView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = title;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
      
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
      
    });
}

//带图片提示语在View上
+(void)showAlertWithErrorImage:(NSString *)title inView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBManager hideAlert];
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:@"error.png"];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

+(void)showAlertWithSuccessImage:(NSString *)title inView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBManager hideAlert];
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:@"success.png"];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

+(void)showAlertWithErrorNetImage:(NSString *)title inView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBManager hideAlert];
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:@"error.png"];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

#pragma mark - 加载在window上的提示框
+(void)showLoading{
    [self showLoadingInView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title{
    [self showWaitingWithTitle:title inView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefAlert:alert inView:nil];
}
+(void)showError:(NSString *)title {
    [self showAlertWithErrorImage:title inView:nil];
}

+(void)showSuccess:(NSString *)title {
    [self showAlertWithSuccessImage:title inView:nil];
}

+(void)showErrorNet{
    [self showAlertWithErrorNetImage:@"网络链接失败,请重试!" inView:nil];
}

#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}

+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBManager HUDForView:gloomyView];
        [UIView animateWithDuration:0.5 animations:^{
            //gloomyView.frame = CGRectZero;
           // gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
            gloomyView.alpha = 0;
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    });
   
}

#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}
@end


@implementation GloomyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isAvalibleTouch) {
        [MBManager hideAlert];
    }
}

@end
