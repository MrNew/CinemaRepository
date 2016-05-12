//
//  NewsCollectTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsCollectTableViewCell.h"

@implementation NewsCollectTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageV = [[UIImageView alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.detailLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10, 10, 100, 100);
    self.titleLabel.frame = CGRectMake(120, 10, UIScreenWidth - 140, 30);
    self.detailLabel.frame = CGRectMake(120, 40, UIScreenWidth - 140, 40);
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.textColor = [UIColor darkGrayColor];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
