//
//  WeatherDataBaseUtil.h
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CityModel.h"

#import "WeatherModel.h"


@interface WeatherDataBaseUtil : NSObject

+(WeatherDataBaseUtil *)share;

// 精确搜索


// 返回数组城市名的数组
-(NSArray *)selectCityStringWith:(NSString *)proName;

// 通过省名搜索
-(NSArray *)selectCityPorvWith:(NSString *)proName;
// 通过 城市名 模糊搜索
-(NSArray *)selectCityNameWith:(NSString *)cityName;


-(NSArray *)selectWeatherNameWith:(NSString *)weatherName;


-(NSArray *)selectColumnWithTableName:(NSString *)name WithElement:(NSString *)element;

@end
