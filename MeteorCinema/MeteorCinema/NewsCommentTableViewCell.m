//
//  NewsCommentTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "NewsCommentTableViewCell.h"

@implementation NewsCommentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userImage = [[UIImageView alloc]init];
        self.nickname = [[UILabel alloc]init];
        self.content = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tfReply = [[UITextField alloc]init];
        self.triangleView = [[TriangleView alloc]init];
        self.horizonal = [[UIView alloc]init];
        [self.contentView addSubview:self.userImage];
        [self.contentView addSubview:self.nickname];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.replyButton];
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.tfReply];
        [self.contentView addSubview:self.triangleView];
        [self.contentView addSubview:self.horizonal];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.userImage.frame = CGRectMake(10, 10, 40, 40);
    self.userImage.layer.cornerRadius = 20;
    self.userImage.layer.masksToBounds = YES;
    self.nickname.frame = CGRectMake(57, 10, 200, 18);
    self.nickname.font = [UIFont systemFontOfSize:13];
    self.nickname.textColor = [UIColor darkGrayColor];
    self.timeLabel.frame = CGRectMake(UIScreenWidth - 100, 10, 83, 18);
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor darkGrayColor];
    self.content.font = [UIFont systemFontOfSize:14];
    Tool *tool = [[Tool alloc]init];
    CGFloat height = [tool getContentLabelHeight:self.content.text font:self.content.font];
    self.content.numberOfLines = 0;
    self.content.frame = CGRectMake(57, 38, UIScreenWidth - 70, height);
    self.replyButton.frame = CGRectMake(UIScreenWidth - 70, 48 + height, 22, 22);
    [self.replyButton setImage:[UIImage imageNamed:@"Unknown-2"] forState:UIControlStateNormal];
    self.tfReply.frame = CGRectMake(UIScreenWidth - 42, 48+height, 32, 25);
   // self.tfReply.text = @"回复";
    self.tfReply.textColor = [UIColor darkGrayColor];
    self.tfReply.font = [UIFont systemFontOfSize:13];
    self.triangleView.frame = CGRectMake(UIScreenWidth - 55,height + 83 - 10, 20, 10);
    self.horizonal.frame = CGRectMake(20, height + 82.5, UIScreenWidth - 20, 0.5);
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
