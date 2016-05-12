//
//  DataBaseUtil.m
//  UISenior每日新闻
//
//  Created by lanou on 16/3/16.
//  Copyright © 2016年 马善武. All rights reserved.
//

#import "NewsDataBaseUtil.h"
#import "FMDatabase.h"
static NewsDataBaseUtil *dataBase = nil;
@interface NewsDataBaseUtil ()
@property(nonatomic,strong)FMDatabase *db;
@end
@implementation NewsDataBaseUtil
+(NewsDataBaseUtil *)shareDataBase
{
    if (dataBase == nil) {
        dataBase = [[NewsDataBaseUtil alloc]init];
    }
    return dataBase;
}
-(id)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"newsList.sqlite"];
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}
//
-(BOOL)creatTable
{
    BOOL b;
    if([_db open]){
        NSString *sqlite = [NSString stringWithFormat:@"create table if not exists collects (id integer primary key autoincrement,title text,title2 text,image text)"];
        b = [_db executeUpdate:sqlite];
    }
    [_db close];
    return b;
}
//
-(BOOL)insertTitle:(NSString *)title title2:(NSString *)title2 image:(NSString *)image
{
    BOOL b;
    if ([_db open]) {
        NSString *sqlite = [NSString stringWithFormat:@"insert into collects (title,title2,image) values('%@','%@','%@')",title,title2,image];
        b = [_db executeUpdate:sqlite];
        [_db close];
    }
    return b;
}
//
-(BOOL)deleteWithTable:(NSString *)tableName
{
    BOOL b;
    if ([_db open]) {
        NSString *sqlite = [NSString stringWithFormat:@"delete from %@",tableName];
        b = [_db executeUpdate:sqlite];
    }
    [_db close];
    return b;
}
//
-(BOOL)deletewithTitle:(NSString *)title fromTable:(NSString *)tableName{
    BOOL b;
    if ([_db open]) {
        NSString *sqlite = [NSString stringWithFormat:@"delete from %@ where title = '%@'",tableName,title];
        b = [_db executeUpdate:sqlite];
    }
    [_db close];
    return b;
}
//
-(NSMutableArray *)selectFromTable:(NSString *)tableName
{
    NSMutableArray *arr = [NSMutableArray array];
    if ([_db open]) {
        NSString *sqlite = [NSString stringWithFormat:@"select * from %@",tableName];
        FMResultSet *set = [_db executeQuery:sqlite];
        while ([set next]) {
            NewsCollectModel *model = [[NewsCollectModel alloc]init];
            model.itemTitle = [set stringForColumn:@"title"];
            model.summary = [set stringForColumn:@"title2"];
            model.image = [set stringForColumn:@"image"];
            [arr addObject:model];
        }
    }
    [_db close];
    return arr;
}
//
-(NSArray *)selectTitle:(NSString *)title
{
    NSMutableArray *arr = [NSMutableArray array];
    if ([_db open]) {
        NSString *sqlite = [NSString stringWithFormat:@"select * from collects where title = '%@'",title];
        FMResultSet *set = [_db executeQuery:sqlite];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            [arr addObject:title];
        }
    }
    [_db close];
    return arr;
}
@end
