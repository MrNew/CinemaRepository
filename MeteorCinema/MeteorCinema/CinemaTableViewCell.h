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
@property(nonatomic,strong)UIImageView *ConimageView;
@property(nonatomic,strong)UILabel *TitleLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *minPriceLabel;

@property(nonatomic,strong)UIImageView *Label1;
@property(nonatomic,strong)UIImageView *Label2;
@property(nonatomic,strong)UIImageView *Label3;
@property(nonatomic,strong)UIImageView *Label4;
@property(nonatomic,strong)UILabel *Label5;
@property(nonatomic,strong)UILabel *Label6;
@end
