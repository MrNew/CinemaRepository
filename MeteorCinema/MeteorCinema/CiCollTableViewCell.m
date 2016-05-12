//
//  CiCollTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CiCollTableViewCell.h"
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
@implementation CiCollTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.TitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.TitleLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressLabel];
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //标题
    self.TitleLabel.frame = CGRectMake(10, 10, ScreenWidth-10, 30);
      //self.TitleLabel.backgroundColor = [UIColor cyanColor];
    
    self.addressLabel.frame = CGRectMake(10, 45, ScreenWidth-10, 30);
  //  self.addressLabel.backgroundColor = [UIColor purpleColor];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
