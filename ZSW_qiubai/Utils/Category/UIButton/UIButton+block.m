//
//  UIButton+block.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UIButton+block.h"

@implementation UIButton (block)


-(UIButton *(^)(NSString * ,UIControlState))sw_title{
    return ^(NSString *title,UIControlState s){
        [self setTitle:title forState:(s)];
        return self;
    };
}
-(UIButton *(^)(UIColor * ,UIControlState))sw_titleColor{
    return ^(UIColor *c,UIControlState s){
        [self setTitleColor:c forState:(s)];
        return self;
    };
}
-(UIButton *(^)(CGRect ))sw_frame{
    return ^(CGRect f){
        self.frame = f;
        return self;
    };
}
-(UIButton *(^)(UIColor *))sw_bgColor{
    return ^(UIColor * c){
        self.backgroundColor = c;
        return self;
    };
}

@end
