//
//  DayforecastView.m
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "DayforecastView.h"

@implementation DayforecastView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.dateLabel = [[UILabel alloc] init];
        [self addSubview:self.dateLabel];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.textColor = [UIColor whiteColor];
        
        self.dayStateLabel = [[UILabel alloc] init];
        [self addSubview:self.dayStateLabel];
        self.dayStateLabel.textAlignment = NSTextAlignmentCenter;
        self.dayStateLabel.textColor = [UIColor whiteColor];
        
        self.dayImageView = [[UIImageView alloc] init];
        [self addSubview:self.dayImageView];
        self.dayImageView.tintColor = [UIColor whiteColor];
        
        
        
        
        
        self.nightImageView = [[UIImageView alloc] init];
        [self addSubview:self.nightImageView];
        self.nightImageView.tintColor = [UIColor whiteColor];
       
        
        
        self.nightStateLabel = [[UILabel alloc] init];
        [self addSubview:self.nightStateLabel];
        self.nightStateLabel.textAlignment = NSTextAlignmentCenter;
        self.nightStateLabel.textColor = [UIColor whiteColor];
        
        self.popLabel = [[UILabel alloc] init];
        [self addSubview:self.popLabel];
        self.popLabel.textAlignment = NSTextAlignmentCenter;
        self.popLabel.textColor = [UIColor whiteColor];
        
        
        self.windSCLabel = [[UILabel alloc] init];
        [self addSubview:self.windSCLabel];
        self.windSCLabel.textAlignment = NSTextAlignmentCenter;
        self.windSCLabel.textColor = [UIColor whiteColor];
        
        self.windSPDLabel = [[UILabel alloc] init];
        [self addSubview:self.windSPDLabel];
        self.windSPDLabel.textAlignment = NSTextAlignmentCenter;
        self.windSPDLabel.textColor = [UIColor whiteColor];
        
        
        
        
        
        
    }
    return self;
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.dateLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 15);
    
    self.dayStateLabel.frame = CGRectMake(0, self.bounds.size.height / 15, self.bounds.size.width, self.bounds.size.height / 15);
//    self.dayStateLabel.backgroundColor = COLOR(100, 100, 100, 1);
    
    self.dayImageView.frame = CGRectMake(0, self.bounds.size.height / 15 * 2, self.bounds.size.height / 15, self.bounds.size.height / 15);
    self.dayImageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 15 / 2 + self.bounds.size.height / 15 * 2);
    
//    self.dayImageView.backgroundColor = [UIColor orangeColor];
    
    
    self.nightImageView.frame = CGRectMake(0, self.bounds.size.height / 15 * 9, self.bounds.size.height / 15, self.bounds.size.height / 15);
    self.nightImageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 15 / 2 + self.bounds.size.height / 15 * 9);
    
    
//    self.nightImageView.backgroundColor = COLOR(100, 100, 100, 1);
    
    
    
    
    self.nightStateLabel.frame = CGRectMake(0, self.bounds.size.height / 15 * 10, self.bounds.size.width, self.bounds.size.height / 15);
//    self.nightStateLabel.backgroundColor = [UIColor orangeColor];
    
    
    self.popLabel.frame = CGRectMake(0, self.bounds.size.height / 15 * 11, self.bounds.size.width, self.bounds.size.height / 15);
//    self.popLabel.backgroundColor = COLOR(100, 100, 100, 1);
    
    self.windSCLabel.frame = CGRectMake(0, self.bounds.size.height / 15 * 12, self.bounds.size.width, self.bounds.size.height / 15);
//    self.windSCLabel.backgroundColor = [UIColor orangeColor];
    
    self.windSPDLabel.frame = CGRectMake(0, self.bounds.size.height / 15 * 13
                                         , self.bounds.size.width, self.bounds.size.height / 15);
//    self.windSPDLabel.backgroundColor = COLOR(100, 100, 100, 1);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


















@end
