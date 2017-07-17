//
//  NSString+UserInfo.h
//  SP2P_6.1
//
//  Created by 李小斌 on 14-10-9.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UserInfo)


/*
 * 判断字符串是否金额
 */
-(BOOL)isNumber;

/*
 * 判断字符串是否为空白的
 */
- (BOOL)isBlank;

/*
 * 判断字符串是否为空
 */
- (BOOL)isEmpty;

/*
 * 给字符串md5加密
 */
- (NSString *)md5;

/**
 * 判断字符串是否是email格式
 */
- (BOOL)isEmail;

/**
 * 判断字符串是否是手机号码格式
 */
- (BOOL)isPhone;


/*-------------------------------------------------------------*/

// 把手机号第4-7位变成星号
+(NSString *)phoneNumToAsterisk:(NSString*)phoneNum;

// 把手机号第5-14位变成星号
+(NSString *)idCardToAsterisk:(NSString *)idCardNum;

// 判断是否是身份证号码
+(BOOL)validateIdCard:(NSString *)idCard;

// 邮箱验证
+(BOOL)validateEmail:(NSString *)email;

// 手机号码验证
+(BOOL)validateMobile:(NSString *)mobile;

//用户名字母数字
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称汉字
+ (BOOL)validateRealname:(NSString *)nickname;
@end
