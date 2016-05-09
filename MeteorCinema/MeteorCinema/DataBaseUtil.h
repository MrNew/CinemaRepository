//
//  DataBaseUtil.h
//  CityIdSave
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CityMessage.h"

@interface DataBaseUtil : NSObject

+(DataBaseUtil *)share;

-(BOOL)creatTable;


-(BOOL)insertTableWithCityMessage:(CityMessage *)city;

-(NSArray *)selectTable;

// 判断是否已添加
-(BOOL)isExist:(CityMessage *)city;

// 模糊搜索里面的内容
-(NSArray *)vagueSelectTableWith:(NSString *)cityName;

@end
