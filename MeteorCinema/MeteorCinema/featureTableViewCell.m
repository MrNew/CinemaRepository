//
//  featureTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "featureTableViewCell.h"

@implementation featureTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    

    self.allfeatureImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.allfeatureImageView];
    
 
    self.allfeatureLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.allfeatureLabel];
    
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
  
    self.allfeatureImageView.frame = CGRectMake(10, 10, 30, 30);
 //   self.allfeatureImageView.backgroundColor = [UIColor blueColor];
    
   
    self.allfeatureLabel.frame = CGRectMake(80, 10, 300, 30);
   // self.allfeatureLabel.backgroundColor = [UIColor cyanColor];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
