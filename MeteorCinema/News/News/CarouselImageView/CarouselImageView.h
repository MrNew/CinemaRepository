//
//  CarouselImageView.h
//  封装轮播图
//
//  Created by lanou on 16/4/16.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselImageViewDelete <NSObject>

-(void)touchImageIndex:(NSInteger)index;

@end


@interface CarouselImageView : UIView

// 存进的 图片数组
@property (nonatomic, strong) NSArray * imageArray;
// 存 图片描述语句数组
@property (nonatomic, strong) NSArray * messageArray;

// 分页设置
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, assign) id < CarouselImageViewDelete > delegate;


-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray time:(CGFloat)intervaltime;


-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray messageArray:(NSArray * )messageArray time:(CGFloat)intervaltime;












@end
