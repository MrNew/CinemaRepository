//
//  NowWeatherView.m
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NowWeatherView.h"

@implementation NowWeatherView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.nowStateLabel = [[UILabel alloc] init];
        [self addSubview:self.nowStateLabel];
        
        self.nowTemLabel = [[UILabel alloc] init];
        [self addSubview:self.nowTemLabel];
        
        self.nowWindLabel = [[UILabel alloc] init];
        [self addSubview:self.nowWindLabel];
        
        self.nowHumLabel = [[UILabel alloc] init];
        [self addSubview:self.nowHumLabel];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.nowStateLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 6);
//    self.nowStateLabel.text = @"--";
    self.nowStateLabel.textColor = [UIColor whiteColor];
    
    self.nowTemLabel.frame = CGRectMake(0, self.frame.size.height / 6, self.frame.size.width, self.frame.size.height / 6 * 4);
//    self.nowTemLabel.text = @"--";
    self.nowTemLabel.textColor = [UIColor whiteColor];
    self.nowTemLabel.font = [UIFont systemFontOfSize:60];
    
    
    self.nowWindLabel.frame = CGRectMake(0, self.frame.size.height / 6 * 5, self.frame.size.width / 5 * 3, self.frame.size.height / 6);
//    self.nowWindLabel.text = @"----";
    self.nowWindLabel.font = [UIFont systemFontOfSize:15];
    self.nowWindLabel.textColor = [UIColor whiteColor];
    
    
    self.nowHumLabel.frame = CGRectMake(self.frame.size.width / 5 * 2, self.frame.size.height / 6 * 5, self.frame.size.width / 5 * 2.5, self.frame.size.height / 6);
//    self.nowHumLabel.text = @"湿度 -";
    self.nowHumLabel.textAlignment = NSTextAlignmentRight;
    self.nowHumLabel.textColor = [UIColor whiteColor];
    self.nowHumLabel.font = [UIFont systemFontOfSize:15];
    
}


-(void)setTitleWithDictionary:(NSDictionary *)dic{
    
    NSDictionary * state = [dic objectForKey:@"cond"];
    
    self.nowStateLabel.text = [state objectForKey:@"txt"];
//    self.nowStateLabel.numberOfLines = 2;
//    self.nowStateLabel.font = [UIFont systemFontOfSize:12];
//    [self.nowStateLabel sizeToFit];
    
    self.nowTemLabel.text = [dic objectForKey:@"tmp"];
    
    NSDictionary * wind = [dic objectForKey:@"wind"];
    
    NSString * windStr = [NSString stringWithFormat:@"%@",[wind objectForKey:@"dir"]];
    
    self.nowWindLabel.text = windStr;
    
    self.nowHumLabel.text = [NSString stringWithFormat:@"湿度%@%%",[dic objectForKey:@"hum"]];
    
    
}



@end
