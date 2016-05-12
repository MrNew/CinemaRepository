//
//  NewsWithThreeMoreImageTableViewCell.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsWithThreeMoreImageTableViewCell : NewsTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *sourceImageView;

@property (strong, nonatomic) IBOutlet UIImageView *firstIamgeView;

@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;

@property (strong, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;



@end
