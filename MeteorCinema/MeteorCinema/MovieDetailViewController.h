//
//  MovieDetailViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotMovieModel.h"

#import "FutureMovieModel.h"

@interface MovieDetailViewController : UIViewController

// 属性传值

@property (nonatomic, assign) NSInteger cityID;

@property (nonatomic, assign) NSInteger movieID;

@property (nonatomic, strong) HotMovieModel * hotMovie;

@property (nonatomic, strong) FutureMovieModel * future;


@end
