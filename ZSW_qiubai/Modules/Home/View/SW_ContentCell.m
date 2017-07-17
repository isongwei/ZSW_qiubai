//
//  SW_ContentCell.m
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_ContentCell.h"

@interface SW_ContentCell ()

@property (nonatomic,weak) IBOutlet UIImageView * headerImage;
@property (nonatomic,weak) IBOutlet UILabel * nameL;

@property (nonatomic,weak) IBOutlet UILabel * contentL;
@property (nonatomic,weak) IBOutlet UIImageView * imageV;


@property (nonatomic,weak) IBOutlet UILabel * funnyL;
@property (nonatomic,weak) IBOutlet UILabel * commentL;
@property (nonatomic,weak) IBOutlet UILabel * shareL;




@end

@implementation SW_ContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _headerImage.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .widthIs(30)
    .heightEqualToWidth();

    _nameL.sd_layout
    .leftSpaceToView(_headerImage, 10)
    .topEqualToView(_headerImage)
    .heightIs(30)
    .minWidthIs(10);
    
    _nameL.textColor = KTextColor3;
    _contentL.textColor = KTextColor2;
    
    
 
}



-(void)setInfoDic:(NSDictionary *)infoDic{
    
    
    _infoDic = infoDic;
    

    //头像 名称
    NSDictionary * userDic = infoDic[@"user"];
    
    if (![userDic isEqual:[NSNull null]]) {
        _nameL.text = userDic[@"login"];
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:NSStringFormat(@"http:%@",userDic[@"medium"])] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    }else{
        _nameL.text = @"匿名用户";
        _headerImage.image = [UIImage imageNamed:@"user_icon_anonymous"];
        
    }

    //内容
    _contentL.text = infoDic[@"content"];
    
    [_contentL sd_clearAutoLayoutSettings];
    [_contentL lineSpace:5];
    _contentL.isAttributedContent = YES;
    
    //图片default_pic_mask
    _imageV.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"default_pic_mask"]] ;
    [_imageV sd_clearAutoLayoutSettings];
    _imageV.hidden = YES;
 
    if ([infoDic[@"format"] isEqualToString:@"word"]) {
        
        
        //爆社
        if ([[infoDic allKeys] containsObject:@"topic"]) {
            _contentL.text = NSStringFormat(@"%@ %@",infoDic[@"topic"][@"content"],infoDic[@"content"]);
            [_contentL labelTextArray:@[infoDic[@"topic"][@"content"],infoDic[@"content"]] textColorArray:@[KTextColor1,KTextColor2]];
            [_contentL lineSpace:5];
        }
        
        _contentL.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 64)
        .widthIs(KScreenWidth-30)
        .autoHeightRatio(0);
        
        [self setupAutoHeightWithBottomView:_contentL bottomMargin:90];

    }else if ([infoDic[@"format"] isEqualToString:@"image"]) {
        
        //爆社
        if ([[infoDic allKeys] containsObject:@"topic"]) {
            _contentL.text = NSStringFormat(@"%@ %@",infoDic[@"topic"][@"content"],infoDic[@"content"]);
            [_contentL labelTextArray:@[infoDic[@"topic"][@"content"],infoDic[@"content"]] textColorArray:@[KTextColor1,KTextColor2]];
            [_contentL lineSpace:5];
        }
        
        
        _imageV.hidden = NO;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:NSStringFormat(@"http:%@",infoDic[@"high_loc"])] ];
        _contentL.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 64)
        .widthIs(KScreenWidth-30)
        .autoHeightRatio(0);
        
        
        CGFloat l = 1;
        if (![infoDic[@"image_size"] isEqual:[NSNull null]]) {
            CGFloat m = [infoDic[@"image_size"][@"s"][0] floatValue];
            CGFloat n = [infoDic[@"image_size"][@"s"][1] floatValue];
            l =n/m;
        }
     
        _imageV.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(_contentL, 10)
        .widthIs(KScreenWidth-30)
        .autoHeightRatio(l);
        
        [self setupAutoHeightWithBottomView:_imageV bottomMargin:90];
      
    }else if ([infoDic[@"format"] isEqualToString:@"video"]) {
        
        _imageV.hidden = NO;
        [self.imageV sd_setImageWithURL:infoDic[@"pic_url"] ];
        
        _contentL.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 74)
        .widthIs(KScreenWidth-30)
        .autoHeightRatio(0);
        
        
        
        _imageV.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(_contentL, 10)
        .widthIs(KScreenWidth-30)
        .autoHeightRatio(1);

        [self setupAutoHeightWithBottomView:_imageV bottomMargin:90];
    }
    
    
    //下方三个
    _funnyL.text = NSStringFormat(@"好笑: %ld",[infoDic[@"votes"][@"down"] integerValue] + [infoDic[@"votes"][@"up"] integerValue]);
    _commentL.text = NSStringFormat(@"评论: %ld",[infoDic[@"comments_count"] integerValue]);
    
//    _shareL.hidden = ![infoDic[@"share_count"] integerValue];
//    _shareL.text = NSStringFormat(@"分享: %ld",[infoDic[@"share_count"] integerValue]);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
