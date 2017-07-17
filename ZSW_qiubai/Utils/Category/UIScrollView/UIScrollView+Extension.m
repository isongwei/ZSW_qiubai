//
//  UIScrollView+Extension.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)


- (void)animationWithNavigationController:(UINavigationController *)nav TabBarController:(UITabBarController *)tab{
    
    

    
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer *pan = self.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:self].y;
    if (velocity < -5) {
        //向上拖动，隐藏导航栏
        
        if (nav) {
            
            
            [nav setNavigationBarHidden:YES animated:YES];
            
//            CGRect frame = CGRectMake(0, -64, SCREEN_WIDTH, 64);
//            [UIView animateWithDuration:0.25f animations:^{
//                nav.navigationBar.frame = frame;
//            }completion:^(BOOL finished) {
//                
//            }];
//            
            
        }
        if (tab) {
            
            [self setTabBar:tab Hidden:YES];

            
            
        }
        
        
        
        
    }else if (velocity > 5) {
        //向下拖动，显示导航栏

        
        if (nav) {
            [nav setNavigationBarHidden:NO animated:YES];
            
//            CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//            [UIView animateWithDuration:0.25f animations:^{
//                nav.navigationBar.frame = frame;
//            }completion:^(BOOL finished) {
//                
//            }];
         
        }
        if (tab) {
            [self setTabBar:tab Hidden:NO];
            
            
            
        }
        
        
        
        
        
        
    }else if(velocity == 0){
        //停止拖拽
    }
    
}


#pragma mark - privite
//隐藏显示tabbar
- (void)setTabBar:(UITabBarController *)tab Hidden:(BOOL)hidden
{
    UIView *tabView = tab.view;
    CGRect tabRect = tab.tabBar.frame;
    if ([tabView.subviews count] < 2) {
        return;
    }
    
    UIView *view;
    if ([[tabView.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tabView.subviews objectAtIndex:1];
    } else {
        view = [tabView.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tabView.bounds;
        tabRect.origin.y = KScreenHeight + tab.tabBar.frame.size.height;
    } else {
        view.frame = CGRectMake(tabView.bounds.origin.x, tabView.bounds.origin.y, tabView.bounds.size.width, tabView.bounds.size.height);
        tabRect.origin.y = KScreenHeight - tab.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        tab.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}





@end
