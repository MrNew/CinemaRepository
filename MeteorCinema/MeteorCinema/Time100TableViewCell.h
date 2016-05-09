//
//  Time100TableViewCell.h
//  MeteorCinema
//
//  Created by mcl on 16/5/9.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Time100TableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *nameEn;
@property(nonatomic,strong)UILabel *director;
@property(nonatomic,strong)UILabel *actor;
@property(nonatomic,strong)UILabel *releaseTime;
@property(nonatomic,strong)UILabel *rank;
@property(nonatomic,strong)UILabel *rating;
@property(nonatomic,strong)UIImageView *poster;
@property(nonatomic,strong)UILabel *back;

@end
