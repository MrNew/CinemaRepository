//
//  FutureTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "FutureTableViewCell.h"

@implementation FutureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.monthLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.monthLabel];
        
        self.dayLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.dayLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.wantedSee = [[UILabel alloc] init];
        [self.contentView addSubview:self.wantedSee];
        
        self.directorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.directorLabel];
        
        self.forcastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.forcastButton];
        
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    
    
    
    
    
    
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
