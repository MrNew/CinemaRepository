//
//  FutureTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FutureTableViewCell : UITableViewCell

// 月
@property (nonatomic, strong) UILabel * monthLabel;
// 日
@property (nonatomic, strong) UILabel * dayLabel;

// 图片
@property (nonatomic, strong)  UIImageView * iconImageView;
// 标题
@property (nonatomic, strong) UILabel * titleLabel;
// 想看人数
@property (nonatomic, strong) UILabel * wantedSee;
//
@property (nonatomic, strong) UILabel * directorLabel;

@property (nonatomic, strong) UIButton * forcastButton;


@end
