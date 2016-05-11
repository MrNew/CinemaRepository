//
//  BoxOfficeModel.h
//  MeteorCinema
//
//  Created by mcl on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxOfficeModel : NSObject
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *nameEn;
@property(nonatomic,assign)NSInteger rankNum;
@property(nonatomic,strong)NSString *posterUrl;
@property(nonatomic,strong)NSString *weekBoxOffice;
@property(nonatomic,strong)NSString *totalBoxOffice;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,assign)float rating;
@property(nonatomic,strong)NSString *movieType;
@property(nonatomic,strong)NSString *releaseDate;
@property(nonatomic,strong)NSString *releaseLocation;
@property(nonatomic,strong)NSString *director;
@property(nonatomic,strong)NSString *actor;
@end
