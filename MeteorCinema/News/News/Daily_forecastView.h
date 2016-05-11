//
//  Daily_forecastView.h
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DayforecastView.h"

@interface Daily_forecastView : UIView

@property (nonatomic, strong) NSMutableArray * forecastViewArray;



-(void)setWeatherValueWith:(NSArray *)array;

@end
