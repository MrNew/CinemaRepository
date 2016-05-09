//
//  ChinaBoxTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "Time100TableViewCell.h"

@implementation Time100TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.rank = [[UILabel alloc]init];
        self.poster = [[UIImageView alloc]init];
        self.name = [[UILabel alloc]init];
        self.nameEn = [[UILabel alloc]init];
        self.rating = [[UILabel alloc]init];
        self.director = [[UILabel alloc]init];
        self.actor = [[UILabel alloc]init];
        self.releaseTime = [[UILabel alloc]init];
        self.back = [[UILabel alloc]init];
        [self.contentView addSubview:self.rank];
        [self.contentView addSubview:self.poster];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.nameEn];
        [self.contentView addSubview:self.rating];
        [self.contentView addSubview:self.director];
        [self.contentView addSubview:self.actor];
        [self.contentView addSubview:self.releaseTime];
        [self.contentView addSubview:self.back];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.rank.frame = CGRectMake(5, 15, 20, 20);
    self.rank.layer.cornerRadius = 10;
    self.rank.layer.masksToBounds = YES;
    self.rank.textColor = [UIColor whiteColor];
    self.rank.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    self.rank.textAlignment = NSTextAlignmentCenter;
    self.poster.frame = CGRectMake(30, 15, 80, 105);
    self.name.frame = CGRectMake(125, 15, 200, 20);
    // self.name.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [self.name sizeToFit];
    self.rating.frame = CGRectMake(self.name.frame.origin.x + self.name.frame.size.width, 15, 25, 18);
    self.rating.textColor = [UIColor whiteColor];
    self.rating.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    
    self.rating.textAlignment = NSTextAlignmentCenter;
    self.nameEn.frame = CGRectMake(125, 40, 250, 20);
    self.nameEn.font = [UIFont systemFontOfSize:14];
    self.nameEn.textColor = [UIColor grayColor];
    self.director.frame = CGRectMake(125, 65, 250, 20);
    self.director.font = [UIFont systemFontOfSize:13];
    self.actor.frame = CGRectMake(125, 85, 250, 20);
    self.actor.font = [UIFont systemFontOfSize:13];
    self.releaseTime.frame = CGRectMake(125, 105, 250, 20);
    self.releaseTime.font = [UIFont systemFontOfSize:13];
    self.back.frame = CGRectMake(30, 130, UIScreenWidth - 50, 40);
    self.back.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    self.back.textColor = [UIColor darkGrayColor];
    self.back.numberOfLines = 2;
    self.back.font = [UIFont systemFontOfSize:12];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
