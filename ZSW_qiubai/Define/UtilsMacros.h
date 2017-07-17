//
//  UtilsMacros.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//接口服务器地址
#define NetClient [NetWorkClient sharedClient]



//获取系统对象

#define kApplication [UIApplication sharedApplication]

#define kAppWindow [UIApplication sharedApplication].delegate.window

#define kAppDelegate [AppDelegate shareAppDelegate]

#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高

#define KScreenWidth ([[UIScreen mainScreen]bounds].size.width)

#define KScreenHeight [[UIScreen mainScreen]bounds].size.height

#define kScreen_Bounds [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth KScreenWidth/375.0

#define Iphone6ScaleHeight KScreenHeight/667.0

//根据ip6的屏幕来拉伸

#define kRealValue(with)((with)*(KScreenWidth/375.0f))

//强弱引用

//weak

#define WS(weakSelf);  __weak __typeof(&*self)weakSelf = self;


#define kWeakSelf(type); __weak typeof(type)weak##type = type;

#define kStrongSelf(type); __strong typeof(type)type = weak##type;


//property属性快速声明

#define PropertyString(s)@property(nonatomic,copy)NSString * s

#define PropertyNSInteger(s)@property(nonatomic,assign)NSIntegers

#define PropertyFloat(s)@property(nonatomic,assign)floats

#define PropertyLongLong(s)@property(nonatomic,assign)long long s

#define PropertyNSDictionary(s)@property(nonatomic,strong)NSDictionary * s

#define PropertyNSArray(s)@property(nonatomic,strong)NSArray * s

#define PropertyNSMutableArray(s)@property(nonatomic,strong)NSMutableArray * s

///IOS版本判断

#define IOSAVAILABLEVERSION(version)([[UIDevice currentDevice]availableVersion:version]< 0)

//当前系统版本

#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//当前语言

//#define CurrentLanguage  ([NSLocale preferredLanguages] objectAtIndex:0])

//-------------------打印日志-------------------------



//打印日志

#ifdef DEBUG

#define DLog(format, ...) printf("\n时间:[%s] 方法:%s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(format, ...)
#endif


//DEBUG模式下打印日志,当前行


//#ifdef DEBUG
//
//#define DLog(fmt,...) NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);
//
//#else
//
//#define DLog(...)
//
//#endif

//拼接字符串

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


//定义UIImage对象

#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@@%dx",_pointer,(int)[UIScreen mainScreen].nativeScale]ofType:@"png"])]

#define IMAGE_NAMED(name)[UIImage imageNamed:name]

//数据验证

#define StrValid(f)(f!=nil &&[f isKindOfClass:[NSString class]]&& ![f isEqualToString:@""])

#define SafeStr(f)(StrValid(f)?f:@"")

#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f)StrValid(f)

#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])

#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)

#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])

#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])

#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])

//获取一段时间间隔

#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();

#define kEndTime NSLog(@"Time: %f",CFAbsoluteTimeGetCurrent()- start)

//打印当前方法名

#define __SWFUNC__ DLog(@"%s",__func__);

#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s",__PRETTY_FUNCTION__);

//GCD

#define kDISPATCH_ASYNC_BLOCK(block)dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block)

#define kDISPATCH_MAIN_BLOCK(block)dispatch_async(dispatch_get_main_queue(),block)

//GCD -一次性执行

#define kDISPATCH_ONCE_BLOCK(onceBlock)static dispatch_once_t onceToken;dispatch_once(&onceToken,onceBlock);

////单例化一个类
//
//#define SINGLETON_FOR_HEADER(className)\
//
//\
//
//+(className *)shared##className;
//
//#define SINGLETON_FOR_CLASS(className)\
//
//\
//
//+(className *)shared##className { \
//    
//    static className *shared##className = nil;\
//    
//    static dispatch_once_t onceToken;\
//    
//    dispatch_once(&onceToken,^{ \
//        
//        shared##className =[[self alloc]init];\
//        
//    });\
//    
//    return shared##className;\
//    
//}

#endif /* UtilsMacros_h */
