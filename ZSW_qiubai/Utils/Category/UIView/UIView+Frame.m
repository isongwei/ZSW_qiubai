//
//  UIView+Frame.m
//  SWFrame
//
//  Created by iSongWei on 2017/6/19.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size{
    return self.frame.size;
}



- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGPoint)origin{
    return self.frame.origin;
}



- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}


- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}


- (CGFloat)centerY{
    return self.center.y;
}


- (void)setTop:(CGFloat)t
{
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b
{
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l
{
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r
{
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

@end
