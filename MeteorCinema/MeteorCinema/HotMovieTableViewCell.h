//
//  HotMovieTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotMovieModel.h"

//#import "TagView.h"

@interface HotMovieTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconImageView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * scroeLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * commonLabel;

@property (nonatomic, strong) UILabel * playLabel;

//@property (nonatomic, strong) TagView * bottomView;



@property (nonatomic, strong) UILabel * detailLabel;



// 传进来一个数据模型
@property (nonatomic, strong) HotMovieModel * hot;

@end
