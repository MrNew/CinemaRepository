//
//  HotMovieModel.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "HotMovieModel.h"

@implementation HotMovieModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(void)setValueWithDataDic:(NSDictionary *)dic{
    self.identifier = [[dic objectForKey:@"id"] integerValue];
    
    self.title = [dic objectForKey:@"t"];
    
    self.score = [[dic objectForKey:@"r"] stringValue];
    
    self.img = [dic objectForKey:@"img"];
    
    NSString * string = [dic objectForKey:@"rd"];
    // 上映 月
    NSString * string1 = [string substringWithRange:NSMakeRange(4, 2)];
    
    // 上映 日
    NSString * string2 = [string substringFromIndex:6];
    self.time = [NSString stringWithFormat:@"%@月%@日上映",string1,string2];
    
    // 多少家影院
    NSString * string3 = [dic objectForKey:@"cC"];
    // 播映多少场
    NSString * string4 = [dic objectForKey:@"sC"];
    
    self.player = [NSString stringWithFormat:@"今日%@家影院上映%@场",string3,string4];
    
    
    NSString * common = [dic objectForKey:@"commonSpecial"];
    if (common.length > 0) {
        self.commonSpecial = [dic objectForKey:@"commonSpecial"];
    }else{
        
        NSString * string5 = [dic objectForKey:@"wantedCount"];
        NSString * string6 = [dic objectForKey:@"movieType"];
        
        self.commonSpecial = [NSString stringWithFormat:@"%@人想看-%@",string5,string6];
        
        
        
    }
    

    self.versions = [dic objectForKey:@"versions"];
    
    
    
}


@end
