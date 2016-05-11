//
//  WaterWaveView.h
//  WaterWaveView
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举来记录 水波出现变化模式
typedef NS_ENUM(NSInteger, AppearType){
    AppearTypeUP = 0,
    AppearTypeDefault,
    AppearTypeDown
};


// 识别 已经下落到 最后了
@protocol WaterWaveViewDelegate <NSObject>

-(void)didFinishDown:(BOOL)state;

@end

@interface WaterWaveView : UIView
// 模式 (上升 下降)
@property (nonatomic, assign) AppearType appearType;
// 开始(结束)比例
@property (nonatomic, assign) CGFloat endPercent;
// 填充颜色
@property (nonatomic, strong) UIColor * fillColor;
// 变化速度
@property (nonatomic, assign) CGFloat changeHeight;

@property (nonatomic, weak) id < WaterWaveViewDelegate > delegate;

-(instancetype)initWithFrame:(CGRect)frame WithAppearType:(AppearType)appearType WithdENDPercent:(CGFloat)endPercent;


-(void)starAnimation;


-(void)stopAnimation;


@end
