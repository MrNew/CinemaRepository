//
//  NowWeatherView.h
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowWeatherView : UIView

@property (nonatomic, strong) UILabel * nowStateLabel;

@property (nonatomic, strong) UILabel * nowTemLabel;

@property (nonatomic, strong) UILabel * nowWindLabel;

@property (nonatomic, strong) UILabel * nowHumLabel;


-(void)setTitleWithDictionary:(NSDictionary *)dic;

@end

