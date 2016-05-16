//
//  CinemaCollectionViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@protocol CinemaCollectionpassValueDelegate <NSObject>

-(void)pusValue:(Cinema *)doc;

@end

@interface CinemaCollectionViewController : UIViewController
@property(nonatomic,assign)NSInteger integ;
@property(nonatomic,assign)id<CinemaCollectionpassValueDelegate>delegate;
@end
