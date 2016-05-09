//
//  ConnectedCollectionViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectedModel.h"

@interface ConnectedCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, strong) NSString * titleString;

@property (nonatomic, strong) UIImageView * iconImageView;

@property (nonatomic, strong) UIImageView * fontImageView;


@property (nonatomic, assign) BOOL hasVedio;


@property (nonatomic, strong) ConnectedModel * model;


@end
