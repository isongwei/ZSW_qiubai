//
//  SW_VideoPlayCell.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_VideoPlayCell.h"


@interface SW_VideoPlayCell ()
@property (nonatomic,weak) IBOutlet UIButton * imageV;
@property (nonatomic,weak) IBOutlet UIImageView * headerV;
@property (nonatomic,weak) IBOutlet UILabel * titleL;
@property (nonatomic,weak) IBOutlet UILabel * contentL;


@end

@implementation SW_VideoPlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageV.userInteractionEnabled = YES;
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    _titleL.text = infoDic[@"user"][@"login"];
    _contentL.text = infoDic[@"content"];
    [self.headerV sd_setImageWithURL:[NSURL URLWithString:NSStringFormat(@"http:%@",infoDic[@"user"][@"thumb"])]];
    
    [self.imageV sd_setBackgroundImageWithURL:infoDic[@"pic_url"] forState:(UIControlStateNormal)];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(IBAction)playBtn:(UIButton*)btn{
    
    if (self.playClicked) {
        self.playClicked(btn);
    }
    
}

@end
