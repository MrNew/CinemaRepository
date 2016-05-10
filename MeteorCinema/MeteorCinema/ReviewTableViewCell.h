//
//  ReviewTableViewCell.h
//  MeteorCinema
//
//  Created by mcl on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell
@property (strong, nonatomic)UILabel *title;
@property (strong, nonatomic)UILabel *summary;
@property (strong, nonatomic)UILabel *moviename;
@property (strong, nonatomic)UIImageView *movieImage;
@property (strong, nonatomic)UIImageView *userImage;
@property (strong, nonatomic)UILabel *userRating;
@property (strong, nonatomic)UILabel *username;

@end
