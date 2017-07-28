//
//  SW_LoginViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/17.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_LoginViewCtrl.h"

@interface SW_LoginViewCtrl ()

@end

@implementation SW_LoginViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithColor:[UIColor redColor] alpha:0.5];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
