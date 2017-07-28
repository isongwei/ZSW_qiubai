
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//
#import "UIView+Extension.h"
#import "UIView+Frame.h"
#import "UIColor+Extension.h"
@implementation UIView (Extension)


- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius>0;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

/*----------------------------------------------------------------------------------------*/




/*-------------------------------------------------------------------*/
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
    
    
//    UIGraphicsBeginImageContext(self.frame.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
    
}

- (UIImage *)screenshotWithOffset:(CGFloat)deltaY
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //  KEY: need to translate the context down to the current visible portion of the tablview
    CGContextTranslateCTM(ctx, 0, deltaY);
    [self.layer renderInContext:ctx];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (void)pulseViewWithTime:(CGFloat)seconds
{
    [UIView animateWithDuration:seconds/6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:seconds/6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    [UIView animateWithDuration:seconds/6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            [UIView animateWithDuration:seconds/6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if(finished)
                                {
                                    [UIView animateWithDuration:seconds/6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if(finished)
                                        {
                                            [UIView animateWithDuration:seconds/6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:^(BOOL finished) {
                                                if(finished)
                                                {
                                                    
                                                }
                                            }];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

// Animations
- (void)shakeView
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = .1f;
    
    //重复
    kfa.repeatCount =2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self.layer addAnimation:kfa forKey:@"shake"];
}




- (void)createBordersColor:(UIColor *)color
              CornerRadius:(CGFloat)radius
                     Width:(CGFloat)width{
    [self.layer setMasksToBounds:YES];
    self.layer.borderWidth = width;
    color? self.layer.borderColor = color.CGColor:NULL;
    self.layer.cornerRadius = radius;
    
}
- (void)removeCornerRadius{
    self.layer.cornerRadius = 0;
}
- (void)removeBorders
{
    self.layer.borderWidth = 0;
    self.layer.borderColor = nil;
    
}





// Shadows
- (void)removeShadow
{
    [self.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self.layer setShadowOpacity:0.0f];
    [self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

- (void)createRectShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.masksToBounds = NO;
}

- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shouldRasterize = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:cornerRadius] CGPath];
    self.layer.masksToBounds = NO;
}


#pragma mark - ===============渐变色===============
//Transparent Gradient Layer
- (void) insertTransparentGradientWithFrame:(CGRect)frame color:(UIColor *)color direction:(NSInteger)dir{
    UIColor *colorOne = [UIColor colorWithColor:color  alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithColor:color  alpha:0.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    

    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    if (dir == 0) {
        headerLayer.startPoint = CGPointMake(1, 0);
        headerLayer.endPoint = CGPointMake(0, 0);
        
    }else{
        headerLayer.startPoint = CGPointMake(0, 0);
        headerLayer.endPoint = CGPointMake(1, 0);
        
    }
 
    headerLayer.frame = frame;
    
    [self.layer addSublayer:headerLayer];
     //insertSublayer:headerLayer atIndex:0];
}


//color gradient layer
- (void) insertColorGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(33/255.0)  green:(33/255.0)  blue:(33/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = CGRectMake(0, 0, 44, 44);
    
    [self.layer insertSublayer:headerLayer above:0];
    
}
@end













@interface __UIView : UIView @end
IB_DESIGNABLE
@implementation __UIView @end

@interface __UIButton : UIButton @end
IB_DESIGNABLE
@implementation __UIButton @end



@interface __UILabel : UILabel @end
IB_DESIGNABLE
@implementation __UILabel @end

@interface __UIImageView : UIImageView @end
IB_DESIGNABLE
@implementation __UIImageView @end





