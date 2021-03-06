//
//  SW_VideoPlayCell.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SW_VideoPlayCell : UITableViewCell
@property (nonatomic,weak,readonly) IBOutlet UIButton * imageV;
@property (nonatomic,strong) NSDictionary * infoDic;

@property (nonatomic,copy) void(^playClicked)(UIButton *);

@end
