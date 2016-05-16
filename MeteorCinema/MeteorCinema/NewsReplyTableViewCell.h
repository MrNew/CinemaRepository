//
//  NewsReplyTableViewCell.h
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"
@interface NewsReplyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *horizonal;

@end
