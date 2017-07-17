//
//  UIColor+Extension.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)


+ (UIColor *)randomColor;

+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;


+(UIColor *) colorWithHexString: (NSString *) colorString;
+(UIColor *) colorWithHexString: (NSString *) colorString
                          alpha:(CGFloat)alpha;



//获取值
- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;

- (UIColor *)darkerColor;
- (UIColor *)lighterColor;
- (BOOL)isLighterColor;
- (BOOL)isClearColor;

@end
