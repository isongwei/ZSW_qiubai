//
//  UIViewController+method.m
//  maimaiti2.0
//
//  Created by 张松伟 on 16/8/29.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "UIViewController+method.h"
#import <objc/runtime.h>

//#import <UMMobClick/MobClick.h>




@implementation UIViewController (method)


+(void)load{
    Method viewAppear = class_getInstanceMethod([UIViewController class], @selector(viewWillAppear:));
    Method SW_viewAppear = class_getInstanceMethod([UIViewController class], @selector(SW_viewWillAppear:));
    method_exchangeImplementations(viewAppear, SW_viewAppear);
    Method viewdisAppear = class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear:));
    Method SW_viewdisAppear = class_getInstanceMethod([UIViewController class], @selector(SW_viewWillDisappear:));
    method_exchangeImplementations(viewdisAppear, SW_viewdisAppear);
}
-(void)SW_viewWillAppear:(BOOL)animation{
    
    [self SW_viewWillAppear:animation];
    if (self.title) {
//        [MobClick beginLogPageView:self.title];
    }
}
-(void)SW_viewWillDisappear:(BOOL)animation{
    [self SW_viewWillDisappear:animation];
    if (self.title) {
//        [MobClick endLogPageView:self.title];
    }
}
@end
