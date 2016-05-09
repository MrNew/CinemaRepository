//
//  ReviewModel.h
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *userImage;
@property(nonatomic,strong)NSString *rating;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *movieName;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *movieRating;
@property(nonatomic,assign)NSInteger identifier;
@end
