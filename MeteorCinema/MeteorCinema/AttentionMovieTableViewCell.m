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

#import "TapGestureRecognizer.h"

@interface AttentionMovieTableViewCell ()

// 用于存储里面的 attentionView 的数组
@property (nonatomic, strong) NSMutableArray * buttonArray;




@end

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
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
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
        


        TapGestureRecognizer * tap = [[TapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIndex:)];
        tap.identifier = future.identifier;
        tap.future = future;
        
        [attenionView addGestureRecognizer:tap];
        
       
        
        [attenionView setValueWithFutureMoviewModel:future];
        
        [self.buttonArray addObject:attenionView];
        
        [self.scrollView addSubview:attenionView];
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 1.3 * array.count, self.contentView.bounds.size.height);
    
}

#pragma mark- scrollView 上每个视图的手势
-(void)tapIndex:(TapGestureRecognizer *)tap{
    

//    [self.delegate passCityIdentifier:tap.identifier];
    [self.delegate passCityIdentifier:tap.future];
    
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
