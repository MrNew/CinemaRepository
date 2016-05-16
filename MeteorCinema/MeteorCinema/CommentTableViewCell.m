//
//  CommentTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/7.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "CommentTableViewCell.h"
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
@implementation CommentTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //用户图片
    self.userImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.userImageView];
    
    //用户姓名
    self.nicknameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nicknameLabel];
    
    //评论内容
    self.ccontentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.ccontentLabel];
    
    return self;
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    //用户图片
    self.userImageView.frame = CGRectMake(10, 10, 60, 60);
    self.userImageView.layer.cornerRadius = 30;
    self.userImageView.layer.masksToBounds = YES;
   // self.userImageView.backgroundColor = [UIColor redColor];
    
    //用户姓名
    self.nicknameLabel.frame = CGRectMake(self.userImageView.frame.origin.x+self.userImageView.frame.size.width+10, 10, 300, 30);
 //   self.nicknameLabel.backgroundColor = [UIColor cyanColor];
    
    //用户姓名
    self.ccontentLabel.frame = CGRectMake(self.userImageView.frame.origin.x+self.userImageView.frame.size.width+10, 50, 300, 30);
   // self.ccontentLabel.backgroundColor = [UIColor greenColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
