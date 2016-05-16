//
//  DataBaseUtil.m
//  CityIdSave
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "DataBaseUtil.h"

#import "FMDatabase.h"



@interface DataBaseUtil ()

@property (nonatomic, strong) FMDatabase * db;


// 用于装临时判断数组的
@property (nonatomic, strong) NSMutableArray * nameArray;


@end

@implementation DataBaseUtil


-(NSMutableArray *)nameArray{
    if (!_nameArray) {
        self.nameArray = [NSMutableArray array];
    }
    return _nameArray;
}



+(DataBaseUtil *)share{
    static DataBaseUtil * dataBase = nil;
    if (dataBase == nil) {
        dataBase = [[DataBaseUtil alloc] init];
    }
    return dataBase;
}


//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        
//        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        // 健数据库
//        path = [path stringByAppendingPathComponent:@"CityList.sqlite"];
//        // 链接数据库
//        self.db = [FMDatabase databaseWithPath:path];
//        
//        
//    }
//    return self;
//}


// 重设路径
-(instancetype)init{
    self = [super init];
    if (self) {
//        NSString * string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString * string = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"sqlite"];
        
        self.db = [FMDatabase databaseWithPath:string];
        
        
    }
    return self;
}



-(BOOL)creatTable{
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"create table if not exists cityList (id integer primary key autoincrement,identifier integer,name text,count integer,pinyinShort text,pinyinFull text,initialLetter text)"];
        if ([self.db executeUpdate:sql]) {
            
            [self.db close];
            
            return YES;
            
        }
    }
    return NO;
}


-(BOOL)insertTableWithCityMessage:(CityMessage *)city{
    
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"insert into cityList (identifier,name,count,pinyinShort,pinyinFull,initialLetter) values('%ld','%@','%ld','%@','%@','%@')",(long)city.identifier,city.name,(long)city.count,city.pinyinShort,city.pinyinFull,city.initialLetter];
        if ([self.db executeUpdate:sql]) {
            [self.db close];
            return YES;
        }
        
    }
    return NO;
}






-(NSArray *)selectTable{
    [self.nameArray removeAllObjects];
    
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from cityList"];
        
        FMResultSet * set = [self.db executeQuery:sql];
        
        while ([set next]) {
            CityMessage * city = [[CityMessage alloc] init];
            city.identifier = [[set objectForColumnName:@"identifier"] integerValue];
            city.name = [set objectForColumnName:@"name"];
            city.count = [[set objectForColumnName:@"count"] integerValue];
            city.pinyinShort = [set objectForColumnName:@"pinyinShort"];
            city.pinyinFull = [set objectForColumnName:@"pinyinFull"];
            city.initialLetter = [set objectForColumnName:@"initialLetter"];
            
            [array addObject:city];
            
            [self.nameArray addObject:[set objectForColumnName:@"name"]];
            
        }
        
    }
    [self.db close];
    return array;
}


-(BOOL)isExist:(CityMessage *)city{
    
    [self selectTable];
    
    if ([self.nameArray containsObject:city.name]) {
        
        
        return YES;
        
    }
    
    return NO;
    
}


-(NSArray *)vagueSelectTableWith:(NSString *)cityName{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from cityList where name like \"%%%@%%\" ",cityName];
        FMResultSet * set = [self.db executeQuery:sql];
        while ([set next]) {
            CityMessage * city = [[CityMessage alloc] init];
            city.identifier = [[set objectForColumnName:@"identifier"] integerValue];
            city.name = [set objectForColumnName:@"name"];
            city.count = [[set objectForColumnName:@"count"] integerValue];
            city.pinyinShort = [set objectForColumnName:@"pinyinShort"];
            city.pinyinFull = [set objectForColumnName:@"pinyinFull"];
            city.initialLetter = [set objectForColumnName:@"initialLetter"];
            
            [array addObject:city];
        }
    }
    [self.db close];
//    NSLog(@"%@",array);
    return array;
}































@end
