//
//  TapGestureRecognizer.h
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FutureMovieModel.h"

@interface TapGestureRecognizer : UITapGestureRecognizer
// 携带值
@property (nonatomic, assign) NSInteger identifier;


@property (nonatomic, strong) FutureMovieModel * future;

@end
