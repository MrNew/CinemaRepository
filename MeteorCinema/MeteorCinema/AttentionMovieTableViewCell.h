//
//  AttentionMovieTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FutureMovieModel.h"

@protocol AttentionMovieTableViewCellDelegate <NSObject>

-(void)passCityIdentifier:(FutureMovieModel *)future;

@end

@interface AttentionMovieTableViewCell : UITableViewCell

// 处理数据 (属性传值)
@property (nonatomic, strong) NSArray * attentionArray;



@property (nonatomic,strong) UIScrollView * scrollView;


@property (nonatomic, weak) id < AttentionMovieTableViewCellDelegate > delegate;



-(void)setDetailView:(NSArray *)array;

@end
