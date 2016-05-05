//
//  HotMovieTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "HotMovieTableViewCell.h"

#import "UIImageView+WebCache.h"


#define HotWidth self.contentView.bounds.size.width

#define HotHeight self.contentView.bounds.size.height

@implementation HotMovieTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.scroeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.scroeLabel];
        
        self.commonLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.commonLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.playLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.playLabel];
        
//        self.bottomView = [[TagView alloc] init];
//        [self.contentView addSubview:self.bottomView];
        self.tagLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel];
        
        
        self.detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailLabel];
    }

    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
//    CGFloat HotHeight = self.contentView.bounds.size.height;
    
//    NSLog(@"%@",self.hot);
    
    self.iconImageView.frame = CGRectMake(HotWidth / 60, HotHeight / 15, HotWidth / 4, HotHeight - HotHeight / 15 * 2);
//    self.iconImageView.backgroundColor = [UIColor redColor];
    NSURL * url = [NSURL URLWithString:self.hot.img];
    [self.iconImageView sd_setImageWithURL:url];
    
    self.titleLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15, HotWidth / 4, HotHeight / 6);
    self.titleLabel.text = self.hot.title;
    [self.titleLabel sizeToFit];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    
    
    self.scroeLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 5, HotHeight / 15, HotHeight / 6 * 1.5, HotHeight / 6 );
    self.scroeLabel.textAlignment = NSTextAlignmentCenter;
//    self.scroeLabel.backgroundColor = [UIColor purpleColor];
    self.scroeLabel.text = self.hot.score;
    self.scroeLabel.textColor = [UIColor colorWithRed:64/255.0 green:176/255.0 blue:57/255.0 alpha:1];
    [self.scroeLabel sizeToFit];
    
    self.commonLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6, HotWidth / 4 * 2, HotHeight / 6);
//    self.commonLabel.backgroundColor = [UIColor greenColor];
    self.commonLabel.text = self.hot.commonSpecial;
    self.commonLabel.textColor = [UIColor colorWithRed:251/255.0 green:158/255.0 blue:16/255.0 alpha:1];
    [self.commonLabel sizeToFit];
    
    self.timeLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 2 , HotWidth / 4 * 2, HotHeight / 6);
//    self.timeLabel.backgroundColor = [UIColor orangeColor];
    self.timeLabel.text = self.hot.time;
    self.timeLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
    self.playLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 3, HotWidth / 4 * 2, HotHeight / 6);
//    self.playLabel.backgroundColor = [UIColor cyanColor];
    self.playLabel.text = self.hot.player;
    self.playLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
//    self.bottomView.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 4, HotWidth / 4 * 2, HotHeight / 6);
//    self.bottomView.backgroundColor = [UIColor orangeColor];
//    if (self.hot.versions.count > 0) {
//        [self.bottomView insertTagArray:self.hot.versions];
//    }
    if (self.hot.versions.count > 0) {
        NSString * string = @"";
        for (NSDictionary * dic in self.hot.versions) {
            string = [NSString stringWithFormat:@"%@  %@",string,[dic objectForKey:@"version"]];
            
        }
        string = [string substringFromIndex:2];
        string = [NSString stringWithFormat:@"%@%@",string,@"   "];
        self.tagLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 4, HotWidth / 4 * 2, HotHeight / 6);
        self.tagLabel.text = string;
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [self.tagLabel sizeToFit];
        self.tagLabel.layer.borderColor = [UIColor grayColor].CGColor;
        self.tagLabel.layer.borderWidth = 1;
        self.tagLabel.layer.cornerRadius = 5;
        self.tagLabel.layer.masksToBounds = YES;
    }
    
    
    self.detailLabel.frame = CGRectMake(HotWidth - HotWidth / 6 - HotWidth / 60, HotHeight / 15 + HotHeight / 6 * 3, HotWidth / 6, HotHeight / 5);
    self.detailLabel.backgroundColor = [UIColor orangeColor];
    self.detailLabel.text = @"详情";
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.layer.cornerRadius = HotHeight / 5 / 2;
    self.detailLabel.layer.masksToBounds = YES;
    
    
    
}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
