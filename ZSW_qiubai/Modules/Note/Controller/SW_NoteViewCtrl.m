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
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    [view1 setBounds:CGRectMake(-20, -20, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];//添加到self.view
    NSLog(@"view1 frame:%@========view1 bounds:%@",NSStringFromCGRect(view1.frame),NSStringFromCGRect(view1.bounds));
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    [view1 addSubview:view2];//添加到view1上,[此时view1坐标系左上角起点为(-20,-20)]
    
    
    
    NSLog(@"view1 center:%@========view2 center:%@",NSStringFromCGPoint(view1.center),NSStringFromCGPoint(view2.center));
    NSLog(@"view2 frame:%@========view2 bounds:%@",NSStringFromCGRect(view2.frame),NSStringFromCGRect(view2.bounds));
    
    return ;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


@end
