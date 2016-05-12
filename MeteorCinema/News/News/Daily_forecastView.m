//
//  Daily_forecastView.m
//  News
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "Daily_forecastView.h"

#import "WeatherDataBaseUtil.h"

#import "UIImageView+WebCache.h"

@interface Daily_forecastView ()


// 早上温度
@property (nonatomic, strong) NSMutableArray * dayTmpArray;

@property (nonatomic, assign) NSInteger maxTmp;
// 晚上温度
@property (nonatomic, strong) NSMutableArray * nightTmpArray;

@property (nonatomic, assign) NSInteger minTmp;

// 各点的x坐标
@property (nonatomic, strong) NSMutableArray * pointXArray;
// 各点的y坐标 最大温度
@property (nonatomic, strong) NSMutableArray * pointYmaxArray;
//
@property (nonatomic, strong) NSMutableArray * pointYminArray;


// 图层
@property (nonatomic, strong) CAShapeLayer * layer1;

@property (nonatomic, strong) CAShapeLayer * layer2;


@end



@implementation Daily_forecastView

-(NSMutableArray *)forecastViewArray{
    if (!_forecastViewArray) {
        self.forecastViewArray = [NSMutableArray array];
    }
    return _forecastViewArray;
}

-(NSMutableArray *)dayTmpArray{
    if (!_dayTmpArray) {
        self.dayTmpArray = [NSMutableArray array];
    }
    return _dayTmpArray;
}


-(NSMutableArray *)nightTmpArray{
    if (!_nightTmpArray) {
        self.nightTmpArray = [NSMutableArray array];
    }
    return _nightTmpArray;
}

-(NSMutableArray *)pointXArray{
    if (!_pointXArray) {
        self.pointXArray = [NSMutableArray array];
    }
    return _pointXArray;
}


-(NSMutableArray *)pointYmaxArray{
    if (!_pointYmaxArray) {
        self.pointYmaxArray = [NSMutableArray array];
    }
    return _pointYmaxArray;
}

-(NSMutableArray *)pointYminArray{
    if (!_pointYminArray) {
        self.pointYminArray = [NSMutableArray array];
    }
    return _pointYminArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
      
        for (int i = 0; i < 7; i++) {
            DayforecastView * view = [[DayforecastView alloc] init];
            [self addSubview:view];
            [self.forecastViewArray addObject:view];
        }
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat widthX = self.bounds.size.width / 7;
    
    for (int i = 0; i < 7; i++) {
        DayforecastView * view = self.forecastViewArray[i];
        view.frame = CGRectMake(widthX * i, 0, widthX, self.bounds.size.height);
        
        if (self.pointXArray.count < 7) {
            // 计算出x的坐标
            [self.pointXArray addObject:[NSNumber numberWithFloat:(widthX * i + widthX / 2)]];
        }
        
    }
    
}



-(void)setWeatherValueWith:(NSArray *)array{
    

//    for (NSInteger i = self.layer.sublayers.count; i >= 0; i--) {
//        
//        CALayer * layer = self.layer.sublayers[i];
//        if ([layer isKindOfClass:[CAShapeLayer class]]) {
//            [layer removeFromSuperlayer];
//        }
//    }
    [self.layer1 removeFromSuperlayer];
    [self.layer2 removeFromSuperlayer];
    
    
    [self.dayTmpArray removeAllObjects];
    [self.nightTmpArray removeAllObjects];
    
    for (int i = 0; i < array.count; i++) {
        
        DayforecastView * view = self.forecastViewArray[i];
        NSDictionary * dic = array[i];
        NSString * string = [dic objectForKey:@"date"];
        view.dateLabel.text = [string  substringFromIndex:8];
        
        NSDictionary * cond = [dic objectForKey:@"cond"];
        view.dayStateLabel.text = [cond objectForKey:@"txt_d"];
        
        NSArray * dayArray = [[WeatherDataBaseUtil share] selectWeatherNameWith:view.dayStateLabel.text];
        
        WeatherModel * dayweather = dayArray[0];
        
      
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData * dayData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dayweather.weatherIcon]];
            UIImage * dayImage = [UIImage imageWithData:dayData];
            dayImage = [dayImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                view.dayImageView.image = dayImage;
            });
            
        });

        

        
        
        NSDictionary * tmp = [dic objectForKey:@"tmp"];
        
        [self.dayTmpArray addObject:[tmp objectForKey:@"max"]];
        
        [self.nightTmpArray addObject:[tmp objectForKey:@"min"]];
        
        

        view.nightStateLabel.text = [cond objectForKey:@"txt_n"];
        
        NSArray * nightArray = [[WeatherDataBaseUtil share] selectWeatherNameWith:view.nightStateLabel.text];
        WeatherModel * nightweather = nightArray[0];
        
        
//        [view.nightImageView sd_setImageWithURL:[NSURL URLWithString:nightweather.weatherIcon]];
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData * nightData = [NSData dataWithContentsOfURL:[NSURL URLWithString:nightweather.weatherIcon]];
            UIImage * nightImage = [UIImage imageWithData:nightData];
            nightImage = [nightImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                view.nightImageView.image = nightImage;
               
            });
            
        });
        
        
        
        
        view.popLabel.text = [dic objectForKey:@"pop"];
        
        NSDictionary * wind = [dic objectForKey:@"wind"];
        
        view.windSCLabel.text = [wind objectForKey:@"sc"];
        view.windSPDLabel.text = [wind objectForKey:@"spd"];
        
        
    }
    
    
    [self countDayTmp];
    NSLog(@"%ld",self.maxTmp);
    
    
    // 画线 UIBuzierPath
    UIBezierPath * line1 = [UIBezierPath bezierPath];
    
    UIBezierPath * line2 = [UIBezierPath bezierPath];
    
    self.layer1 = [CAShapeLayer layer];
    
    self.layer2 = [CAShapeLayer layer];
    
    
    CGFloat startY = self.frame.size.height / 15 * 8;
    
    NSInteger cha = self.maxTmp - self.minTmp;
    
    CGFloat chaY = (self.frame.size.height / 15 * 8 - self.frame.size.height / 15 * 4) / cha;
    
    
