//
//  NewsTableViewCell.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseTableViewCell.h"

#import "NewsModel.h"

#import "SearchNews.h"

@interface NewsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) NewsModel * news;

@property (nonatomic, strong) SearchNews * searchNews;


@end
