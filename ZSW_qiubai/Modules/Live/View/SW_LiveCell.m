//
//  SW_LiveCell.m
//  ZSW_qiubai
//
//  Created by 张松伟 on 2017/7/16.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_LiveCell.h"

@interface SW_LiveCell ()

@property (nonatomic,weak) IBOutlet UIImageView * imageV;
@property (nonatomic,weak) IBOutlet UILabel * titleL;
@property (nonatomic,weak) IBOutlet UILabel * amountL;


@end

@implementation SW_LiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:infoDic[@"author"][@"headurl"]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    
//    [_imageV sd_setImageWithURL:[NSURL URLWithString:infoDic[@"author"][@"headurl"]] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//        NSLog(@"%ld-----%ld",(long)receivedSize,(long)expectedSize);
//        
//    } completed:nil];
    _titleL.text = infoDic[@"author"][@"name"];
    _amountL.text =  NSStringFormat(@"%ld",[infoDic[@"accumulated_count"] integerValue]);
    
    
}


@end


@implementation SW_LiveFlowLayout
-(void)prepareLayout{
    
    self.itemSize = CGSizeMake((KScreenWidth-15)/2, (KScreenWidth-15)/2+10+35);
    self.minimumLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
}
@end
