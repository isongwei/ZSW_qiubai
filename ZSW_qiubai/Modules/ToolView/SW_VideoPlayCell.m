//
//  SW_VideoPlayCell.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_VideoPlayCell.h"

@interface SW_VideoPlayCell ()
@property (nonatomic,weak) IBOutlet UIImageView * imageV;
@property (nonatomic,weak) IBOutlet UILabel * titleL;


@end

@implementation SW_VideoPlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageV.userInteractionEnabled = YES;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    _titleL.text = infoDic[@"content" ];
    [self.imageV sd_setImageWithURL:infoDic[@"pic_url"] ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
