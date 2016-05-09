//
//  Comment.h
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property(nonatomic,strong)NSString *topicId;//主题ID
@property(nonatomic,strong)NSString *userImage;//用户头像
@property(nonatomic,strong)NSString *nickname;//用户姓名
@property(nonatomic,strong)NSString *content;//评论内容
@property(nonatomic,strong)NSString *enterTime;//输入时间


@end
