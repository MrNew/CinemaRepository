//
//  DetailViewController.h
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(nonatomic,strong)NSString *detailAPI;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *title2;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,assign)NSInteger identifier;
@property(nonatomic,assign)NSInteger commentCount;
@end
