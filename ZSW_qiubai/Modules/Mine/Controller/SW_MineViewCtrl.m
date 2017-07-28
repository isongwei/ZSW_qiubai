//
//  SW_MineViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_MineViewCtrl.h"

@interface SW_MineViewCtrl ()

@end

@implementation SW_MineViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self presentViewController:[[SW_LoginViewCtrl alloc]init] animated:YES completion:nil];
    
}

@end
