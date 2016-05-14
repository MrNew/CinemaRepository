//
//  NewsCommentModel.h
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCommentModel : NSObject
/*
 "nickname":"最后生还者",
 "userImage":"http://img32.mtime.cn/up/2016/01/09/182229.83828138_o.jpg",
 "date":"2016-5-13 11:29:10",
 "timestamp":1463138951,
 "content":"装神弄鬼",
 "mVPType":0,
 "fromApp":"",
 "replyCount":0,
 "totalCount":60
 */
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *userImage;
@property(nonatomic,assign)NSInteger timestamp;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,assign)NSInteger replyCount;
@property(nonatomic,strong)NSMutableArray *replies;
@property(nonatomic,assign)BOOL isCell;
@end
