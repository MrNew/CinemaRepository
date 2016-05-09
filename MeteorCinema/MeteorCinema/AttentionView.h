//
//  AttentionView.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FutureMovieModel.h"

@protocol AttenionViewDelegate <NSObject>

-(void)passCityIdebtifier:(FutureMovieModel *)future;

@end


@interface AttentionView : UIView

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong)  UIImageView * imageView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * wantedSee;

@property (nonatomic, strong) UILabel * directorLabel;

@property (nonatomic, strong) UILabel * actorLabel;

@property (nonatomic, strong) UIButton * forcastButton;



@property (nonatomic, weak) id < AttenionViewDelegate > delegate;


-(void)setValueWithFutureMoviewModel:(FutureMovieModel *)future;


@end
