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
   // self.priceLabel.textAlignment = NSTextAlignmentCenter;//居中
    self.priceLabel.textColor = [UIColor orangeColor];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:22];
    [self.priceLabel sizeToFit];
    [self.contentView addSubview:self.priceLabel];
    
    //购票
    self.buyLabel = [[UILabel alloc] init];
    self.buyLabel.textAlignment = NSTextAlignmentCenter;//居中
    self.buyLabel.text = @"购买";
    self.buyLabel.textColor = [UIColor whiteColor];
    self.buyLabel.layer.cornerRadius = 10;
    self.buyLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.buyLabel];
    
    
    self.Label1 = [[UILabel alloc] init];
    self.Label1.text = @"/";
    self.Label1.textAlignment = NSTextAlignmentCenter;//居中
    [self.contentView addSubview:self.Label1];
    
    
    
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //开始时间
    self.startTimeLabel.frame = CGRectMake(10, 10, 100, 30);
  //  self.startTimeLabel.backgroundColor = [UIColor redColor];
    
    //结束时间
    self.endTimeLabel.frame = CGRectMake(10, 45, 100, 30);
  //  self.endTimeLabel.backgroundColor = [UIColor cyanColor];
    
    //3D
    self.versionDescLabel.frame = CGRectMake(150, 10, 50, 25);
  //  self.versionDescLabel.backgroundColor = [UIColor orangeColor];
    
    //gang /
    self.Label1.frame = CGRectMake(180, 10, 20, 30);
    
    //语言
    self.languageLabel.frame = CGRectMake(185, 10, 50, 25);
  //  self.languageLabel.backgroundColor = [UIColor greenColor];
    
    //几号厅
    self.hallLabel.frame = CGRectMake(160, 40, 80, 25);
  //  self.hallLabel.backgroundColor = [UIColor brownColor];
    
    //价格
    self.priceLabel.frame = CGRectMake(275, 30, 70, 25);
    // self.priceLabel.backgroundColor = [UIColor purpleColor];
    
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
