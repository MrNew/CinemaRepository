//
//  CinemaDataBaseUtil.m
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CinemaDataBaseUtil.h"
#import "FMDatabase.h"

static CinemaDataBaseUtil *database = nil;
@interface CinemaDataBaseUtil ()
@property(nonatomic,strong)FMDatabase *db;

@end


@implementation CinemaDataBaseUtil
+(CinemaDataBaseUtil *)shareDataBase
{
    if (database == nil) {
        database = [[CinemaDataBaseUtil alloc]init];
    }
    return database;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSLog(@"%@",docPath);
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"CinemaLise.sqlite"];
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

//建表
-(BOOL)createTable
{
    if ([_db open]) {
        NSString *sql = @"create table if not exists cinema (id integer primary key autoincrement,cinameName text,address text)";
//        NSString *sql1 = @"create table if not exists histories (id integer primary key autoincrement,cinameName text,address text)";
      //  BOOL result1 = [_db executeUpdate:sql1];
        BOOL result = [_db executeUpdate:sql];
        [_db close];
        return result;
    }
    return NO;
}

//插入
-(BOOL)insertCinameName:(NSString *)cinameName address:(NSString *)address
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into cinema(cinameName,address) values('%@','%@')",cinameName,address];
        BOOL result = [_db executeUpdate:sql];
        [_db close];
        return result;
    }
    return NO;
}


//删除哪个标题的内容
-(BOOL)deleteCarWithTitle:(NSString *)cinameName
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from cinema where cinameName = '%@'",cinameName];
        BOOL result = [_db executeUpdate:sql];
        [_db close];
        return result;
    }
    return NO;
}


//查询数据
-(NSArray *)selectWithCinema
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        
        //模糊查询关键字 like  +  要查找的字段(如果查找的所有字段可以使用通配符*)  form  +  表名  + 关键字 where + 查找条件
        NSString *sql = [NSString stringWithFormat:@"select * from cinema"];
        
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            NSString *cinameName = [set stringForColumn:@"cinameName"];
            NSString *address = [set stringForColumn:@"address"];
    
            
            Cinema *movie = [[Cinema alloc] init];
            movie.cinameName = cinameName;
            movie.address = address;

            
            [array addObject:movie];
        }
        
    }
    [_db close];
    return array;
    
    
    
}
@end
