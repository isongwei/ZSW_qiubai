//
//  SWControlView.m
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/23.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SWControlView.h"

@interface SWControlView ()

//当前时间
@property (nonatomic,strong) UILabel *timeLabel;
//总时间
@property (nonatomic,strong) UILabel *totalTimeLabel;
//进度条
@property (nonatomic,strong) UISlider *slider;
//缓存进度条
@property (nonatomic,strong) UISlider *bufferSlier;

@end



@implementation SWControlView

- (void)drawRect:(CGRect)rect {
    [self setupUI];
    
}

-(void)setupUI{
    
    [self addSubview:self.timeLabel];
    [self addSubview:self.totalTimeLabel];
    
    [self addSubview:self.bufferSlier];
    [self addSubview:self.slider];
    [self addSubview:self.largeButton];
    
    
    
    
}

#pragma mark =============懒加载=============


-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, 0, 80, 44))];
        _timeLabel.text = @"00:00:00";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
//        _timeLabel.autoresizingMask =
//        UIViewAutoresizingFlexibleLeftMargin|
//        UIViewAutoresizingFlexibleWidth|
//        UIViewAutoresizingFlexibleHeight|
//        UIViewAutoresizingFlexibleTopMargin;
        
    }
    return _timeLabel;
}
-(UILabel *)totalTimeLabel{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]initWithFrame:(CGRectMake(self.frame.size.width-120, 0, 80, 44))];
        _totalTimeLabel.text = @"00:00:00";
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin;
    }
    return _totalTimeLabel;
}

-(UISlider *)slider{
    if (!_slider) {
        _slider =[[UISlider alloc]initWithFrame:(CGRectMake(80, 0, self.frame.size.width-200, 44))];
        [_slider setThumbImage:[UIImage imageNamed:@"knob"] forState:(UIControlStateNormal)];
        
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_slider addGestureRecognizer:self.tapGesture];
        [_slider addTarget:self action:@selector(handleSliderPosition:) forControlEvents:(UIControlEventValueChanged)];
        _slider.continuous = YES;
        
        _slider.minimumTrackTintColor = [UIColor grayColor];
        _slider.maximumTrackTintColor = [UIColor clearColor];
        
        _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
    }
    return _slider;
    
    
}

-(UIButton *)largeButton{
    
    if (!_largeButton) {
        _largeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _largeButton.frame = CGRectMake(self.frame.size.width-40, 0, 40, 44);
        [_largeButton setImage:[UIImage imageNamed:@"full_screen"] forState:(UIControlStateNormal)];
        [_largeButton addTarget:self action:@selector(hanleLargeBtn:) forControlEvents:UIControlEventTouchUpInside];
        _largeButton.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin;
    }
    return _largeButton;
}

-(UISlider *)bufferSlier{
    
    if (!_bufferSlier) {
        _bufferSlier = [[UISlider alloc]initWithFrame:(self.slider.frame)];
        [_bufferSlier setThumbImage:[UIImage new] forState:(UIControlStateNormal)];
        _bufferSlier.continuous = YES;
        _bufferSlier.minimumTrackTintColor = [UIColor redColor];
        _bufferSlier.minimumValue = 0.0;
        _bufferSlier.maximumValue = 1.0;
        _bufferSlier.userInteractionEnabled = NO;
        _bufferSlier.autoresizingMask =
        UIViewAutoresizingFlexibleWidth;
    }
    return _bufferSlier;
    
    
}

#pragma mark =============事件处理=============
//单击处理
-(void)handleTap:(UITapGestureRecognizer *)gesture{
    
    CGPoint point = [gesture locationInView:self.slider];
    
    CGFloat pointX = point.x;
    CGFloat sliderWidth = self.slider.frame.size.width;
    CGFloat currentValue = pointX/sliderWidth * self.slider.maximumValue;
    
    NSLog(@"%@",NSStringFromCGPoint(point));
    NSLog(@"%f",currentValue);
    
    [self.slider setValue:currentValue];
    if ([self.delegate respondsToSelector:@selector(controlView:pointSliderLocationWithCurrentValue:)]) {
        [self.delegate controlView:self pointSliderLocationWithCurrentValue:currentValue];
    }
    
}

-(void)handleSliderPosition:(UISlider *)slider{
    
    if ([self.delegate respondsToSelector:@selector(controlView:draggedPositionWithSlider:)]) {
        [self.delegate controlView:self draggedPositionWithSlider:self.slider];
    }
    
}

-(void)hanleLargeBtn:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(controlView:withLargeButton:)]) {
        [self.delegate controlView:self withLargeButton:self.largeButton];
    }
    
}





    




#pragma mark =============一些个属性=============

-(void)setValue:(CGFloat)value{
    self.slider.value = value;
}
-(CGFloat)value{
    return self.slider.value;
}


-(void)setMinValue:(CGFloat)minValue{
    self.slider.minimumValue = minValue;
    
}
-(CGFloat)minValue{
    return self.slider.minimumValue;
}

-(void)setMaxValue:(CGFloat)maxValue{
    self.slider.maximumValue = maxValue;
}
-(CGFloat)maxValue{
    return self.slider.maximumValue;
}

-(void)setCurrentTime:(NSString *)currentTime{
    self.timeLabel.text = currentTime;
    
}
-(NSString *)currentTime{
    return self.timeLabel.text;
    
}

-(void)setTotalTime:(NSString *)totalTime{
    self.totalTimeLabel.text = totalTime;
}
-(NSString *)totalTime{
    return self.totalTimeLabel.text;
}


-(void)setBufferValue:(CGFloat)bufferValue{
    self.bufferSlier.value = bufferValue;
}
-(CGFloat)bufferValue{
    return self.bufferSlier.value;
}




@end
