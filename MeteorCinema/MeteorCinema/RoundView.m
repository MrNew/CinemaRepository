//
//  RoundView.m
//  MeteorCinema
//
//  Created by lanou on 16/5/6.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "RoundView.h"

@implementation RoundView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        [self draw];
    }
    return self;
}






- (void)draw{
    
    UIBezierPath * line = [UIBezierPath bezierPath];
    
    [line moveToPoint:CGPointMake( 0, self.frame.size.height / 6)];
    
    [line addQuadCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height / 6) controlPoint:CGPointMake(self.frame.size.width / 2, 0)];
    
    [line addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    
    [line addLineToPoint:CGPointMake(0, self.frame.size.height)];
    
    CAShapeLayer * shape = [CAShapeLayer layer];
    
    shape.path = line.CGPath;
    
//    shape.strokeColor = [UIColor orangeColor].CGColor;
    shape.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:shape];
    
    
    
    
    
    
    
}


@end
