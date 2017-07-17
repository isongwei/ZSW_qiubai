//
//  UILabel+Attribute.h
//  SWFrame
//
//  Created by iSongWei on 2017/6/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attribute)



/**
 label 的相应文字颜色

 @param texts text数组
 @param colors color数组
 */
-(void)labelTextArray:(NSArray<NSString *> *)texts textColorArray:(NSArray<UIColor *> *)colors;

/**
 行间距
 
 @param lineSpace 距离
 */
-(void )lineSpace:(CGFloat)lineSpace;




@end
