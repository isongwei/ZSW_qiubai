//
//  UIButton+timer.m
//  maimaiti2.0
//
//  Created by zhangsongwei on 16/7/13.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "UIButton+timer.h"
#define Timeout 30
#import "UIColor+Extension.h"

@implementation UIButton (timer)







- (void)startTimer
{
    __block int timeout =  Timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:@"发送验证码" forState:UIControlStateNormal];
                [self setTitleColor:[UIColor colorWithHexString:@"282828"] forState:(UIControlStateNormal)];
                self.layer.borderColor = [UIColor colorWithHexString:@"52a6f1"].CGColor;
                self.userInteractionEnabled = YES;
            });
        }
        
        else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 1000;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"%@S",strTime] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor colorWithHexString:@"999999"] forState:(UIControlStateNormal)];
                self.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
 
}



@end


