//
//  HotMovieModel.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotMovieModel : NSObject

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) NSString * title;

// 评分,需转为字符串使用
@property (nonatomic, strong) NSString * score;

@property (nonatomic, strong) NSString * img;

// 需要处理 (上映时间格式:"%@月%@日上映")
@property (nonatomic, strong) NSString * time;
// 需要处理 (格式:"今日 %@ 家 影院上映 %@ 场"
@property (nonatomic, strong) NSString * player;

// 特别评论
@property (nonatomic, strong) NSString * commonSpecial;

@property (nonatomic, strong) NSArray * versions;



// 第二个界面 (需要
@property (nonatomic, strong) NSString * sumtime;

@property (nonatomic, strong) NSString * typeString;

// 重新赋值
-(void)setValueWithDataDic:(NSDictionary *)dic;

@end
