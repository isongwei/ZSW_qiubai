//
//  UIViewController+SWNavigationExtension.m
//  SWNavigationViewCtrl
//
//  Created by iSongWei on 2016/11/7.
//  Copyright © 2016年 iSong. All rights reserved.
//

#import "UIViewController+SWNavigationExtension.h"
#import <objc/runtime.h>



@implementation UIViewController (SWNavigationExtension)

//添加相应的属性

- (BOOL)SW_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSW_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(SW_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}



-(SWNavigationController *)SW_navigationController{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setSW_navigationController:(SWNavigationController *)SW_navigationController{
    objc_setAssociatedObject(self, @selector(SW_navigationController), SW_navigationController, OBJC_ASSOCIATION_ASSIGN);
}


//
//-(SWWrapNavigationController *)navigationController_real{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//-(void)setNavigationController_real:(SWWrapNavigationController *)navigationController_real{
//    
//        objc_setAssociatedObject(self, @selector(navigationController_real), navigationController_real, OBJC_ASSOCIATION_ASSIGN);
//}



@end
