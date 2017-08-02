//
//  SW_BaseTabBarCtrl.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_BaseTabBarCtrl.h"
#import "SW_BaseNavCtrl.h"


@interface SW_BaseTabBarCtrl ()



@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation SW_BaseTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array  =[NSMutableArray array];
    [self createUI];

}



-(void)createUI{
 
    //点击颜色
    self.tabBar.tintColor = [UIColor orangeColor];
//    [UIColor colorWithRed:0.00f green:0.85f blue:0.79f alpha:1.00f];
    
//    self.tabBar.barTintColor = [UIColor redColor]; //背景色
    
    [self addViewControllerString:@"SW_HomeViewCtrl" Title:@"首页"  imagestr:@"icon_main"];
    [self addViewControllerString:@"SW_FriendsCircleViewCtrl" Title:@"糗友圈" imagestr:@"main_tab_qbfriends"];
    [self addViewControllerString:@"SW_LiveViewCtrl" Title:@"直播"  imagestr:@"main_tab_live"];
    [self addViewControllerString:@"SW_NoteViewCtrl" Title:@"小纸条"  imagestr:@"icon_chat"];
    [self addViewControllerString:@"SW_MineViewCtrl" Title:@"我的"  imagestr:@"icon_me"];
    
    

    
}

-(void)addViewControllerString:(NSString *)ctrlName Title:(NSString *)title imagestr:(NSString *)imagestr{
    
    Class class = NSClassFromString(ctrlName);
    UIViewController * VC = [[class alloc]init];
    
    SWNavigationController * nav = [[SWNavigationController alloc]initWithRootViewController:VC];
    nav.fullScreenPopGestureEnabled = YES;
    
    VC.tabBarItem.image = [[UIImage imageNamed:imagestr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:[imagestr stringByAppendingString:@"_active"]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
//    VC.tabBarItem.imageInsets = UIEdgeInsetsMake(12, 0, -12, 0);
//    VC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 40);
    
    VC.title = title;
    
    
    
    [_array addObject:nav];
    self.viewControllers = _array;
}

@end
