//
//  MovieCollectionDataBaseUtil.m
//  MeteorCinema
//
//  Created by lanou on 16/5/10.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "MovieCollectionDataBaseUtil.h"

#import "FMDatabase.h"

@interface MovieCollectionDataBaseUtil ()

@property (nonatomic, strong) FMDatabase * db;


@end

@implementation MovieCollectionDataBaseUtil

+(MovieCollectionDataBaseUtil *)share{
    static MovieCollectionDataBaseUtil * dataBase = nil;
    if (dataBase == nil) {
        dataBase = [[MovieCollectionDataBaseUtil alloc] init];
    }
    return dataBase;
}

// 在初始化中 完成与实体文件的对接
-(instancetype)init{
    self = [super init];
    if (self) {
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString * dbPath = [path stringByAppendingPathComponent:@"MovieCollectionList.sqlite"];
        self.db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}


// 不能用index 为表头属性 在数据库内建表
-(BOOL)createTableWithName:(NSString *)name{
    // 打开数据库
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,identifier integer,title text,score text,img text,time text,player text,commonSpecial text,sumtime text,typeString text)",name];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}


-(BOOL)insertTableWithName:(NSString *)name withNews:(HotMovieModel *)hot{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (identifier,title,score,img,time,player,commonSpecial,sumtime,typeString) values ('%ld','%@','%@','%@','%@','%@','%@','%@','%@')",name,(long)hot.identifier,hot.title,hot.score,hot.img,hot.time,hot.player,hot.commonSpecial,hot.sumtime,hot.typeString];
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


-(BOOL)deleteTableWithName:(NSString *)name WithIdentifier:(NSInteger)identifier{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where identifier = '%ld'",name,(long)identifier];
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            [self.db close];
            return YES;
        }
    }
    [self.db close];
    return NO;
}

// 查看 是所有资料 (表 题)
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



-(NSArray *)selectTableWithName:(NSString *)name{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@",name];
        FMResultSet * set = [self.db executeQuery:sql];
        while([set next]) {
//            NewsModel * news = [[NewsModel alloc] init];
//            
//            news.title = [set stringForColumn:@"title"];
//            news.identifier = [set stringForColumn:@"identifier"];
//            news.index = [set stringForColumn:@"indes"];
//            news.link = [set stringForColumn:@"link"];
            
//            [array addObject:news];
            
            
            HotMovieModel * hot = [[HotMovieModel alloc] init];
            hot.identifier = [[set stringForColumn:@"identifier"] integerValue];
            hot.title = [set stringForColumn:@"title"];
            hot.score = [set stringForColumn:@"score"];
            hot.img = [set stringForColumn:@"img"];
            hot.time = [set stringForColumn:@"time"];
            hot.player = [set stringForColumn:@"player"];
            hot.commonSpecial = [set stringForColumn:@"commonSpecial"];
            hot.sumtime = [set stringForColumn:@"sumtime"];
            hot.typeString = [set stringForColumn:@"typeString"];
            
            
            [array addObject:hot];
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
