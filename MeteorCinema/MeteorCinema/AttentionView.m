//
//  AttentionView.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "AttentionView.h"

#import "UIImageView+WebCache.h"

#define Width self.bounds.size.width

#define Height self.bounds.size.height

@interface AttentionView ()

@property (nonatomic, strong) FutureMovieModel * future;

@end

@implementation AttentionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:self.timeLabel];
        
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        self.imageView.userInteractionEnabled = YES;
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        
        self.wantedSee = [[UILabel alloc] init];
        [self addSubview:self.wantedSee];
        
        self.directorLabel = [[UILabel alloc] init];
        [self addSubview:self.directorLabel];
        
        self.actorLabel = [[UILabel alloc] init];
        [self addSubview:self.actorLabel];
        
        
        self.forcastButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:self.forcastButton];
        [self.imageView addSubview:self.forcastButton];
        
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.timeLabel.frame = CGRectMake(Width / 60, 0, Width / 4, Height / 8);
//    self.timeLabel.backgroundColor = [UIColor yellowColor];
    self.timeLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    
//    self.lineView.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width, Height / 8 / 2, Width - self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width, 1);
    self.lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    self.imageView.frame = CGRectMake(Width / 60, Height / 8, Width / 4, Height - Height / 8 - Height / 10);
//    self.imageView.backgroundColor = [UIColor cyanColor];
    
    self.titleLabel.frame = CGRectMake(Width / 60 * 2 + Width / 4, Height / 8, Width - Width / 60 * 3 - Width / 3, Height / 6);
//    self.titleLabel.backgroundColor = [UIColor orangeColor];
    
    self.wantedSee.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y, Width - Width / 60 * 3 - Width / 3, Height / 6);
//    self.wantedSee.backgroundColor = [UIColor grayColor];
    self.wantedSee.textColor = [UIColor colorWithRed:251/255.0 green:158/255.0 blue:16/255.0 alpha:1];
    self.wantedSee.font = [UIFont systemFontOfSize:12];
    
    self.directorLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.wantedSee.frame.size.height + self.wantedSee.frame.origin.y, Width - Width / 60 * 3 - Width / 3, Height / 6);
//    self.directorLabel.backgroundColor = [UIColor redColor];
    self.directorLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.directorLabel.font = [UIFont systemFontOfSize:12];
    
    self.actorLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.directorLabel.frame.origin.y + self.directorLabel.frame.size.height, Width - Width / 60 * 3 - Width / 3, Height / 6);
//    self.actorLabel.backgroundColor = [UIColor orangeColor];
    self.actorLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.actorLabel.font = [UIFont systemFontOfSize:12];
    
    self.forcastButton.frame = CGRectMake(self.actorLabel.frame.origin.x + Width / 40, self.actorLabel.frame.origin.y + self.actorLabel.frame.size.height, self.imageView.bounds.size.width / 3, self.imageView.bounds.size.width / 3);
//    [self.forcastButton setTitle:@"  预告片  " forState:UIControlStateNormal];
//    self.forcastButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.forcastButton sizeToFit];
//    [self.forcastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.forcastButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//    self.forcastButton.layer.cornerRadius = self.forcastButton.frame.size.height / 2;
//    self.forcastButton.layer.masksToBounds = YES;
//    self.forcastButton.layer.borderWidth = 2;
    self.forcastButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.forcastButton.center = CGPointMake(self.imageView.bounds.size.width / 2, self.imageView.bounds.size.height / 2);
    
    
    
    
  
}

-(void)setValueWithFutureMoviewModel:(FutureMovieModel *)future{
    
    self.timeLabel.text = future.releaseDate;
    [self.timeLabel sizeToFit];
    
    
    self.lineView.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + 3, Height / 8 / 2 , Width - self.timeLabel.frame.origin.x - self.timeLabel.frame.size.width, 1);
//    self.lineView.backgroundColor = [UIColor grayColor];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:future.image]];
    
    self.titleLabel.text = future.title;
    
    self.wantedSee.text = future.wantedSee;
    
    self.directorLabel.text = future.director;
    
    self.actorLabel.text = future.actor;
    
    
    // 实行存储存过来的 future 方便发送出去
    self.future = future;
    
    [self.forcastButton addTarget:self action:@selector(passMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}



-(void)passMessage:(UIButton *)button{
    
    
    // 发通知,知道是跳转到 预告片的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationForcast" object:nil userInfo:@{@"vedio":self.future.videoArray}];
    
    
    
}
















@end
