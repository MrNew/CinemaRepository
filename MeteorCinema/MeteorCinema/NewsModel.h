//
//  NewsModel.h
//  MeteorCinema
//
//  Created by mcl on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *title2;
@property(nonatomic,assign)NSInteger publishTime;//发布时间
@property(nonatomic,strong)NSString *url1;
@property(nonatomic,strong)NSString *url2;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,assign)NSInteger commentCount;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSString *image1;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,assign)NSInteger identifier;
@end
