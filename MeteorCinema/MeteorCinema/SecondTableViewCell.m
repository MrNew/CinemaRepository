//
//  SecondTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    /*
     @property(nonatomic,strong)UILabel *startTimeLabel;//开始时间
     @property(nonatomic,strong)UILabel *endTimeLabel;//结束时间
     @property(nonatomic,strong)UILabel *versionDescLabel;//2D
     @property(nonatomic,strong)UILabel *languageLabel;//中文
     @property(nonatomic,strong)UILabel *hallLabel;//几号厅
     @property(nonatomic,strong)UILabel *priceLabel;//价格
     @property(nonatomic,strong)UILabel *buyLabel;//购票
     
     */
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //开始时间
    self.startTimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.startTimeLabel];
    
    //结束时间
    self.endTimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.endTimeLabel];
    
    //2D
    self.versionDescLabel = [[UILabel alloc] init];
    self.versionDescLabel.textAlignment = NSTextAlignmentCenter;//居中
    [self.contentView addSubview:self.versionDescLabel];
    
    //中文
    self.languageLabel = [[UILabel alloc] init];
    self.languageLabel.textAlignment = NSTextAlignmentCenter;//居中
    [self.contentView addSubview:self.languageLabel];
    
    //几号厅
    self.hallLabel = [[UILabel alloc] init];
    self.hallLabel.textAlignment = NSTextAlignmentCenter;//居中
    [self.contentView addSubview:self.hallLabel];
    
    //价格
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;//居中
    [self.contentView addSubview:self.priceLabel];
    
    //购票
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.textAlignment = NSTextAlignmentCenter;//居中
    self.buyLabel.text = @"购买";
    [self.contentView addSubview:self.buyLabel];
    
    
    
    return self;
}

-(void)layoutSubviews
{
    
    //开始时间
    self.startTimeLabel.frame = CGRectMake(10, 10, 100, 30);
    self.startTimeLabel.backgroundColor = [UIColor redColor];
    
    //结束时间
    self.endTimeLabel.frame = CGRectMake(10, 45, 100, 30);
    self.endTimeLabel.backgroundColor = [UIColor cyanColor];
    
    //3D
    self.versionDescLabel.frame = CGRectMake(130, 10, 50, 25);
    self.versionDescLabel.backgroundColor = [UIColor orangeColor];
    
    //语言
    self.languageLabel.frame = CGRectMake(190, 10, 50, 25);
    self.languageLabel.backgroundColor = [UIColor greenColor];
    
    //几号厅
    self.hallLabel.frame = CGRectMake(150, 40, 80, 25);
    self.hallLabel.backgroundColor = [UIColor brownColor];
    
    //价格
    self.priceLabel.frame = CGRectMake(275, 30, 50, 25);
    self.priceLabel.backgroundColor = [UIColor purpleColor];
    
    //购买
    self.buyLabel.frame = CGRectMake(350, 30, 50, 25);
    self.buyLabel.backgroundColor = [UIColor orangeColor];
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
