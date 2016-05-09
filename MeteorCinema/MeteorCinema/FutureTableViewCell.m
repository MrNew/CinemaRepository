//
//  FutureTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "FutureTableViewCell.h"

#import "UIImageView+WebCache.h"

#define Width self.contentView.bounds.size.width

#define Height self.contentView.bounds.size.height


@implementation FutureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.monthLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.monthLabel];
        
        self.dayLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.dayLabel];
        
        self.lineView = [[UIView alloc] init];
        [self.contentView addSubview:self.lineView];
        
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
//        [self.iconImageView addSubview:self.forcastButton];
        
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    
    
    self.monthLabel.frame = CGRectMake(Width / 60, Height / 30, 20, 90);
//    self.monthLabel.backgroundColor = [UIColor redColor];
    self.monthLabel.text = self.future.month;
    self.monthLabel.font = [UIFont systemFontOfSize:15];
    self.monthLabel.textColor = [UIColor grayColor];
    [self.monthLabel sizeToFit];
    
    self.dayLabel.frame = CGRectMake(Width / 60, self.monthLabel.frame.origin.y + self.monthLabel.frame.size.height, 20, 30);
//    self.dayLabel.backgroundColor = [UIColor yellowColor];
    self.dayLabel.text = self.future.day;
    self.dayLabel.textColor = [UIColor grayColor];
    self.dayLabel.font = [UIFont systemFontOfSize:15];
    [self.dayLabel sizeToFit];
    
    
    self.iconImageView.frame = CGRectMake(self.monthLabel.frame.origin.x * 2 + self.monthLabel.frame.size.width + 5, self.monthLabel.frame.origin.y, Width / 4.5, Height - self.monthLabel.frame.origin.y * 2);
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.future.image]];
    self.iconImageView.backgroundColor = [UIColor grayColor];
    
    
    self.titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + Width / 60, self.monthLabel.frame.origin.y, Width - self.iconImageView.frame.origin.x - self.iconImageView.frame.size.width - Width / 60 * 2, Height / 6);
//    self.titleLabel.backgroundColor = [UIColor orangeColor];
    self.titleLabel.text = self.future.title;
    
    self.wantedSee.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height * 1.5, self.titleLabel.frame.size.width, Height / 6);
//    self.wantedSee.backgroundColor = [UIColor grayColor];
    self.wantedSee.text = self.future.wantedSee;
    self.wantedSee.textColor = [UIColor orangeColor];
    self.wantedSee.font = [UIFont systemFontOfSize:14];
    
    self.directorLabel.frame = CGRectMake(self.wantedSee.frame.origin.x, self.wantedSee.frame.origin.y + self.wantedSee.frame.size.height, self.wantedSee.frame.size.width, Height / 6);
//    self.directorLabel.backgroundColor = [UIColor orangeColor];
    self.directorLabel.text = self.future.director;
    self.directorLabel.textColor = [UIColor grayColor];
    self.directorLabel.font = [UIFont systemFontOfSize:14];
    
    self.forcastButton.frame = CGRectMake(Width - Width / 4 - Width / 60, Height - Height / 5 - Height / 10, Width / 4, Height / 5);
//    self.forcastButton.center = self.iconImageView.center;
    
    self.forcastButton.layer.cornerRadius = self.forcastButton.frame.size.height / 2;
    self.forcastButton.layer.masksToBounds = YES;
//    self.forcastButton.layer.borderWidth = 2;
//    self.forcastButton.layer.borderColor = [UIColor greenColor].CGColor;
    self.forcastButton.backgroundColor = [UIColor colorWithRed:65/255.0 green:174/255.0 blue:56/255.0 alpha:1];
    [self.forcastButton setTitle:@"  预告片  " forState:UIControlStateNormal];
//    [self.forcastButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.forcastButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.forcastButton sizeToFit];
    
    [self.forcastButton addTarget:self action:@selector(forcastButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}


-(void)forcastButton:(UIButton *)button{
    
    [self.delegate passFuturevedio:self.future.videoArray];
    
    
    
    
    
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
