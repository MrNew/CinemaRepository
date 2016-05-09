//
//  studio.h
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface studio : NSObject

@property(nonatomic,assign)NSInteger startTime;//开始时间
@property(nonatomic,assign)NSInteger endTime;//结束时间
@property(nonatomic,strong)NSString *versionDesc;//2D
@property(nonatomic,strong)NSString *language;//中文
@property(nonatomic,strong)NSString *hall;//几号厅
@property(nonatomic,strong)NSString *price;//价格
@property(nonatomic,strong)NSString *buy;//购票
@end
