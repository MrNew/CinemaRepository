//
//  NewsWithoutImageTableViewCell.m
//  News
//
//  Created by lanou on 16/4/13.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsWithoutImageTableViewCell.h"

@implementation NewsWithoutImageTableViewCell


-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ScreenWidth, ScreenHeight / 8);
    
 
    if (self.news) {
        [self setValueForNews:self.news];
    }else{
        [self setValueForSearchNews:self.searchNews];
    }
    
    
    
    self.backgroundColor = [UIColor clearColor];
    

}


-(void)setValueForNews:(NewsModel * )news{
    
    self.titleLabel.text = self.news.title;
    
    self.sourceLabel.text = self.news.site;
    
    self.timeLabel.text = self.news.time;
}

-(void)setValueForSearchNews:(SearchNews *)searchNews{
    
    self.titleLabel.text = self.searchNews.title;
    
    self.sourceLabel.text = self.searchNews.source;
    
    self.timeLabel.text = self.searchNews.pubDate;
}


@end
