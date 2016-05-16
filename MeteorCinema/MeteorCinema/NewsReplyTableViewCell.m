//
//  NewsReplyTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsReplyTableViewCell.h"

@implementation NewsReplyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userImage = [[UIImageView alloc]init];
        self.nickname = [[UILabel alloc]init];
        self.content = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.backView = [[UIView alloc]init];
        self.horizonal = [[UIView alloc]init];
        [self.backView addSubview:self.userImage];
        [self.backView addSubview:self.nickname];
        [self.backView addSubview:self.timeLabel];
        [self.backView addSubview:self.content];
        [self.backView addSubview:self.horizonal];
        [self.contentView addSubview:self.backView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.userImage.frame = CGRectMake(30, 10, 40, 40);
    self.userImage.layer.cornerRadius = 20;
    self.userImage.layer.masksToBounds = YES;
    self.nickname.frame = CGRectMake(77, 10, 200, 18);
    self.nickname.font = [UIFont systemFontOfSize:13];
    self.nickname.textColor = [UIColor darkGrayColor];
    self.timeLabel.frame = CGRectMake(UIScreenWidth - 100, 10, 83, 18);
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor darkGrayColor];
    self.content.font = [UIFont systemFontOfSize:14];
    Tool *tool = [[Tool alloc]init];
    CGFloat height = [tool getSContentLabelHeight:self.content.text font:self.content.font];
    self.content.numberOfLines = 0;
    self.content.frame = CGRectMake(77, 38, UIScreenWidth - 90, height);
    self.backView.frame = CGRectMake(0, 0, UIScreenWidth, height + 48);
    self.backView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    self.horizonal.frame = CGRectMake(50, height + 47.5, UIScreenWidth - 50, 0.5);
    self.horizonal.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
