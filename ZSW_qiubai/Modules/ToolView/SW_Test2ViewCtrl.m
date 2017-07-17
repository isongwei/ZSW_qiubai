//
//  SW_Test2ViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/17.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_Test2ViewCtrl.h"
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface SW_Test2ViewCtrl ()

@end

@implementation SW_Test2ViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}



-(void)setup{
    
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:@"" withOptions:nil];
}


@end
