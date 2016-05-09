//
//  NewsTableViewCell2.h
//  MeteorCinema
//
//  Created by mcl on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *commend;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
