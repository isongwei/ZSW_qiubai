//
//  SW_NoteViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_NoteViewCtrl.h"
#import "AFHTTPSessionManager.h"

@interface SW_NoteViewCtrl ()

@end

@implementation SW_NoteViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    




    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    [mgr setSecurityPolicy:securityPolicy];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",nil];
    
    
    
    [mgr.requestSerializer setValue:@"aeefd84475277965151233575d01d6d03ae31a5b-___ID=33ffab92-b064-4174-9435-afcf6778f3d0&___TS=1500357996462" forHTTPHeaderField:@"PLAY_SESSION"];
    
    
    
    [mgr POST:@"http://172.16.20.114:9001/activity/common/getGift" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络指示器结束显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        
        DLog(@"%@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
