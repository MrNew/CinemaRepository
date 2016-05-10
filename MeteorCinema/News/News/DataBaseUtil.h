//
//  DataBaseUtil.h
//  News
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewsModel.h"

#import "SearchNews.h"

@interface DataBaseUtil : NSObject

+(DataBaseUtil *)share;

// 建表
-(BOOL)createTableWithName:(NSString *)name;
// 插入
-(BOOL)insertTableWithName:(NSString *)name withNews:(NewsModel *)news;

// 插入类型不同号
-(BOOL)insertTableWithName:(NSString *)name withSearchNews:(SearchNews *)news;


// 清除删除 某个表格
-(BOOL)deleteTableWithName:(NSString *)name;
// 清除 某个记录
-(BOOL)deleteTableWithName:(NSString *)name WithTitle:(NSString *)title;
// 查看 是所有资料
-(NSArray *)selectTableWithName:(NSString *)name;



// 判断是否含有 某个新闻
-(BOOL)isContentNewsWith:(NSString *)name WithTitle:(NSString *)title;


@end
