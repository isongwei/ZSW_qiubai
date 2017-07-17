//
//  UILabel+Extension.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+Extension.h"
@interface UILabel (Extension)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                       fontSize:(CGFloat)size
                      color:(UIColor *)color
                  alignment:(NSTextAlignment)alignment;

+ (UILabel *)labelWithFrame:(CGRect)frame
                      text:(NSString *)text
                      font:(FontName)fontName
                      size:(CGFloat)size
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines;



+ (UILabel *)labelWithFrame:(CGRect)frame
                      text:(NSString *)text
                      font:(FontName)fontName
                      size:(CGFloat)size
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
                     lines:(NSInteger)lines
               shadowColor:(UIColor *)colorShadow;


+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)labelWithSystemFontSize:(CGFloat)fontSize textColor:(UIColor *)color;

- (void)colorTextWithColor:(UIColor *)color range:(NSRange)range;
- (void)fontTextWithFont:(UIFont *)font range:(NSRange)range;

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width;
- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;
- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth;





@end
