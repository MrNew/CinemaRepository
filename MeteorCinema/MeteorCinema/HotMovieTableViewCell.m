//
//  HotMovieTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "HotMovieTableViewCell.h"

#import "UIImageView+WebCache.h"


#define HotWidth self.contentView.bounds.size.width

#define HotHeight self.contentView.bounds.size.height

@interface HotMovieTableViewCell ()

@property (nonatomic, strong) UILabel * tagLabel1;

@property (nonatomic, strong) UILabel * tagLabel2;

@property (nonatomic, strong) UILabel * tagLabel3;



@end

@implementation HotMovieTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.scroeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.scroeLabel];
        
        self.commonLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.commonLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.playLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.playLabel];
        
//        self.bottomView = [[TagView alloc] init];
//        [self.contentView addSubview:self.bottomView];
        self.tagLabel1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel1];
        
        self.tagLabel2 = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel2];
        
        self.tagLabel3 = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel3];
        
        
        
//        self.detailLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:self.detailLabel];
        
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.collectionButton];
    }

    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
//    CGFloat HotHeight = self.contentView.bounds.size.height;
    
//    NSLog(@"%@",self.hot);
    
    self.iconImageView.frame = CGRectMake(HotWidth / 60, HotHeight / 15, HotWidth / 4, HotHeight - HotHeight / 15 * 2);
//    self.iconImageView.backgroundColor = [UIColor redColor];
    NSURL * url = [NSURL URLWithString:self.hot.img];
    [self.iconImageView sd_setImageWithURL:url];
    
    self.titleLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15, HotWidth / 4, HotHeight / 6);
    self.titleLabel.text = self.hot.title;
    [self.titleLabel sizeToFit];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    
    
    self.scroeLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 5, HotHeight / 15, HotHeight / 6 * 1.5, HotHeight / 6 );
    self.scroeLabel.textAlignment = NSTextAlignmentCenter;
//    self.scroeLabel.backgroundColor = [UIColor purpleColor];
    self.scroeLabel.text = self.hot.score;
    self.scroeLabel.textColor = [UIColor colorWithRed:64/255.0 green:176/255.0 blue:57/255.0 alpha:1];
    [self.scroeLabel sizeToFit];
    
    self.commonLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4 + 5, HotHeight / 15 + HotHeight / 6 + 10, HotWidth / 4 * 2, HotHeight / 6);
//    self.commonLabel.backgroundColor = [UIColor greenColor];
    self.commonLabel.text = self.hot.commonSpecial;
    self.commonLabel.textColor = [UIColor colorWithRed:251/255.0 green:158/255.0 blue:16/255.0 alpha:1];
    self.commonLabel.font = [UIFont systemFontOfSize:15];
    [self.commonLabel sizeToFit];
    
    self.timeLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 2 + 5 , HotWidth / 4 * 2, HotHeight / 6);
//    self.timeLabel.backgroundColor = [UIColor orangeColor];
    self.timeLabel.text = self.hot.time;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
    self.playLabel.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 3, HotWidth / 4 * 2, HotHeight / 6);
//    self.playLabel.backgroundColor = [UIColor cyanColor];
    self.playLabel.text = self.hot.player;
    self.playLabel.font = [UIFont systemFontOfSize:12];
    self.playLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
//    self.bottomView.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 4, HotWidth / 4 * 2, HotHeight / 6);
//    self.bottomView.backgroundColor = [UIColor orangeColor];
//    if (self.hot.versions.count > 0) {
//        [self.bottomView insertTagArray:self.hot.versions];
//    }
    
    
//        string = [string substringFromIndex:2];
//        string = [NSString stringWithFormat:@"%@%@",string,@"   "];
    self.tagLabel1.frame = CGRectMake(HotWidth / 30 + HotWidth / 4, HotHeight / 15 + HotHeight / 6 * 4, 0, 0);

    
    self.tagLabel1.font = [UIFont systemFontOfSize:12];
    self.tagLabel1.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.tagLabel1.layer.borderColor = [UIColor grayColor].CGColor;
    self.tagLabel1.layer.borderWidth = 1;
    self.tagLabel1.layer.cornerRadius = 5;
    self.tagLabel1.layer.masksToBounds = YES;

    
    if (self.hot.versions.count >= 1) {
        NSDictionary * dic = self.hot.versions[0];
//        NSLog(@"%@",dic);
        
        self.tagLabel1.text = [NSString stringWithFormat:@"  %@  ",[dic objectForKey:@"version"]];
//        self.tagLabel1.textAlignment = NSTextAlignmentCenter;
        [self.tagLabel1 sizeToFit];
//        [self.contentView addSubview:self.tagLabel1];
    }
    
    
    
    
    self.tagLabel2.font = [UIFont systemFontOfSize:12];
