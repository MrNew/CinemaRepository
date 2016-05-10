//
//  LocationView.m
//  MeteorCinema
//
//  Created by lanou on 16/5/4.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "LocationView.h"

#define Width self.bounds.size.width

#define Height self.bounds.size.height

@interface LocationView ()

// 表头视图
@property (nonatomic, strong) UILabel * headLabel;

@end


@implementation LocationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cityNaemLabel = [[UILabel alloc] init];
        
        
        self.cityNaemLabel.text = @"定位中...";
  
        
        [self addSubview:self.cityNaemLabel];
        
        self.headLabel = [[UILabel alloc] init];
        self.headLabel.text = @"当前定位城市";
        [self addSubview:self.headLabel];
        
       
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.headLabel.frame = CGRectMake(Width / 25, 0, Width - Width / 25, Height / 2);
    
    self.cityNaemLabel.frame = CGRectMake(Width / 25, Height / 2, Width - Width / 25, Height / 2);
    
    
}




@end
