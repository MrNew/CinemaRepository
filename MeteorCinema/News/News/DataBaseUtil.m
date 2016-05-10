//
//  DataBaseUtil.m
//  News
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "DataBaseUtil.h"

#import "FMDatabase.h"

@interface DataBaseUtil ()

@property (nonatomic, strong) FMDatabase * db;


@end


@implementation DataBaseUtil





+(DataBaseUtil *)share{
    static DataBaseUtil * dataBase = nil;
    if (dataBase == nil) {
        dataBase = [[DataBaseUtil alloc] init];
    }
    return dataBase;
}


// 在初始化中 完成与实体文件的对接
-(instancetype)init{
    self = [super init];
    if (self) {
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString * dbPath = [path stringByAppendingPathComponent:@"ReadList.sqlite"];
        self.db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

// 不能用index 为表头属性
-(BOOL)createTableWithName:(NSString *)name{
    // 打开数据库
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,title text,identifier text,indes text,link text)",name];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(BOOL)insertTableWithName:(NSString *)name withNews:(NewsModel *)news{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (title,identifier,indes) values ('%@','%@','%@')",name,news.title,news.identifier,news.index];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(BOOL)insertTableWithName:(NSString *)name withSearchNews:(SearchNews *)news{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (title,link) values ('%@','%@')",name,news.title,news.link];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(BOOL)deleteTableWithName:(NSString *)name{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",name];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(BOOL)deleteTableWithName:(NSString *)name WithTitle:(NSString *)title{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where title = '%@'",name,title];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(NSArray *)selectTableWithName:(NSString *)name{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@",name];
        FMResultSet * set = [self.db executeQuery:sql];
        while([set next]) {
            NewsModel * news = [[NewsModel alloc] init];
        
            news.title = [set stringForColumn:@"title"];
            news.identifier = [set stringForColumn:@"identifier"];
            news.index = [set stringForColumn:@"indes"];
            news.link = [set stringForColumn:@"link"];
            
            [array addObject:news];
        }
    }
    [self.db close];
    return array;
}


// 查看 是所有资料
-(NSArray *)selectTableTitleWithName:(NSString *)name{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@",name];
        FMResultSet * set = [self.db executeQuery:sql];
        while([set next]) {
            
            NSString * title = [set stringForColumn:@"title"];
            
            [array addObject:title];
        }
    }
    [self.db close];
    return array;
}


-(BOOL)isContentNewsWith:(NSString *)name WithTitle:(NSString *)title{
    
    NSArray * array = [self selectTableTitleWithName:name];
    if ([array containsObject:title]) {
        return YES;
    }else{
        return NO;
    }
}













@end
