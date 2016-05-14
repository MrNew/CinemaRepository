//
//  featureTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "featureTableViewCell.h"

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation featureTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    

    self.allfeatureImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.allfeatureImageView];
    
 
    self.allfeatureLabel = [[UITextView alloc] init];
    [self.contentView addSubview:self.allfeatureLabel];
    
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
  
    self.allfeatureImageView.frame = CGRectMake(10, 10, 30, 30);
 //   self.allfeatureImageView.backgroundColor = [UIColor blueColor];
    
   
    self.allfeatureLabel.frame = CGRectMake(self.allfeatureImageView.frame.origin.x+self.allfeatureImageView.frame.size.width+10, 10, ScreenWidth-self.allfeatureImageView.frame.size.width-10, 80);
    self.allfeatureLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.allfeatureLabel setEditable:NO];
    [self.allfeatureLabel setUserInteractionEnabled:NO];
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
