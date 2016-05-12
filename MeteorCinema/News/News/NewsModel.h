//
//  NewsModel.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (nonatomic, strong) NSString * identifier;

@property (nonatomic, strong) NSString * index;

@property (nonatomic, strong) NSString * time;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * haveImg;

@property (nonatomic, strong) NSString * site;

@property (nonatomic, strong) NSArray * imgSids;

@property (nonatomic, strong) NSString * link;

-(void)setValuesWithDic:(NSDictionary *)dic;

@end
