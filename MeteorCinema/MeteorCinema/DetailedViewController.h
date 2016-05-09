//
//  DetailedViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailedViewControllerDelegate <NSObject>

@end
@interface DetailedViewController : UIViewController
@property(nonatomic,assign)NSInteger cinemaIdNUM;


@property(nonatomic,assign)id<DetailedViewControllerDelegate>delegate;
@end
