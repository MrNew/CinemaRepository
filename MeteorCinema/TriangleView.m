//
//  TriangleView.m
//  MeteorCinema
//
//  Created by mcl on 16/5/13.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
//    //定义画图的path
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    
//    //path移动到开始画图的位置
//    [path moveToPoint:CGPointMake(25, 0)];
//    //从开始位置画一条直线到
//    [path addLineToPoint:CGPointMake(0, 25)];
//    //在从（160，150）画一条线到
//    [path addLineToPoint:CGPointMake(50, 25)];
//    
//    //关闭path
//    [path closePath];
//    
//    //三角形内填充绿色
//    [[UIColor lightGrayColor] setFill];
//    [path fill];
//    //三角形的边框为红色
//    [[UIColor grayColor] setStroke];
//    [path stroke];
    
    //设置背景颜色
    [[UIColor whiteColor]set];
    
    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context,10, 0);//设置起点
    CGContextAddLineToPoint(context,0, 10);
    CGContextAddLineToPoint(context,20, 10);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[[UIColor lightGrayColor]colorWithAlphaComponent:0.2] setFill]; //设置填充色
    [[UIColor clearColor] setStroke]; //设置边框颜色
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
