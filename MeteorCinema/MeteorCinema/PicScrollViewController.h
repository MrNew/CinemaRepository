//
//  PicScrollViewController.h
//  MeteorCinema
//
//  Created by mcl on 16/5/8.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicScrollViewController : UIViewController
@property(nonatomic,strong)NSString *picAPI;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *title2;
@property(nonatomic,assign)NSInteger identifier;
@property(nonatomic,assign)NSInteger commentCount;
@end
