//
//  NewsDetailViewController.h
//  News
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseViewController.h"

#import "NewsModel.h"

#import "SearchNews.h"

@interface NewsDetailViewController : BaseViewController

@property (nonatomic, strong) NewsModel * news;


@property (nonatomic, strong) SearchNews * searchNews;


@end
