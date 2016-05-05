//
//  AttentionMovieTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FutureMovieModel.h"

@interface AttentionMovieTableViewCell : UITableViewCell

// 处理数据 (属性传值)
@property (nonatomic, strong) NSArray * attentionArray;



@property (nonatomic,strong) UIScrollView * scrollView;



// 用于存储里面的 attentionView 的数组
@property (nonatomic, strong) NSMutableArray * buttonArray;


-(void)setDetailView:(NSArray *)array;

@end
