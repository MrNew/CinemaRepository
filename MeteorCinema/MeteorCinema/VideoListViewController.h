//
//  VideoListViewController.h
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListViewController : UIViewController

@property (nonatomic, strong) NSString * imageStr;

@property (nonatomic, strong) NSString * nameStr;

// 属性传值
@property (nonatomic, strong) NSArray * videoArray;

@end
