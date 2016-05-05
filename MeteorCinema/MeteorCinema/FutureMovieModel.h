//
//  FutureMovieModel.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FutureMovieModel : NSObject

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * image;

@property (nonatomic, strong) NSString * releaseDate;

@property (nonatomic, strong) NSString * month;

@property (nonatomic, strong) NSString * day;

// 编辑 (格式: %@人想看 - %@)
@property (nonatomic, strong) NSString * wantedSee;

// 格式 : 导演: %@
@property (nonatomic, strong) NSString * director;

// 格式 演员: %@ %@
@property (nonatomic, strong) NSString * actor;

@property (nonatomic, assign) NSInteger videoCount;

@property (nonatomic, strong) NSArray * videoArray;



-(void)setValueWithDataDic:(NSDictionary *)dic;

@end
