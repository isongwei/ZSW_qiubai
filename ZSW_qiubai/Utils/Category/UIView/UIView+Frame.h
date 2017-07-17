//
//  UIView+Frame.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/19.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@end
