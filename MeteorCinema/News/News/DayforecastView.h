//
//  DayforecastView.h
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayforecastView : UIView

@property (nonatomic, strong) UILabel * dateLabel;

@property (nonatomic, strong) UILabel * dayStateLabel;

@property (nonatomic, strong) UIImageView * dayImageView;




@property (nonatomic, strong) NSString * maxTmpStr;

@property (nonatomic, strong) NSString * minTmpStr;





@property (nonatomic, strong) UIImageView * nightImageView;

@property (nonatomic, strong) UILabel * nightStateLabel;
// 下雨改概率
@property (nonatomic, strong) UILabel * popLabel;

@property (nonatomic, strong) UILabel * windSCLabel;

@property (nonatomic, strong) UILabel * windSPDLabel;

@end
