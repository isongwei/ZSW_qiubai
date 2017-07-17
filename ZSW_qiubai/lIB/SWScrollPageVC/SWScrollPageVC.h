//
//  SWScrollPageVC.h
//  仿网易菜单滚动
//
//  Created by iSongWei on 2017/2/22.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWScrollPageVC : UIViewController
// 子控制器数组
@property (nonatomic, strong) NSMutableArray<UIViewController *> *childVCArr;

@property (nonatomic, strong,readonly,getter=titleView) UIScrollView *titleScrollView;

@property (nonatomic,assign) CGRect titleViewFrame;

-(void)updateUI;

@end


    /*
     使用方法
     1  继承
     2 viewDidLoad 中写
     
     NSDictionary * strDic = @{@"Faxian":@"发现",@"Hot":@"热门",@"Xiaoshipin":@"小视频",@"Youxi":@"游戏",};
     
     for (NSString  * str in [strDic allKeys]) {
     Class class = NSClassFromString([NSString stringWithFormat:@"SW_%@ViewController",str]);
     UIViewController * vc = [class new];
     vc.title = strDic[str];
     [self.childVCArr addObject: vc];
     }
     self.titleViewFrame = CGRectMake(0, 0, 250, 44);
     [self updateUI];
     
     self.navigationItem.titleView = self.titleView;
     
     
     */
