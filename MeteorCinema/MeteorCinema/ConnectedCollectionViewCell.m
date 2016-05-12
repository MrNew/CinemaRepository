//
//  ConnectedCollectionViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "ConnectedCollectionViewCell.h"

#import "UIImageView+WebCache.h"

@implementation ConnectedCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.fontImageView = [[UIImageView alloc] init];
        [self.iconImageView addSubview:self.fontImageView];
        
        
        self.titleLabel = [[MarqueeLabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.iconImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height / 7 * 6);
//    self.iconImageView.backgroundColor = [UIColor orangeColor];
    self.titleLabel.frame = CGRectMake(0, self.contentView.bounds.size.height / 7 * 6, self.contentView.bounds.size.width, self.contentView.bounds.size.height / 7);
 
    self.titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.titleLabel.marqueeType = MLLeftRight;
    
    if (self.hasVedio) {
        [self fineFontImageView];
    }

    
}


-(void)fineFontImageView{
    
    self.fontImageView.frame = CGRectMake(0, 0, 32, 32);
    self.fontImageView.center = self.iconImageView.center;
    self.fontImageView.image = [UIImage imageNamed:@"play1"];
  
    
    
}




@end
