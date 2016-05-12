//
//  DataBaseUtil.h
//  UISenior每日新闻
//
//  Created by lanou on 16/3/16.
//  Copyright © 2016年 马善武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCollectModel.h"
@interface NewsDataBaseUtil : NSObject
+(NewsDataBaseUtil *)shareDataBase;
-(BOOL)creatTable;
-(BOOL)insertTitle:(NSString *)title title2:(NSString *)title2 image:(NSString *)image;
-(BOOL)deleteWithTable:(NSString *)tableName;
-(BOOL)deletewithTitle:(NSString *)title fromTable:(NSString *)tableName;
-(NSMutableArray *)selectFromTable:(NSString *)tableName;
-(NSArray *)selectTitle:(NSString *)title;
@end
