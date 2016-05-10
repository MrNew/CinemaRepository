//
//  CommentTableViewCell.h
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userImageView;//用户头像
@property(nonatomic,strong)UILabel *nicknameLabel;//用户姓名
@property(nonatomic,strong)UILabel *ccontentLabel;//评论内容
@end
