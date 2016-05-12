//
//  ReviewDetailViewController.h
//  MeteorCinema
//
//  Created by mcl on 16/5/9.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewDetailViewController : UIViewController
@property(nonatomic,assign)NSInteger identifier;
@property(nonatomic,strong)NSString *itemTitle;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *image;
@end