//    NSLog(@"%@",self.dayTmpArray);
//    NSLog(@"%@",self.nightTmpArray);
    
    for (int i = 0; i < self.pointXArray.count; i++) {
        CGFloat y1 = - ([self.dayTmpArray[i] floatValue] - self.minTmp) * chaY + startY;
        
        [self.pointYmaxArray addObject:[NSNumber numberWithFloat:y1]];
        
        
        
        
        CGFloat y2 = - ([self.nightTmpArray[i] floatValue] - self.minTmp) * chaY + startY;
        
        [self.pointYminArray addObject:[NSNumber numberWithFloat:y2]];
        
        
        if (i > 0) {
            // 起点
            CGPoint movePoint1 = CGPointMake([self.pointXArray[i - 1] floatValue], [self.pointYmaxArray[i - 1] floatValue]);
            // 终点
            CGPoint endPoint = CGPointMake([self.pointXArray[i] floatValue], [self.pointYmaxArray[i] floatValue]);
            
            [line1 moveToPoint:movePoint1];
            
            CGPoint controlPoint1 = CGPointMake(([self.pointXArray[i - 1] floatValue] + [self.pointXArray[i] floatValue]) / 2, [self.pointYmaxArray[i - 1] floatValue]);
            
            CGPoint controlPoint2 = CGPointMake(([self.pointXArray[i - 1] floatValue] + [self.pointXArray[i] floatValue]) / 2, [self.pointYmaxArray[i] floatValue]);
            
            
            [line1 addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
            
            
            
            
            
            
            
            
            
            ////////////////////////
            // 起点
            CGPoint movePoint2 = CGPointMake([self.pointXArray[i - 1] floatValue], [self.pointYminArray[i - 1] floatValue]);
//             终点
            CGPoint endPoint2 = CGPointMake([self.pointXArray[i] floatValue], [self.pointYminArray[i] floatValue]);
            
            [line2 moveToPoint:movePoint2];
            
            CGPoint controlPoint12 = CGPointMake(([self.pointXArray[i - 1] floatValue] + [self.pointXArray[i] floatValue]) / 2, [self.pointYminArray[i - 1] floatValue]);
            
            CGPoint controlPoint22 = CGPointMake(([self.pointXArray[i - 1] floatValue] + [self.pointXArray[i] floatValue]) / 2, [self.pointYminArray[i] floatValue]);
            
            
            [line2 addCurveToPoint:endPoint2 controlPoint1:controlPoint12 controlPoint2:controlPoint22];
            
            
            
            
            
        }
        
        
        
        self.layer1.path = line1.CGPath;
        self.layer1.lineWidth = 2;
        self.layer1.strokeColor = [UIColor whiteColor].CGColor;
        self.layer1.fillColor = [UIColor clearColor].CGColor;
        
        [self.layer addSublayer:self.layer1];
        
        
        
        self.layer2.path = line2.CGPath;
        self.layer2.lineWidth = 2;
        self.layer2.strokeColor = [UIColor whiteColor].CGColor;
        self.layer2.fillColor = [UIColor clearColor].CGColor;
        
        [self.layer addSublayer:self.layer2];
        
        
    }

    
    
    
    [self setNeedsDisplay];
    
   
}



-(void)countDayTmp{
    
    self.maxTmp = 0;
    self.minTmp = 50;
    for (int i = 0; i < self.dayTmpArray.count; i++) {
        
        self.maxTmp = self.maxTmp > [self.dayTmpArray[i] integerValue] ? self.maxTmp : [self.dayTmpArray[i] integerValue];
        
        self.minTmp = self.minTmp < [self.nightTmpArray[i] integerValue] ? self.minTmp : [self.nightTmpArray[i] integerValue];
        
    }
   
}





- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (self.dayTmpArray.count > 0) {
        for (int i = 0; i < self.forecastViewArray.count; i++) {
            
            DayforecastView * view1 = self.forecastViewArray[i];
            [self.dayTmpArray[i] drawInRect:CGRectMake([self.pointXArray[i] floatValue] - view1.frame.size.width / 6, [self.pointYmaxArray[i] floatValue] - view1.frame.size.height / 25, view1.frame.size.width, view1.frame.size.height / 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[[UIColor whiteColor] colorWithAlphaComponent:1.0]}];
            
            
            [self.nightTmpArray[i] drawInRect:CGRectMake([self.pointXArray[i] floatValue] - view1.frame.size.width / 6, [self.pointYminArray[i] floatValue] + view1.frame.size.height / 70, view1.frame.size.width, view1.frame.size.height / 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[[UIColor whiteColor] colorWithAlphaComponent:1.0]}];
            
            
        }
        
    }
    
    [self.pointYmaxArray removeAllObjects];
    [self.pointYminArray removeAllObjects];
    
}


@end
