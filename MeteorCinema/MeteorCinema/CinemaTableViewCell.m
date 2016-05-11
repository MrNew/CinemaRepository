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
    
    self.Label1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.Label1];
    
    self.Label2 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.Label2];
    
    self.Label3 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.Label3];
    
    self.Label4 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.Label4];
    
//*****************************************************************//
    

    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //标题
    self.TitleLabel.frame = CGRectMake(10, 10, 200, 30);
  //  self.TitleLabel.backgroundColor = [UIColor cyanColor];
    
    self.addressLabel.frame = CGRectMake(10, 45, 300, 30);
    //self.addressLabel.backgroundColor = [UIColor purpleColor];
    
    //价钱
    self.minPriceLabel.frame = CGRectMake(280, 10, 120, 30);
    self.minPriceLabel.textAlignment = NSTextAlignmentCenter;//居中
    self.minPriceLabel.font = [UIFont boldSystemFontOfSize:22];
 //   self.minPriceLabel.layer.cornerRadius = 15;
 //   self.minPriceLabel.layer.masksToBounds = YES;
    self.minPriceLabel.textColor = [UIColor orangeColor];
 //   self.minPriceLabel.backgroundColor = [UIColor orangeColor];
    
    
    
    self.Label1.frame = CGRectMake(10,80,20, 20);
    //[self.Label1 sizeToFit];
    self.Label1.layer.borderWidth = 1;
    self.Label1.image = [UIImage imageNamed:@"WIFI (2)"];
   // self.Label1.text = @"3D";
    self.Label1.layer.borderColor = [UIColor greenColor].CGColor;
   // self.Label1.textColor = [UIColor greenColor];
   // self.Label1.backgroundColor = [UIColor greenColor];
    
    self.Label2.frame = CGRectMake(35,80,20, 20);
    self.Label2.layer.borderWidth = 1;
    self.Label2.image = [UIImage imageNamed:@"kafei"];
   // [self.Label2 sizeToFit];
   // self.Label2.textColor = [UIColor greenColor];
    self.Label2.layer.borderColor = [UIColor greenColor].CGColor;
  //  self.Label2.backgroundColor = [UIColor greenColor];
    
    self.Label3.frame = CGRectMake(60,80,20, 20);
    self.Label3.layer.borderWidth = 1;
    self.Label3.image = [UIImage imageNamed:@"canting"];
   // [self.Label3 sizeToFit];
  //  self.Label3.textColor = [UIColor greenColor];
    self.Label3.layer.borderColor = [UIColor greenColor].CGColor;
  //  self.Label3.backgroundColor = [UIColor greenColor];
    
    self.Label4.frame = CGRectMake(85,80,20, 20);
    self.Label4.layer.borderWidth = 1;
    self.Label4.image = [UIImage imageNamed:@"quguan (2)"];
   // [self.Label4 sizeToFit];
  //  self.Label4.textColor = [UIColor greenColor];
    self.Label4.layer.borderColor = [UIColor greenColor].CGColor;
  //  self.Label4.backgroundColor = [UIColor greenColor];
    
    

    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
