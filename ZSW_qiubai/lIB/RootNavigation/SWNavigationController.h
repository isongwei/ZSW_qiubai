//
//  SWNavigationController.h
//  SWNavigationViewCtrl
//
//  Created by iSongWei on 2016/11/7.
//  Copyright © 2016年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWNavigationController.h"



//导航栏控制器

@interface SWNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;
@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;//是否全屏返回
@property (nonatomic, copy, readonly) NSArray *SW_viewControllers;


@end


//控制器

@interface SWWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (SWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end





//实际的导航栏
@interface SWWrapNavigationController : UINavigationController

@end





