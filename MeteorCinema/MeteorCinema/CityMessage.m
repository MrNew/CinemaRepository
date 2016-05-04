//
//  CityMessage.m
//  CityIdSave
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "CityMessage.h"

@implementation CityMessage

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"%@",key);
    
    
}


-(void)setValueWithCityDic:(NSDictionary *)dic{
    
    self.identifier = [[dic objectForKey:@"id"] integerValue];
    
    self.name = [dic objectForKey:@"n"];
    
    self.count = [[dic objectForKey:@"count"] integerValue];
//    NSLog(@"%ld",self.count);
    
    self.pinyinShort = [dic objectForKey:@"pinyinShort"];
    
    self.pinyinFull = [dic objectForKey:@"pinyinFull"];
    
    if (self.pinyinShort.length > 0) {
    self.initialLetter = [self.pinyinShort substringToIndex:1];
     

    }
    
    
}


@end
