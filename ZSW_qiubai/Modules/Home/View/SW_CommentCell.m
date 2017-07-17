//
//  SW_CommentCell.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/12.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_CommentCell.h"

@interface SW_CommentCell ()

@property (nonatomic,weak) IBOutlet UIImageView * headerImage;
@property (nonatomic,weak) IBOutlet UILabel * nameL;
@property (nonatomic,weak) IBOutlet UILabel * contentL;
@property (nonatomic,weak) IBOutlet UILabel * LandlordL;




@property (nonatomic,weak) IBOutlet UILabel * timeL;
@property (nonatomic,weak) IBOutlet UILabel * floorL;

@end

@implementation SW_CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    

    _headerImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .widthIs(40)
    .heightEqualToWidth();
    
    _nameL.sd_layout
    .leftSpaceToView(_headerImage, 10)
    .topEqualToView(_headerImage)
    .heightIs(20);

    [_nameL setSingleLineAutoResizeWithMaxWidth:KScreenWidth-80-10-60];
    
    _LandlordL.sd_layout
    .leftSpaceToView(_nameL, 10)
    .centerYEqualToView(_nameL)
    .heightIs(23)
    .widthIs(44);
    
    
    
    _contentL.sd_layout
    .leftEqualToView(_nameL)
    .topSpaceToView(_nameL, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    
    _timeL.sd_layout
    .leftEqualToView(_contentL)
    .topSpaceToView(_contentL, 10)
    .widthIs(100)
    .heightIs(20);
    
    _floorL.sd_layout
    .leftSpaceToView(_timeL, 30)
    .topEqualToView(_timeL)
    .widthIs(120)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:_timeL bottomMargin:10];
    
    _contentL.textColor = KTextColor2;
    _nameL.textColor = KTextColor3;
}
-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    
    _LandlordL.hidden = !(self.numID == [infoDic[@"user"][@"uid"] integerValue]);
    

    [_headerImage sd_setImageWithURL:[NSURL URLWithString:NSStringFormat(@"http:%@",infoDic[@"user"][@"medium"])] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _nameL.text = infoDic[@"user"][@"login"];
    _contentL.text =  infoDic[@"content"];
    [_contentL lineSpace:5];
    _contentL.isAttributedContent = YES;
    
    _timeL.text = [NSString getTimeIntervalWithconverDate:NSStringFormat(@"%ld",[infoDic[@"created_at"] integerValue])];
    _floorL.text = NSStringFormat(@"%ld楼",[infoDic[@"floor"] integerValue]);
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}



@end
