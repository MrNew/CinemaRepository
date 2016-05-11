//
//  CityModel.m
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}


-(void)setValueForWeather:(NSDictionary *)dic{
    
    self.city = [dic objectForKey:@"city"];
    self.cnty = [dic objectForKey:@"cnty"];
    self.identifier = [dic objectForKey:@"id"];
    self.prov = [dic objectForKey:@"prov"];
    
}


@end
