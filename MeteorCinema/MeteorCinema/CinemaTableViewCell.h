//
//  CinemaTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/3.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
@interface CinemaTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *TitleLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *minPriceLabel;
@end
