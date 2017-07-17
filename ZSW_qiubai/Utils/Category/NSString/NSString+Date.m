//
//  NSString+Date.m
//  SP2P_6.1
//
//  Created by 李小斌 on 14-10-9.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)


+(NSString *)converDate:(NSString *)value withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [value doubleValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate: date];
}
+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}


+(NSString *)getCurrentTimewithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)getCurrentTimewithFormat:(NSString *)format date:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getTimeWith:(NSInteger)value
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: value /1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    return [dateFormat stringFromDate: date];
    
}



//根据传入的时间戳 返回时间差
+(NSString *)getTimeIntervalWithconverDate:(NSString *)value{
    double n = [[NSDate date] timeIntervalSince1970]-[value doubleValue];
    
    if (  n < 60) {
        return [NSString stringWithFormat:@"%.0f秒前",n];
    }else if (n < 60*60){
        return [NSString stringWithFormat:@"%.0f分前",n/60];
    }else if (n < 60*60*24){
        return [NSString stringWithFormat:@"%.0f小时前",n/60/60];
    }else if (n < 60*60*24*30){
        return [NSString stringWithFormat:@"%.0f天前",n/60/60/24];
    }else if (n < 60*60*24*365){
        return [NSString stringWithFormat:@"%.0f月前",n/60/60/24/30];
    }else{
        return [NSString stringWithFormat:@"%.0f年前",n/60/60/24/365];
    }
    return @"";
}





@end
