//
//  UITextField+Extension.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
#pragma mark - 设置键盘上方工具条
- (void)KeyboardToolView:(UIView*)keyBoardToolView {
    if (self && keyBoardToolView) {
        self.inputAccessoryView  = keyBoardToolView;
    }
}
@end
