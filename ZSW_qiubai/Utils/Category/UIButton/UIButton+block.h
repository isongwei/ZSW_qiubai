//
//  UIButton+block.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (block)


-(UIButton *(^)(NSString * ,UIControlState))sw_title;
-(UIButton *(^)(UIColor * ,UIControlState))sw_titleColor;
-(UIButton *(^)(CGRect ))sw_frame;
-(UIButton *(^)(UIColor *))sw_bgColor;

@end
