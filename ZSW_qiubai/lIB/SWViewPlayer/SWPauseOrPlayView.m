//
//  SWPauseOrPlayView.m
//  播放视频demo
//
//  Created by 张松伟 on 2017/7/30.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SWPauseOrPlayView.h"

@implementation SWPauseOrPlayView




-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.imageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        
        [self.imageBtn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
        [self.imageBtn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateSelected)];
        [self.imageBtn setShowsTouchWhenHighlighted:YES];
        
        [self.imageBtn addTarget:self action:@selector(handleImageTapAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        self.imageBtn.backgroundColor = [UIColor whiteColor];
        self.imageBtn.frame = self.bounds;
        [self addSubview:self.imageBtn];
    }
    return self;
    
}




-(void)handleImageTapAction:(UIButton *)button{
    
    button.selected = !button.selected;
    
    _state = button.isSelected?YES:NO;
    
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:_state];
    }
    
}




@end
