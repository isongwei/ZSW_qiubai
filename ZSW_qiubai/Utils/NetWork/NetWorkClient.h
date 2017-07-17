//
//  NetWorkClient.h
//  MyFrame
//
//  Created by 张松伟 on 16/4/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@interface MainModel : NSObject


@property (nonatomic,assign) NSInteger err;
@property (nonatomic,assign) NSInteger refresh;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) NSArray * items;
@property (nonatomic,strong) NSArray * lives;//直播
@property (nonatomic,strong) NSArray * banners;//直播

@end




@interface NetWorkClient : AFHTTPSessionManager

typedef NS_ENUM(NSUInteger, httpRequestType)
{
    requestTypeGet = 0,
    requestTypePost
};


//网络是否可用


-(BOOL)isNetworkEnabled;

+(NetWorkClient *)sharedClient;
/**
 *  GET
 *
 *  @param urlString   请求网址
 *  @param parameter   参数
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameter:(NSDictionary *)parameter
                     success:(void(^)(MainModel * dataModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock;
/**
 *  POST
 *
 *  @param urlString   请求网址
 *  @param parameter   参数
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */




-(NSURLSessionDataTask *)POST:(NSString *)urlString
                    parameter:(NSDictionary *)parameter
                      success:(void(^)(MainModel * dataModel))succedBlock
                      failure:(void(^)(NSError * error))failedBlock;
/**
 *  upload数据请求
 *
 *  @param urlString   请求网址
 *  @param parameter   上传参数
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)upload:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                   startRequest:(void(^)(void))start
                        success:(void(^)(MainModel * MainModel ))succedBlock
                        failure:(void(^)(NSError * error))failedBlock;
/**
 *  取消操作
 */


-(void)cancel;

@end
