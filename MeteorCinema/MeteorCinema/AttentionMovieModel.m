//
//  AttentionMovieModel.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "AttentionMovieModel.h"

@implementation AttentionMovieModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(void)setValueWithDataDic:(NSDictionary *)dic{
    
    self.identifier = [[dic objectForKey:@"id"] integerValue];
    
    self.title = [dic objectForKey:@"title"];
    
    self.image = [dic objectForKey:@"image"];
    
    NSString * string = [dic objectForKey:@"releaseDate"];
    string = [string substringToIndex:3];
    
    self.releaseDate = string;
    
    NSString * string1 = [dic objectForKey:@"wantedCount"];
    
    NSString * string2 = [dic objectForKey:@"type"];
    
    self.wantedSee = [NSString stringWithFormat:@"%@人想看-%@",string1,string2];
    
    NSString * string3 = [dic objectForKey:@"director"];
    self.director = [NSString stringWithFormat:@"导演: %@",string3];
    
    NSString * string4 = [dic objectForKey:@"actor1"];
    NSString * string5 = [dic objectForKey:@"actor2"];
    
    self.actor = [NSString stringWithFormat:@"演员:%@,%@",string4,string5];
    
    NSInteger number = [[dic objectForKey:@"videoCount"] integerValue];
    
    if (number > 0) {
        self.videoArray = [dic objectForKey:@"videos"];
    }
    
    
    
    
    
    
    
    
}


@end
