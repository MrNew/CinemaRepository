//
//  TrailerModel.h
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrailerModel : NSObject
@property(nonatomic,strong)NSString *movieName;
@property(nonatomic,strong)NSString *coverImg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *hightUrl;
@property(nonatomic,strong)NSString *videoTitle;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,assign)NSInteger videoLength;
@end
