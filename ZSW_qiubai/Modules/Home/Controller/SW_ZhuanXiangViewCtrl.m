//
//  SW_ZhuanXiangViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_ZhuanXiangViewCtrl.h"
#import "SW_ContentCell.h"
#import "SW_DetailViewCtrl.h"//详情

#import "SW_TestViewCtrl.h"//视频

#import "SW_VideoPlayView.h"

#import "SWVideoPlayer.h"//自定义视频


/*
 cell
 
 "format"    word   video  image
 
 */

    /*
     {
     "image" : "GD3A9R53J9KN72QX.mp4",
     "published_at" : 1499933702,
     "image_size" : {...}
     "comments_count" : 0,
     "pic_loc" : "\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX.jpg",
     "low_loc" : "\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX_3g.mp4",
     "tag" : "null",
     "allow_comment" : true,
     "high_loc" : "\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX.mp4",
     "state" : "publish",
     "user" : {...}
     "id" : 119289147,
     "format" : "video",
     "votes" : {
     "up" : 51,
     "down" : -2
     },
     "pic_size" : [...]
     "share_count" : 0,
     "type" : "fresh",
     "loop" : 618,
     "created_at" : 1499931904,
     "pic_url" : "http:\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX.jpg",
     "low_url" : "http:\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX_3g.mp4",
     "high_url" : "http:\/\/qiubai-video.qiushibaike.com\/GD3A9R53J9KN72QX.mp4",
     "content" : "你们老说抓娃娃抓娃娃，看看人家怎么抓的！"
     }
     */

@interface SW_ZhuanXiangViewCtrl ()
@property(nonatomic,retain)SW_ContentCell *currentCell;



@property (nonatomic,weak) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation SW_ZhuanXiangViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initView];
    
    [self initData];
    
    [_tableView.mj_header beginRefreshing];
    
}


#pragma mark - ===============init===============
-(void)initView{
    
    [_tableView registerNib:[UINib nibWithNibName:@"SW_ContentCell" bundle:nil] forCellReuseIdentifier:@"SW_ContentCell"];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self requestData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _pageNum ++;
        [self requestData];
    }];
    
}

-(void)initData{
    
    _pageNum = 1;
    _dataArray = @[].mutableCopy;
    
}

-(void)requestData{
    
    NSDictionary * urlDic = @{
                              @"专享":URL_suggest,
                              @"视频":URL_video,
                              @"爆社":URL_baoshe,
                              @"纯文":URL_text,
                              @"纯图":URL_imgrank,
                              @"精华":URL_day,
                              @"穿越":URL_history,
                              };
    
    [MBManager showLoading];
    [NetClient GET:NSStringFormat(urlDic[self.title], _pageNum) parameter:nil success:^(MainModel *dataModel) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [MBManager hideAlert];
        if (_pageNum == 1) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary * infoDic in dataModel.items) {
            [_dataArray addObject:infoDic];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [MBManager showError:@"网络出错了~~"];
    }];
}



#pragma mark - ===============UITableViewDelegate===============


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_dataArray.count) {
        return nil;
    }
    
    
    static NSString * acell = @"SW_ContentCell";
    SW_ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:acell];
    NSDictionary * dic = _dataArray[indexPath.row];
    cell.infoDic = dic;
    
    return cell;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:KScreenWidth tableView:tableView];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    SWVideoPlayer *vvv= [[SWVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
                         //WithUrl:[NSURL URLWithString:@"http://circle-video.qiushibaike.com/video/l0525352xwb.mp4"]];
    
    vvv.url = [NSURL URLWithString:@"http://qiubai-video.qiushibaike.com/19KXC10AG8QO0CI2.mp4"];
    [self.view addSubview:vvv];
    return;
    
    
    NSDictionary * infoDic = _dataArray[indexPath.row];
    
    
    SW_VideoPlayView * v = [[SW_VideoPlayView alloc]initWithFrame:(CGRectMake(0, 100, 375, 300))];
    [self.view addSubview:v];
    
    return;
    
    
    
    if ([infoDic[@"format"] isEqualToString:@"video"]) {
        NSDictionary * dic = _dataArray[indexPath.row];
        
        SW_TestViewCtrl * vc = [[SW_TestViewCtrl alloc]init];
        vc.flv = dic[@"high_url"];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }

    SW_DetailViewCtrl * VC = [SW_DetailViewCtrl new];
    VC.infoDic = _dataArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
