//
//  SW_LiveViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_LiveViewCtrl.h"

@interface SW_LiveViewCtrl ()

@end

@implementation SW_LiveViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * strDic = @{
                              @"所有":@"SW_AllViewCtrl",
                              @"家族":@"SW_FamilyViewCtrl",
                       
                              };
    
    NSArray * cla = @[@"所有",@"家族"];
    
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
- (void)didTapNextButton {
    
    
}

@end
