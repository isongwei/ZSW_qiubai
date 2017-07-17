//
//  UIButton+Extension.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/15.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (NSString *)title {
    
    [self setTitle:objc_getAssociatedObject(self, @selector(title)) forState:0];
    return objc_getAssociatedObject(self, @selector(title));
}

- (void)setTitle:(NSString *)title {
    NSString *tempText = (title==nil||[title isKindOfClass:[NSNull class]]?@"":title);
    if ([tempText isKindOfClass:[NSNumber class]]) {
        tempText = [NSString stringWithFormat:@"%@",tempText];
    } else if (![tempText isKindOfClass:[NSString class]]) {
        tempText = @"";
    }
    objc_setAssociatedObject(self, @selector(title), tempText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UIFont *)font{
    
    return self.titleLabel.font;
}

-(void)setFont:(UIFont *)font{
    
    self.titleLabel.font = font;
}






#pragma mark - ==============================

-(void)buttonWithTitle:(NSString *)title
                color:(UIColor *)color
               sColor:(UIColor *)sColor
               hColor:(UIColor *)hColor
                Image:(UIImage *)image
               sImage:(UIImage *)sImage
               hImage:(UIImage *)hImage
              BGImage:(UIImage *)BGImage
             sBGImage:(UIImage *)sBGImage
             hBGImage:(UIImage *)hBGImage
{

    title? [self setTitle:title forState:UIControlStateNormal]:NULL;
    color?[self setTitleColor:color forState:UIControlStateNormal]:NULL;
    sColor?[self setTitleColor:color forState:UIControlStateSelected]:NULL;
    hColor?[self setTitleColor:hColor forState:UIControlStateHighlighted]:NULL;
    
    image?[self setImage:image forState:(UIControlStateNormal)]:NULL;
    sImage?[self setImage:sImage forState:(UIControlStateSelected)]:NULL;
    hImage? [self setImage:hImage forState:(UIControlStateHighlighted)]:NULL;
    
    BGImage?[self setBackgroundImage:BGImage forState:UIControlStateNormal]:NULL;
    sBGImage?[self setBackgroundImage:sBGImage forState:UIControlStateSelected]:NULL;
    hBGImage?[self setBackgroundImage:hBGImage forState:UIControlStateHighlighted]:NULL;
    
}
+ (id)buttonWithFrame:(CGRect)frame
                title:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    title? [button setTitle:title forState:UIControlStateNormal]:NULL;
    return button;
    
}
+ (id)buttonWithFrame:(CGRect)frame{
    return  [UIButton buttonWithFrame:frame title:nil];
}



-(void)setTitle:(NSString *)title
        color:(UIColor *)color
       sColor:(UIColor *)sColor
       hColor:(UIColor *)hColor{
    title? [self setTitle:title forState:UIControlStateNormal]:NULL;
    color?[self setTitleColor:color forState:UIControlStateNormal]:NULL;
    sColor?[self setTitleColor:color forState:UIControlStateSelected]:NULL;
    hColor?[self setTitleColor:hColor forState:UIControlStateHighlighted]:NULL;
}


-(void)setImage:(UIImage *)image
         sImage:(UIImage *)sImage
         hImage:(UIImage *)hImage{
    image?[self setImage:image forState:(UIControlStateNormal)]:NULL;
    sImage?[self setImage:sImage forState:(UIControlStateSelected)]:NULL;
    hImage? [self setImage:hImage forState:(UIControlStateHighlighted)]:NULL;
}



-(void)setBGImage:(UIImage *)BGImage
         sBGImage:(UIImage *)sBGImage
         hBGImage:(UIImage *)hBGImage{
    BGImage?[self setBackgroundImage:BGImage forState:UIControlStateNormal]:NULL;
    sBGImage?[self setBackgroundImage:sBGImage forState:UIControlStateSelected]:NULL;
    hBGImage?[self setBackgroundImage:hBGImage forState:UIControlStateHighlighted]:NULL;
}

#pragma mark - 设置圆角
- (void)setCornerRadius:(CGFloat)Radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor *)borderColor{
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:Radius];
    (borderColor > 0)?[self.layer setBorderWidth:borderWidth]:NULL;
    [self.layer setBorderColor:borderColor.CGColor];
    
}

//开始请求时，UIActivityIndicatorView 提示
static char EAActivityIndicatorKey;
- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator{
    objc_setAssociatedObject(self, &EAActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIActivityIndicatorView *)activityIndicator{
    return objc_getAssociatedObject(self, &EAActivityIndicatorKey);
}

- (void)startQueryAnimate{
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicator];
        
        self.activityIndicator.center=self.center;
    }
    [self.activityIndicator startAnimating];
    self.enabled = NO;
}
- (void)stopQueryAnimate{
    [self.activityIndicator stopAnimating];
    self.enabled = YES;
}
@end
