//
//  AttentionMovieTableViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "AttentionMovieTableViewCell.h"

#import "FutureMovieModel.h"

#import "AttentionView.h"

@implementation AttentionMovieTableViewCell

-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        self.buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:self.scrollView];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.scrollView.frame = self.contentView.bounds;
    
    
    
    
}


-(void)setDetailView:(NSArray *)array{
    
    self.scrollView.frame = self.frame;
    
    for (AttentionView * attention in self.buttonArray) {
        [attention removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    
    for (int i = 0; i < array.count; i++) {
        FutureMovieModel * future = array[i];
        
        
#pragma mark- 注意设置其frame
        AttentionView * attenionView = [[AttentionView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width / 1.3, 0, [UIScreen mainScreen].bounds.size.width / 1.3, [UIScreen mainScreen].bounds.size.height / 5)];
        
        NSLog(@"%@",attenionView);
//        attenionView.frame = CGRectMake(i *self.scrollView.bounds.size.width / 1.1, 0, self.contentView.bounds.size.width / 1.1, [UIScreen mainScreen].bounds.size.height / 5);
        
       
        
        [attenionView setValueWithFutureMoviewModel:future];
        
        [self.buttonArray addObject:attenionView];
        
        [self.scrollView addSubview:attenionView];
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.contentView.bounds.size.width / 1.3 * array.count, self.contentView.bounds.size.height);
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
