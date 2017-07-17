
//
//  FontAndColorMacros.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

//颜色

#define KTextColor1 [UIColor colorWithRed:1.00f green:0.74f blue:0.00f alpha:1.00f] //报社黄色
#define KTextColor2 [UIColor colorWithRed:0.28f green:0.28f blue:0.28f alpha:1.00f] // 正常文字
#define KTextColor3 [UIColor colorWithRed:0.58f green:0.58f blue:0.61f alpha:1.00f]//名字颜色

#define KBGColor [UIColor colorWithHexString:@"f5f5f5"]//VC背景颜色


#define KClearColor [UIColor clearColor]

#define KWhiteColor [UIColor whiteColor]

#define KBlackColor [UIColor blackColor]

#define KGrayColor [UIColor grayColor]

#define KGray2Color [UIColor lightGrayColor]

#define KBlueColor [UIColor blueColor]

#define KRedColor [UIColor redColor]

//颜色
#define RGBColor(...)  [UIColor colorWithHexString:__VA_ARGS__]


#define kRandomColor KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)//随机色生成

//字体

#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE) [UIFont systemFontOfSize:FONTSIZE]

#define FONT(NAME,FONTSIZE) [UIFont fontWithName:(NAME)size:(FONTSIZE)]


#endif /* FontAndColorMacros_h */
