//
//  WaterWaveView.m
//  WaterWaveView
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "WaterWaveView.h"




@interface WaterWaveView ()

// 定时器
@property (nonatomic, strong) CADisplayLink * timer;
// 塑造 图层
@property (nonatomic, strong) CAShapeLayer * shaperLayer;

// 路径
@property (nonatomic, assign) CGMutablePathRef path;

// 振幅
@property (nonatomic, assign) CGFloat amplitude;


// 角速度
@property (nonatomic, assign) CGFloat palstance;
// 初相位
@property (nonatomic, assign) CGFloat initialPhase;




// 起始点
@property (nonatomic, assign) CGFloat currentHeight;
// 最终高度
@property (nonatomic, assign) CGFloat endHeight;








@end

@implementation WaterWaveView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame WithAppearType:(AppearType)appearType WithdENDPercent:(CGFloat)endPercent{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        
        self.appearType = appearType;
        self.endPercent = endPercent;
        self.fillColor = [UIColor purpleColor];
        self.clipsToBounds = YES;
        
        [self setDefault];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

// 设置默认参数
-(void)setDefault{
    
    
    
    self.shaperLayer = [CAShapeLayer layer];
    // 上升,下降速度
    self.changeHeight = 0.01;
    
    
    // 振幅 (振幅如果为单一值,会导致开启来效果不太好,要来一点波动偏差,才好看)
    self.amplitude = 10;
  
  
    
    
    // 角速度 ( 调到 一个视图只有一个波形是就会有一个水流的效果了 )
    self.palstance = M_PI / 180 / 2;
    // 初相位
    self.initialPhase = M_PI / 180 * 4;
    
    
    self.endHeight = self.frame.size.height * (1 - self.endPercent);
    
    if (self.appearType == AppearTypeUP) {
        self.currentHeight = self.frame.size.height;
    }else if (self.appearType == AppearTypeDefault){
        self.currentHeight = self.frame.size.height * (1 - self.endPercent);
    }else if (self.appearType == AppearTypeDown){
        
        self.currentHeight = self.endHeight;
    }
   
    
    
}


// 停止 动画
-(void)stopAnimation{
    
//    [self.layer removeFromSuperlayer];
    
    [self.timer invalidate];
    self.timer = nil;
}

// 开始 动画
-(void)starAnimation{
    
    
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAnimation)];
    
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
   
}




-(void)doAnimation{

    [self.shaperLayer removeFromSuperlayer];
    
    // 判断模式
    if (self.appearType == AppearTypeUP) {

        if (self.currentHeight >= self.endHeight) {
            // 设置 变化速度
            self.currentHeight -= self.changeHeight;
        }else{
            self.currentHeight = self.endHeight;
        }
        
        
    }else if (self.appearType == AppearTypeDefault){
        
        self.currentHeight = self.frame.size.height * (1 - self.endPercent);
        
    }else if (self.appearType == AppearTypeDown){

        
        if (self.currentHeight <= self.frame.size.height / 10 * 11) {
            
            // 设置变化速度
            self.currentHeight += self.changeHeight;
        }else{
            
            [self stopAnimation];
            
            
            // 代理传值
            [self.delegate didFinishDown:YES];
            
        }
        
    }
    

    
    [self drawPtah];
    
    
    
   
}

// 描绘 路径
-(void)drawPtah{
    
    // 初始化
    self.path = CGPathCreateMutable();
    
    CGPathMoveToPoint(self.path, nil, 0, self.currentHeight);
    
    // 添加很多的路径 从而构成一条 完整 的正弦曲线
    for (int x = 0; x < self.frame.size.width; x++) {
        

        CGFloat y = self.amplitude * sin(self.palstance * x + self.initialPhase) + self.currentHeight;
        
        CGPathAddLineToPoint(self.path, nil, x, y);
        
    }
    self.initialPhase += 0.05;
    
    // 添加包围的路径
    CGPathAddLineToPoint(self.path, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(self.path, nil, 0, self.frame.size.height);
    
    CGPathCloseSubpath(self.path);
    
    self.shaperLayer.path = self.path;
    
    self.shaperLayer.fillColor = self.fillColor.CGColor;
    

    [self.layer addSublayer:self.shaperLayer];
    
    CGPathRelease(self.path);
    
}



@end
