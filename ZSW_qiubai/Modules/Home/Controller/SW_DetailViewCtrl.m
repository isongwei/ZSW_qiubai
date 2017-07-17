//
//  SW_DetailViewCtrl.m
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/12.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_DetailViewCtrl.h"
#import "SW_ContentCell.h"
#import "SW_CommentCell.h"//评论cell
#import "SW_Comment2Cell.h"//评论cell
#import "SW_TestViewCtrl.h"



@interface SW_DetailViewCtrl ()
@property (nonatomic,weak ) IBOutlet UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * commentArray;
@end

@implementation SW_DetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSStringFormat(@"糗事%ld",(long)[_infoDic[@"id"] integerValue]);
    
    [self initView];
    
    [self initData];
    
    [self requestData];
    
}

#pragma mark - ===============init===============

-(void)initData{
    _commentArray = @[].mutableCopy;
//    [_commentArray addObject:_infoDic];
}

-(void)initView{
    
    [_tableView registerNib:[UINib nibWithNibName:@"SW_ContentCell" bundle:nil] forCellReuseIdentifier:@"SW_ContentCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SW_CommentCell" bundle:nil] forCellReuseIdentifier:@"SW_CommentCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SW_Comment2Cell" bundle:nil] forCellReuseIdentifier:@"SW_Comment2Cell"];
    
}

-(void)requestData{
    [MBManager showLoading];
    
    //@"https://119.29.47.97/article/119282969/latest/comments?article=1&count=50&page=1&AdID=14999135358220E57B19AA"
    //NSStringFormat(URL_detail_latest,(long)[_infoDic[@"id"] integerValue])
    [NetClient GET:NSStringFormat(URL_detail_latest,(long)[_infoDic[@"id"] integerValue]) parameter:nil success:^(MainModel *dataModel) {

        [MBManager hideAlert];
        
        for (NSDictionary * dic in dataModel.items) {
            [_commentArray addObject:dic];
        }
 
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBManager showError:@"网络出错了~~"];
        
    }];
    
}


#pragma mark - ===============UITableViewDelegate===============


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0) {
        static NSString * acell = @"SW_ContentCell";
        SW_ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:acell];
        cell.infoDic = _infoDic;
        return cell;
    }else{
        
        Class currentClass = [SW_CommentCell class];
        SW_CommentCell *cell = nil;
        NSDictionary * dic = _commentArray[indexPath.row];
       if ([[dic allKeys] containsObject:@"refer"] ) {
           currentClass = [SW_Comment2Cell class];
       }
        
   
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
//        cell.numID = [_infoDic[@"user"][@"uid"] integerValue];
        
        cell.numID = 1111;
        cell.infoDic = _commentArray[indexPath.row];
        
        UIView *view_bg = [[UIView alloc]initWithFrame:cell.frame];
        view_bg.backgroundColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.84f alpha:1.00f];;
        cell.selectedBackgroundView = view_bg;
        
        return cell;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
        return _commentArray.count;
    }
    

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
    

    
//    SW_TestViewCtrl * vc =  [[SW_TestViewCtrl alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
