//
//  HotMovieCollectionViewCell.m
//  MeteorCinema
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "HotMovieCollectionViewCell.h"


#define Width    self.contentView.bounds.size.width
#define Height  self.contentView.bounds.size.height

@implementation HotMovieCollectionViewCell

//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        self.imageView = [[UIImageView alloc] init];
//        [self.contentView addSubview:self.imageView];
//        
//        self.label = [[UILabel alloc] init];
//        [self.contentView addSubview:self.label];
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}





-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, Width, Height / 4 * 3);
//    self.imageView.backgroundColor = [UIColor greenColor];
    
    self.label.frame = CGRectMake(0, Height / 4 * 3, Width, Height / 4);
    
    self.label.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    
    
    self.label.textAlignment = NSTextAlignmentCenter;
}




@end
