//
//  UITextView+Extension.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)KeyboardToolView:(UIView*)keyBoardToolView{
    if (self && keyBoardToolView) {
        self.inputAccessoryView  = keyBoardToolView;
    }
}

@end
