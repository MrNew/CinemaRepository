//
//  CinemaTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.TitleLabel = [[UILabel alloc] init];
    self.TitleLabel.numberOfLines = 4;
    [self.contentView addSubview:self.TitleLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressLabel];
    
    self.minPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.minPriceLabel];
    return self;
}

-(void)layoutSubviews
{
    //标题
    self.TitleLabel.frame = CGRectMake(10, 10, 200, 30);
    self.TitleLabel.backgroundColor = [UIColor cyanColor];
    
    self.addressLabel.frame = CGRectMake(10, 45, 300, 30);
    self.addressLabel.backgroundColor = [UIColor purpleColor];
    
    //价钱
    self.minPriceLabel.frame = CGRectMake(290, 10, 50, 25);
    self.minPriceLabel.backgroundColor = [UIColor orangeColor];
    

    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
