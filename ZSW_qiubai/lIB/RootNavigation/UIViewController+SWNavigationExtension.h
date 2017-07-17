//
//  UIViewController+SWNavigationExtension.h
//  SWNavigationViewCtrl
//
//  Created by iSongWei on 2016/11/7.
//  Copyright © 2016年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWNavigationController.h"



@interface UIViewController (SWNavigationExtension)


//添加属性
@property (nonatomic, assign) BOOL SW_fullScreenPopGestureEnabled;
@property (nonatomic, weak) SWNavigationController *SW_navigationController;
//@property (nonatomic, weak) SWWrapNavigationController *navigationController_real;

@end
