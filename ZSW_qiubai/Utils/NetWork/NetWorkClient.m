//
//  NetWorkClient.m
//  MyFrame
//
//  Created by 张松伟 on 16/4/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "NetWorkClient.h"
#import "MJExtension.h"

#define BaseAPI @"http://119.29.47.97"
#define TimeoutInterval 15


@implementation MainModel

@end



@interface NetWorkClient ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end


@implementation NetWorkClient


+(NetWorkClient *)sharedClient
{
    static NetWorkClient *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance = [[NetWorkClient alloc] initWithBaseURL:[NSURL URLWithString:BaseAPI] ];
        
        
        sharedAccountManagerInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
        sharedAccountManagerInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/javascript",@"text/plain",@"text/json",@"application/json",nil];
        
        
        sharedAccountManagerInstance.requestSerializer = [AFHTTPRequestSerializer serializer];
        [sharedAccountManagerInstance.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        sharedAccountManagerInstance.requestSerializer.timeoutInterval = TimeoutInterval;
        [sharedAccountManagerInstance.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    });
    return sharedAccountManagerInstance;

    
}
#pragma mark - get

-(NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameter:(NSDictionary *)parameter
                     success:(void(^)(MainModel * dataModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock{
    return [self request:urlString parameter:parameter  success:succedBlock failure:failedBlock methods:(requestTypeGet)];
}
#pragma mark - post
-(NSURLSessionDataTask *)POST:(NSString *)urlString
                   parameter:(NSDictionary *)parameter
                     success:(void(^)(MainModel * dataModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock{
    
    return [self request:urlString parameter:parameter success:succedBlock failure:failedBlock methods:(requestTypePost)];
}
#pragma mark - ===============request===============
-(NSURLSessionDataTask *)request:(NSString *)urlString
                       parameter:(NSDictionary *)parameter
                     success:(void(^)(MainModel * dataModel))succedBlock
                         failure:(void(^)(NSError * error))failedBlock
                         methods:(httpRequestType)methods{

    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [self setSecurityPolicy:securityPolicy];
    
    [self.requestSerializer setValue:@"m2.qiushibaike.com" forHTTPHeaderField:@"Host"];
    if ([urlString containsString:@"live/"]) {
        [self.requestSerializer setValue:@"live.qiushibaike.com" forHTTPHeaderField:@"Host"];
    }
    
    
    
    
    [self.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"ios_e23460dd76b599d88fec8c112b4edf3923c964b5" forHTTPHeaderField:@"Uuid"];
    //39a1eab5c004984d5711f16d35bf2c60d671e0c0
    [self.requestSerializer setValue:@" " forHTTPHeaderField:@"Qbtoken"];
    [self.requestSerializer setValue:@"QiuBai/10.12.8 rv:0 (iPhone; iOS 10.3.2; zh_CN) PLHttpClient/1_WIFI" forHTTPHeaderField:@"User-Agent"];
    [self.requestSerializer setValue:@"ios_10.12.8" forHTTPHeaderField:@"Source"];
    [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"app"];
    [self.requestSerializer setValue:@"zh-Hans;q=1" forHTTPHeaderField:@"Accept-Language"];
   

    
    
    if (methods == requestTypeGet) {
        _dataTask = [self GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            MainModel * model = [MainModel mj_objectWithKeyValues:dic];
            succedBlock(model);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failedBlock(error);
        }];
    }else{
        _dataTask = [self POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            MainModel * model = [MainModel mj_objectWithKeyValues:dic];
            succedBlock(model);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failedBlock(error);
        }];
    }

    return _dataTask;
}



-(void)cancel{
    if (_dataTask != nil) {
        [_dataTask cancel];
    }
}
#pragma mark - 判断当前网络是否可用
-(BOOL)isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}





/*
#pragma mark - upload
-(NSURLSessionDataTask *)upload:(NSString *)urlString
                    parameter:(NSDictionary *)parameter networkError:(void(^)(void))netError
                 startRequest:(void(^)(void))start
                      success:(void(^)(MainModel * MainModel,NSURLSessionDataTask *dataTask,NetWorkClient *client))succedBlock
                      failure:(void(^)(NSError * error,NSURLSessionDataTask *dataTask,NetWorkClient *client))failedBlock{
    

    if (parameter == nil) {
        parameter = @{};
    }
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString * upstr = [NSString encrypt3DES:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] key:DESAPIKEY];
    NSData * postData = [upstr dataUsingEncoding:NSUTF8StringEncoding];
    

    
    
    if (![self isNetworkEnabled]) {
        //网络出错
        if (netError == nil) {
            [MBProgressHUD showError:@"网络异常"];
        }else{
            netError();
            [MBProgressHUD showError:@"网络异常"];
        }
        
        return nil;
    }else{
        //开始请求

        if (start == nil) {

        }else{
            
            start();
            
        }
        
        // 网络指示器开始显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        _dataTask = [self POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFormData:postData name:@"body"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            DLOG(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];

            MMTMainModel * model = [MMTMainModel mj_objectWithKeyValues:dic];
            
  
            succedBlock(model,_dataTask,self);
      
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            

            failedBlock(error,_dataTask,self);
            
        }];
        return _dataTask;
    }
    
}


-(NSURLSessionDataTask *)upload:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                   startRequest:(void(^)(void))start
                        success:(void(^)(MMTMainModel * MainModel ))succedBlock
                        failure:(void(^)(NSError * error))failedBlock{
    
    
    if (parameter == nil) {
        parameter = @{};
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString * upstr = [NSString encrypt3DES:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] key:DESAPIKEY];
    NSData * postData = [upstr dataUsingEncoding:NSUTF8StringEncoding];
        //开始请求
        if (start == nil) {
        }else{
            start();
        }
        // 网络指示器开始显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        _dataTask = [self POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFormData:postData name:@"body"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            DLOG(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            MMTMainModel * model = [MMTMainModel mj_objectWithKeyValues:dic];
            succedBlock(model);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failedBlock(error);
        }];
        return _dataTask;
    
    
}
*/
@end
