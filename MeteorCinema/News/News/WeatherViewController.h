//
//  WeatherViewController.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseViewController.h"

@interface WeatherViewController : BaseViewController


@property (nonatomic, strong) NSString * addressString;

// 城市基本信息
@property (nonatomic, strong) NSDictionary * aqiDic;
// 城市空气质量
@property (nonatomic, strong) NSDictionary * basicDic;
//
@property (nonatomic, strong) NSArray * daily_forecastArray;
//
@property (nonatomic, strong) NSArray * hourly_forecastArray;
//
@property (nonatomic, strong) NSDictionary * nowDic;
//
@property (nonatomic, strong) NSDictionary * suggestion;



@end
