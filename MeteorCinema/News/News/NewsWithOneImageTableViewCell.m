//
//  NewsWithOneImageTableViewCell.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsWithOneImageTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation NewsWithOneImageTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ScreenWidth, ScreenHeight / 6);
    
    
    
  
    
    if (self.news) {
        [self setValueForNews:self.news];
    }else{
        [self setValueForSearchNews:self.searchNews];
    }
    
    //
    self.backgroundColor = [UIColor clearColor];
    
}







-(void)setValueForNews:(NewsModel * )news{
    
    NSString * imageURL = self.news.imgSids[0];
    NSURL * url = [NSURL URLWithString:imageURL];
    
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    self.titleLable.text = self.news.title;
    
    self.sourcelabel.text = self.news.site;
    
    self.timeLabel.text = self.news.time;
}

-(void)setValueForSearchNews:(SearchNews *)searchNews{
    
    NSDictionary * dic = self.searchNews.imageurls[0];
    
    NSString * imageURL = [dic objectForKey:@"url"];
    
    NSURL * url = [NSURL URLWithString:imageURL];
    
    [self.iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    self.titleLable.text = self.searchNews.title;
    
    self.sourcelabel.text = self.searchNews.source;
    
    self.timeLabel.text = self.searchNews.pubDate;
}











@end
