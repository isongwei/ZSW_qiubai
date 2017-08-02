//
//  SWPauseOrPlayView.h
//  播放视频demo
//
//  Created by 张松伟 on 2017/7/30.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWPauseOrPlayView;
@protocol SWPauseOrPlayViewDelegate <NSObject>

//@required
/**
 暂停和播放视图和状态
 
 @param pauseOrPlayView 暂停或者播放视图
 @param state 返回状态
 */
-(void)pauseOrPlayView:(SWPauseOrPlayView *)pauseOrPlayView withState:(BOOL)state;

@end


@interface SWPauseOrPlayView : UIView

@property (nonatomic,strong) UIButton * imageBtn;
@property (nonatomic,weak) id<SWPauseOrPlayViewDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL state;


@end
