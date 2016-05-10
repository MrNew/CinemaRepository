//
//  ReviewTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.title = [[UILabel alloc]init];
        self.summary = [[UILabel alloc]init];
        self.moviename= [[UILabel alloc]init];
        self.username= [[UILabel alloc]init];
        self.userRating= [[UILabel alloc]init];
        self.movieImage = [[UIImageView alloc]init];
        self.userImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.summary];
        [self.contentView addSubview:self.moviename];
        [self.contentView addSubview:self.username];
        [self.contentView addSubview:self.userRating];
        [self.contentView addSubview:self.userImage];
        [self.contentView addSubview:self.movieImage];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.title.frame = CGRectMake(12, 16, 283, 21);
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.summary.frame = CGRectMake(12, 37, 296, 39);
    self.summary.textAlignment = NSTextAlignmentLeft;

    self.summary.textColor = [UIColor darkGrayColor];
    self.summary.font = [UIFont systemFontOfSize:14];
    self.summary.numberOfLines = 2;
    self.userImage.frame = CGRectMake(8, 83, 24, 24);
    self.movieImage.frame = CGRectMake(UIScreenWidth - 60, 37, 50, 74);
    self.username.frame = CGRectMake(38, 88, 117, 24);
    self.username.font = [UIFont fontWithName:@"Helvetica" size:14];
    self.username.textColor = [UIColor darkGrayColor];
    [self.username sizeToFit];
    self.moviename.frame = CGRectMake(self.username.frame.origin.x + self.username.frame.size.width, 88, 88, 24);
    self.moviename.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.moviename sizeToFit];
    self.userRating.frame = CGRectMake(self.moviename.frame.origin.x + self.moviename.frame.size.width, 85, 27, 21);
    self.userRating.textColor = [UIColor whiteColor];
    self.userRating.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.5];
    self.userRating.textAlignment = NSTextAlignmentCenter;
    self.userRating.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
