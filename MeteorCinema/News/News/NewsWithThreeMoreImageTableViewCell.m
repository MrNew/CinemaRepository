//
//  NewsWithThreeMoreImageTableViewCell.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsWithThreeMoreImageTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation NewsWithThreeMoreImageTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ScreenWidth, ScreenHeight / 4);
    
    self.titleLabel.text = self.news.title;
    
    self.sourceLabel.text = self.news.site;
    
    self.timeLabel.text = self.news.time;
    
    
    
    NSString * imageURL3 = self.news.imgSids[2];
    NSURL * url3 = [NSURL URLWithString:imageURL3];
        
    [self.firstIamgeView sd_setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    
    NSString * imageURL2 = self.news.imgSids[1];
    NSURL * url2 = [NSURL URLWithString:imageURL2];
    
    [self.secondImageView sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    NSString * imageURL1 = self.news.imgSids[0];
    NSURL * url1 = [NSURL URLWithString:imageURL1];
    
    [self.thirdImageView sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    //
    self.backgroundColor = [UIColor clearColor];
    
    
}




@end
