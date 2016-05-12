//
//  SearchNews.h
//  News
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseModel.h"

@interface SearchNews : BaseModel

@property (nonatomic, strong) NSString * channelName;

@property (nonatomic, strong) NSArray * imageurls;

@property (nonatomic, strong) NSString * link;

@property (nonatomic, strong) NSString * pubDate;

@property (nonatomic, strong) NSString * source;

@property (nonatomic, strong) NSString * title;


-(void)setSearchNewsWithDic:(NSDictionary *)dic;

@end
