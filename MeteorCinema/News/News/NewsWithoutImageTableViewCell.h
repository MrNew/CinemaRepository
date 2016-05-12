//
//  NewsWithoutImageTableViewCell.h
//  News
//
//  Created by lanou on 16/4/13.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsWithoutImageTableViewCell : NewsTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@end
