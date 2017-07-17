
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//
#import <UIKit/UIKit.h>



@interface UIView (Extension)

/**
 *  可以在xib里面直接设置的:圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/**
 *  可以在xib里面直接设置的:边线宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 *  可以在xib里面直接设置的:边线颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *borderColor;





/*----------------------------------------------------------------------------------------*/


- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;
/*----------------------------------------------------------------------------------------*/

//放大
- (void)pulseViewWithTime:(CGFloat)seconds;
- (void)shakeView;
/**
 左右
 */
-(void)shake;

/**
 边距
 */
- (void)createBordersColor:(UIColor *)color
              CornerRadius:(CGFloat)radius
                      Width:(CGFloat)width;
- (void)removeCornerRadius;
- (void)removeBorders;

- (void)removeShadow;
- (void)createRectShadowWithOffset:(CGSize)offset
                           opacity:(CGFloat)opacity
                            radius:(CGFloat)radius;

- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                          offset:(CGSize)offset
                                         opacity:(CGFloat)opacity
                                          radius:(CGFloat)radius;
#pragma mark - ===============渐变色===============
- (void) insertTransparentGradientWithFrame:(CGRect)frame color:(UIColor *)color direction:(NSInteger)dir;

@end
