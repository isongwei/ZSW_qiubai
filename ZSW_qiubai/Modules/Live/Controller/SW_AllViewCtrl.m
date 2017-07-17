//
//  SW_AllViewCtrl.m
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/16.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_AllViewCtrl.h"
#import "SW_LiveCell.h"

#import "SW_TestViewCtrl.h"

@interface SW_AllViewCtrl ()<SDCycleScrollViewDelegate>
@property (nonatomic,weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger pageNum;

@property (nonatomic,strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic,strong) NSMutableArray * bannerArr;

@end

@implementation SW_AllViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initView];
    
    [self initData];
    
    [_collectionView.mj_header beginRefreshing];
    
    
}
#pragma mark - ===============init===============
-(void)initView{
    
    
    //header
    _cycleScrollView  = [SDCycleScrollView cycleScrollViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenWidth*0.28)) delegate:self placeholderImage:nil];
    
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_LiveCell" bundle:nil] forCellWithReuseIdentifier:@"SW_LiveCell"];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self requestData];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _pageNum ++;
        [self requestData];
    }];
    
}

-(void)initData{
    
    _pageNum = 1;
    _dataArray = @[].mutableCopy;
    _bannerArr = @[].mutableCopy;
    
}

-(void)requestData{
    

    
    [MBManager showLoading];
    [NetClient GET:NSStringFormat(URL_live_all, _pageNum)  parameter:nil success:^(MainModel *dataModel) {
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [MBManager hideAlert];
        if (_pageNum == 1) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary * infoDic in dataModel.lives) {
            [_dataArray addObject:infoDic];
        }
        [_collectionView reloadData];
        
        //轮播图
        [_bannerArr removeAllObjects];
        for (NSDictionary * infoDic in dataModel.banners) {
            [_bannerArr addObject:infoDic[@"url"]];
        }
        _cycleScrollView.imageURLStringsGroup = _bannerArr;
        
        
    } failure:^(NSError *error) {
        
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [MBManager showError:@"网络出错了~~"];
    }];
}

#pragma mark - ===============SDCycleScrollViewDelegate===============

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}


#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    
    SW_LiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_LiveCell" forIndexPath:indexPath];
    if (_dataArray.count) {
        cell.infoDic = _dataArray[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor redColor];
        if (![headView.subviews containsObject:_cycleScrollView]) {
            [headView addSubview:_cycleScrollView];
        }
        return headView;
    }
    
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = _dataArray[indexPath.row];
    
    SW_TestViewCtrl * vc = [[SW_TestViewCtrl alloc]init];
    vc.flv = dic[@"hdl_live_url"];
    [self.navigationController pushViewController:vc animated:YES];
 
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
    
    
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return _cycleScrollView.frame.size;
}




@end
