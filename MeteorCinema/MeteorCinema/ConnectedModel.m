//
//  ConnectedModel.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "ConnectedModel.h"

@implementation ConnectedModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(void)setValueWithDataDic:(NSDictionary *)dic{
    
    self.identifier = [[dic objectForKey:@"id"] integerValue];
    
    self.title = [dic objectForKey:@"title"];
    
    self.image = [dic objectForKey:@"image"];
    
    
    
}


-(void)setMovieWithDataDic:(NSDictionary *)dic{
    
//    self.identifier = [[dic objectForKey:@"id"] integerValue];
    
    self.title = [dic objectForKey:@"ce"];
    
    self.name = [dic objectForKey:@"ca"];
    
    self.image = [dic objectForKey:@"caimg"];
    
    
}

@end
