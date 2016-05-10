//
//  WeatherDataBaseUtil.m
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "WeatherDataBaseUtil.h"

#import "FMDatabase.h"

@interface WeatherDataBaseUtil ()

@property (nonatomic, strong) FMDatabase * db;

@end

@implementation WeatherDataBaseUtil

+(WeatherDataBaseUtil *)share{
    static WeatherDataBaseUtil * dataBase = nil;
    if (dataBase == nil) {
        dataBase = [[WeatherDataBaseUtil alloc] init];
    }
    return dataBase;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"sqlite"];
        
        self.db = [FMDatabase databaseWithPath:path];
        
    }
    return self;
}


-(NSArray *)selectCityPorvWith:(NSString *)proName{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from CityList where prov = '%@'",proName];
        FMResultSet * set = [self.db executeQuery:sql];
        while ([set next]) {
            CityModel * city = [[CityModel alloc] init];
            city.city = [set objectForColumnName:@"city"];
            city.identifier = [set objectForColumnName:@"identifier"];
            city.prov = [set objectForColumnName:@"prov"];
            [array addObject:city];
        }
    }
    
    [self.db close];
    
    return array;
}

-(NSArray *)selectCityStringWith:(NSString *)proName{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from CityList where prov = '%@'",proName];
        FMResultSet * set = [self.db executeQuery:sql];
        while ([set next]) {
            NSString * city = [set objectForColumnName:@"city"];
            if (![array containsObject:city]) {
                
                [array addObject:city];
            }
            
        }
    }
    
    [self.db close];
    
    return array;
}


// 模糊搜索
-(NSArray *)selectCityNameWith:(NSString *)cityName{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from CityList where prov like \"%%%@%%\" ",cityName];
        FMResultSet * set = [self.db executeQuery:sql];
        while ([set next]) {
            CityModel * city = [[CityModel alloc] init];
            city.city = [set objectForColumnName:@"city"];
            city.identifier = [set objectForColumnName:@"dientifier"];
            city.prov = [set objectForColumnName:@"proName"];
            [array addObject:city];
        }
    }
    
    [self.db close];
    
    return array;
}


-(NSArray *)selectWeatherNameWith:(NSString *)weatherName{
    NSMutableArray * array = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from WeatherList where name = '%@'",weatherName];
        FMResultSet * set = [self.db executeQuery:sql];
        while ([set next]) {
            WeatherModel * weather = [[WeatherModel alloc] init];
            weather.weatherName = [set objectForColumnName:@"name"];
            weather.weatherIcon = [set objectForColumnName:@"icon"];
            [array addObject:weather];
        }
    }
    [self.db close];
    return array;
}




-(NSArray *)selectColumnWithTableName:(NSString *)name WithElement:(NSString *)element{
    NSMutableArray * elementArray = [NSMutableArray array];
    if ([self.db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@",name];
        
        FMResultSet * set = [self.db executeQuery:sql];
        
        
        while ([set next]) {
            NSString * string = [set objectForColumnName:element];
            
            if (![elementArray containsObject:string]) {
                [elementArray addObject:string];
            }
            
            
        }
        
    }
    [self.db close];
    return elementArray;
}



























@end
