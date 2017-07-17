//
//  UILabel+Extension.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UILabel+Extension.h"
#import "NSString+Extension.h"


@implementation UILabel (Extension)
#pragma mark - 初始化

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
                      color:(UIColor *)color
                  alignment:(NSTextAlignment)alignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:0];
    
    return label;
    
}
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(FontName)fontName size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines
{
    return [UILabel labelWithFrame:frame text:text font:fontName size:size color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor]];
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(FontName)fontName size:(CGFloat)size color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)colorShadow
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont fontForFontName:fontName size:size]];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setShadowColor:colorShadow];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];
    
    return label;
}



+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [self new];
    label.font = font;
    label.textColor = textColor;
    return label;
}

+ (instancetype)labelWithSystemFontSize:(CGFloat)fontSize textColor:(UIColor *)color{
    UILabel *label = [self new];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor =color;
    return label;
}

- (void)colorTextWithColor:(UIColor *)color range:(NSRange)range {
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attrStr;
}

- (void)fontTextWithFont:(UIFont *)font range:(NSRange)range {
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attrStr;
}






- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width{
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}

- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth{
    self.numberOfLines = 0;
    self.text = str;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = resultSize.height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}


@end
