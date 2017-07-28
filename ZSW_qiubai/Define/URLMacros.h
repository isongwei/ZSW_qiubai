
//
//  URLMacros.h
//  ZSW_qiubai
//
//  Created by iSongWei on 2017/7/11.
//  Copyright © 2017年 iSong. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

/*
 主页刷新
 @"https://119.29.47.97/mainpage/list?count=30&type=refresh&page=1&AdID=14998250586097E57B19AA"

 */

#define URL_suggest @"/article/list/suggest?count=30&page=%ld&AdID=14997517628011E57B19AA"

#define URL_text @"/article/list/text?count=30&page=%ld&AdID=14997867133602E57B19AA"

#define URL_video @"/article/list/video?count=30&page=%ld&AdID=14997874696764E57B19AA"

#define URL_baoshe @"/topic/article/list?count=30&page=%ld&AdID=14997873880518E57B19AA"

#define URL_imgrank @"/article/list/imgrank?count=30&page=%ld&AdID=14997878360595E57B19AA"

#define URL_day @"/article/list/day?count=30&page=%ld&AdID=14997872886742E57B19AA"

#define URL_history @"/article/history?count=30&page=%ld&AdID=14997872227184E57B19AA"


//点进去详情

#define URL_detail_coment @"/article/%ld/comment/author?count=30&page=1&AdID=14997930993237E57B19AA"

#define URL_detail_hot @"/article/%ld/hot/comments?count=30&page=1&AdID=14997932179092E57B19AA"

#define URL_detail_latest  @"https://119.29.47.97/article/%ld/latest/comments?article=1&count=50&page=1&AdID=14997930995018E57B19AA"


//video

#define URL_Video_video @"https://119.29.47.97/article/list/video?count=30&page=%ld&AdID=14999955881730E57B19AA"


//live

#define URL_live_all @"https://119.29.47.97/live/all/list?count=30&page=%ld&AdID=1500216920956300000000"

//糗友圈

#define URL_Friend_video  @"https://119.29.47.97/article/video/list?page=1&AdID=1500454892579000000000	200"


#endif /* URLMacros_h */
