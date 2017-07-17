//
//  SW_BaseNavCtrl.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_BaseNavCtrl.h"

@interface SW_BaseNavCtrl ()

@end

@implementation SW_BaseNavCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
}



@end
