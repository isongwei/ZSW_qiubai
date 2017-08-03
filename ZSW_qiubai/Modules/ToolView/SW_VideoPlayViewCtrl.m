//
//  SW_VideoPlayViewCtrl.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/13.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_VideoPlayViewCtrl.h"
#import "SW_VideoPlayCell.h"
#import "SWVideoPlayer.h"


#import "SW_DetailViewCtrl.h"//详情

@interface SW_VideoPlayViewCtrl ()<UIScrollViewDelegate>

{
    SW_VideoPlayCell *currentCell;
    NSIndexPath * currentIndexPath;
}



@property (nonatomic,strong) SWVideoPlayer * player;

@property (nonatomic,weak) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation SW_VideoPlayViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.SW_fullScreenPopGestureEnabled = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    
    [self initView];
    
    [self initData];
    
    [_tableView.mj_header beginRefreshing];
    

}



- (IBAction)backVC:(UIButton *)sender {
    [self releaseSWPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ===============生命周期===============






#pragma mark - ===============init===============
-(void)initView{
    
    [_tableView registerNib:[UINib nibWithNibName:@"SW_VideoPlayCell" bundle:nil] forCellReuseIdentifier:@"SW_VideoPlayCell"];
    
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

    [MBManager showLoading];
    
    [NetClient GET:NSStringFormat(URL_Video_video, _pageNum) parameter:nil success:^(MainModel *dataModel) {
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
    
    static NSString * acell = @"SW_VideoPlayCell";
    SW_VideoPlayCell * cell = [tableView dequeueReusableCellWithIdentifier:acell];
    NSDictionary * dic = _dataArray[indexPath.row];
    cell.infoDic = dic;
    
    
    WS(weakSelf)
    cell.playClicked = ^(UIButton *btn) {
        btn.tag = 1000+indexPath.row;
        [weakSelf startPlayVideo:btn];
    };
    
    
    if (_player && _player.superview) {
        
        NSArray * indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]) {
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_player]) {
                _player.hidden = NO;
                
            }else{
                _player.hidden = YES;
            }
        }else{
            if ([cell.imageV.subviews containsObject:_player]) {
                [cell.imageV addSubview:_player];
                
                [_player play];
                _player.hidden = NO;
                
            }
            
        }
        
    }
    
    
    return cell;
    
    
}

-(void)startPlayVideo:(UIButton *)sender{
    
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag-1000 inSection:0];
    
    currentCell = (SW_VideoPlayCell * )[self.tableView cellForRowAtIndexPath:currentIndexPath];
    
    NSDictionary * dic = _dataArray[sender.tag-1000];
    
    if (_player) {
        
        [self releaseSWPlayer];
        _player = [[SWVideoPlayer alloc]initWithFrame:sender.bounds];
        _player.urlString = dic[@"high_url"];
        
    }else{
        _player = [[SWVideoPlayer alloc]initWithFrame:sender.bounds];
        _player.urlString = dic[@"high_url"];
    }
    
    
    [currentCell.imageV addSubview:_player];
    [currentCell.imageV bringSubviewToFront:_player];
    
    [_tableView reloadData];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.tableView) {
        if (_player == nil) {
            return;
        }
        if (_player.superview) {
            
            CGRect rectInTableView = [_tableView rectForRowAtIndexPath:currentIndexPath];
            
            CGRect rectInSuperView = [_tableView convertRect:rectInTableView toView:self.tableView.superview];
            
            
            if (rectInSuperView.origin.y < -currentCell.imageV.frame.size.height || rectInSuperView.origin.y > [[UIScreen mainScreen]bounds].size.height) {
                [self releaseSWPlayer];
                
                
            }
        }
    }
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
    return KScreenWidth+84+30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self releaseSWPlayer];
    
    SW_DetailViewCtrl * VC = [SW_DetailViewCtrl new];
    VC.infoDic = _dataArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
 
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


#pragma mark =============releaseSWPlayer=============


-(void)releaseSWPlayer{
    
    [_player stop];
    [_player removeFromSuperview];
    
    
}



//@"http://qiubai-video.qiushibaike.com/U0EW5NYK6KDTS419_3g.mp4"

/*
 "low_url" : "http:\/\/qiubai-video.qiushibaike.com\/OLKUAEOF0MMWVW8Q_3g.mp4",
 "high_url" : "http:\/\/qiubai-video.qiushibaike.com\/OLKUAEOF0MMWVW8Q.mp4",
 */




@end
