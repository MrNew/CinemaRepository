//
//  NewsCommentTableViewCell.h
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"
#import "TriangleView.h"
@interface NewsCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UILabel *nickname;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIButton *replyButton;
@property(nonatomic,strong)UITextField *tfReply;
@property(nonatomic,strong)TriangleView *triangleView;
@property(nonatomic,strong)UIView *horizonal;
@end
