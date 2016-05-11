//
//  WaterView.m
//  News
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "WaterView.h"

@interface WaterView ()
{
    UIColor *_currentWaterColor;
    
    
    
    float a;
    float b;
    
    BOOL jia;
}

@property (nonatomic, strong) CADisplayLink * timer;



@end


@implementation WaterView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        
        _currentWaterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        // 水上方的高度
        _currentLinePointY = self.bounds.size.height / 5;
        
        
        
    }
    return self;
}


-(void)starAnimation{
    
    // 添加 到 runLoop 中
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateWave)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
    
}


-(void)stopAnimation{
    [self.timer invalidate];
    self.timer = nil;
}


-(void)animateWave
{
    // jia 判断当前是否加
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    // 决定 对于当前高度 的 水波高度 最大偏移量
    if (a <= 1) {
        jia = YES;
    }
    
    // 决定 对于当前高度 的 水波高度 最小偏移量
    if (a >= 1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    
    //  x 设置 长度
    for(float x = 0; x <=  self.frame.size.width ; x++){
        y= a * sin( x / 180 * M_PI + 4 * b / M_PI ) * 5 + _currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
    if (_currentLinePointY <= self.frame.size.height / 2) {
        _currentLinePointY += 1;
    }else{
        _currentLinePointY -= 1;
    }
    
    
    
    
}

@end
