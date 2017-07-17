//
//  UILabel+Attribute.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)

-(void)labelTextArray:(NSArray<NSString *> *)texts textColorArray:(NSArray<UIColor *> *)colors{
    if (!texts.count) {
        return;
    }
    if (texts.count > colors.count) {
        return;
    }
    NSMutableAttributedString *aString = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    for (int i = 0; i < texts.count; i ++) {
        [aString addAttribute:NSForegroundColorAttributeName value:colors[i] range:[self.text rangeOfString:texts[i]]];
    }
    self.attributedText = aString;
}

-(void )lineSpace:(CGFloat)lineSpace{
    NSMutableAttributedString *attributedString = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSRange range = NSMakeRange(0, [self.text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributedString;
}



@end
