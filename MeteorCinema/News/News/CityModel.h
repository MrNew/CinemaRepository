//
//  CityModel.h
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic, strong) NSString * city;

@property (nonatomic, strong) NSString * cnty;

@property (nonatomic, strong) NSString * identifier;

@property (nonatomic, strong) NSString * prov;


-(void)setValueForWeather:(NSDictionary *)dic;



@end
