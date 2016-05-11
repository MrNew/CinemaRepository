//
//  NewsWithOneImageTableViewCell.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsWithOneImageTableViewCell : NewsTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

@property (strong, nonatomic) IBOutlet UILabel *titleLable;

@property (strong, nonatomic) IBOutlet UILabel *sourcelabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


@end
