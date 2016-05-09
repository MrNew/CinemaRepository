//
//  ConnectedModel.h
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectedModel : NSObject

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) NSString * image;

@property (nonatomic, strong) NSString * name;


-(void)setValueWithDataDic:(NSDictionary *)dic;


-(void)setMovieWithDataDic:(NSDictionary *)dic;

@end