//    self.tagLabel2.textAlignment = NSTextAlignmentCenter;
    self.tagLabel2.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.tagLabel2.layer.borderColor = [UIColor grayColor].CGColor;
    self.tagLabel2.layer.borderWidth = 1;
    self.tagLabel2.layer.cornerRadius = 5;
    self.tagLabel2.layer.masksToBounds = YES;
    self.tagLabel2.frame = CGRectMake(0,0,0,0);
    if (self.hot.versions.count >= 2) {
        NSDictionary * dic = self.hot.versions[1];
        self.tagLabel2.text = [NSString stringWithFormat:@"  %@  ",[dic objectForKey:@"version"]];
//        [self.contentView addSubview:self.tagLabel2];
        
        self.tagLabel2.frame = CGRectMake(self.tagLabel1.frame.origin.x + self.tagLabel1.frame.size.width + 5, self.tagLabel1.frame.origin.y, HotWidth / 4 * 2, HotHeight / 6);
        [self.tagLabel2 sizeToFit];
    }
//
    
    
    self.tagLabel3.font = [UIFont systemFontOfSize:12];
//    self.tagLabel3.textAlignment = NSTextAlignmentCenter;
    self.tagLabel3.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    self.tagLabel3.layer.borderColor = [UIColor grayColor].CGColor;
    self.tagLabel3.layer.borderWidth = 1;
    self.tagLabel3.layer.cornerRadius = 5;
    self.tagLabel3.layer.masksToBounds = YES;
    self.tagLabel3.frame = CGRectMake(0,0,0,0);
    if (self.hot.versions.count >= 3) {
        NSDictionary * dic = self.hot.versions[2];
        self.tagLabel3.text = [NSString stringWithFormat:@"   %@   ",[dic objectForKey:@"version"]];
        self.tagLabel3.frame = CGRectMake(self.tagLabel2.frame.origin.x + self.tagLabel2.frame.size.width + 5, self.tagLabel1.frame.origin.y , HotWidth / 4 * 2 , HotHeight / 6);
        [self.tagLabel3 sizeToFit];
        
    }
    
    
    
    
    
    
//    self.detailLabel.frame = CGRectMake(HotWidth - HotWidth / 6 - HotWidth / 60, HotHeight / 15 + HotHeight / 6 * 3, HotWidth / 6, HotHeight / 5);
//    self.detailLabel.backgroundColor = [UIColor orangeColor];
//    self.detailLabel.text = @"详情";
//    self.detailLabel.textAlignment = NSTextAlignmentCenter;
//    self.detailLabel.textColor = [UIColor whiteColor];
//    self.detailLabel.layer.cornerRadius = HotHeight / 5 / 2;
//    self.detailLabel.layer.masksToBounds = YES;
    
    self.collectionButton.frame = CGRectMake(HotWidth - HotWidth / 6 - HotWidth / 60, HotHeight / 15 + HotHeight / 6 * 3.5, HotWidth / 6, HotHeight / 5);
//    self.collectionButton.backgroundColor = [UIColor orangeColor];
//    self.collectionButton setTitle:@"" forState:<#(UIControlState)#>
    
    [self.collectionButton setImage:[UIImage imageNamed:@"myShoucang"] forState:UIControlStateNormal];
    
    [self.collectionButton addTarget:self action:@selector(collectionButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)collectionButtonClik:(UIButton *)button{
    
    
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"myshoucang"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"yiShoucang"] forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
    
//    self.hot
    
    
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
