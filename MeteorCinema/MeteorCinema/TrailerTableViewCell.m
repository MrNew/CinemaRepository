//
//  TrailerTableViewCell.m
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TrailerTableViewCell.h"

@implementation TrailerTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playImage.layer.cornerRadius = 16;
    self.playImage.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
