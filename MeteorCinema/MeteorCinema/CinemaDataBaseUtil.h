//
//  CinemaDataBaseUtil.h
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cinema.h"

@interface CinemaDataBaseUtil : NSObject

+(CinemaDataBaseUtil *)shareDataBase;

-(BOOL)createTable;

//插入
-(BOOL)insertCinameName:(NSString *)cinameName address:(NSString *)address cinemaId:(NSString *)cinemaId;

//删除
-(BOOL)deleteCarWithTitle:(NSString *)title;

-(NSArray *)selectWithCinema;
@end
