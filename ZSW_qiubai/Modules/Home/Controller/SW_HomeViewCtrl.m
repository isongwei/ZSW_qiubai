//
//  SW_HomeViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_HomeViewCtrl.h"

#import "SW_ZhuanXiangViewCtrl.h"

@interface SW_HomeViewCtrl ()

@end

@implementation SW_HomeViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * strDic = @{
                              @"专享":@"SW_ZhuanXiangViewCtrl",
                              @"视频":@"SW_ZhuanXiangViewCtrl",
                              @"爆社":@"SW_ZhuanXiangViewCtrl",
                              @"纯文":@"SW_ZhuanXiangViewCtrl",
                              @"纯图":@"SW_ZhuanXiangViewCtrl",
                              @"精华":@"SW_ZhuanXiangViewCtrl",
                              @"穿越":@"SW_ZhuanXiangViewCtrl",
                              };
    
    NSArray * cla = @[@"专享",@"视频",@"爆社",@"纯文",@"纯图",@"精华",@"穿越"];
    
    for (NSString  * str in cla) {
        Class class = NSClassFromString(strDic[str]);
        UIViewController * vc = [class new];
        vc.title = str;
        [self.childVCArr addObject: vc];
    }
    
    
    self.titleViewFrame = CGRectMake(0, 0, KScreenWidth-88, 44);
    [self updateUI];
    
    self.navigationItem.titleView = self.titleView;
    
    

}



@end
