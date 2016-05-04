//
//  CityMessage.h
//  CityIdSave
//
//  Created by lanou on 16/4/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityMessage : NSObject

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) NSString * name;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSString * pinyinShort;

@property (nonatomic, strong) NSString * pinyinFull;

@property (nonatomic, strong) NSString * initialLetter;

// 编写方法来赋值
-(void)setValueWithCityDic:(NSDictionary *)dic;


@end
