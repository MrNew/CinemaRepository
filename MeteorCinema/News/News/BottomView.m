//
//  BottomView.m
//  UIJ 汽车市场营销
//
//  Created by lanou on 16/3/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BottomView.h"

@interface BottomView ()

@property (nonatomic, strong) UIWebView * web;

@end


@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.backButton];
        
        self.reflashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.reflashButton];
        
        self.goForwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.goForwardButton];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.collectionButton];
        
        
        self.web = [[UIWebView alloc] init];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 计算
    // 第一个点的中心x坐标
    NSInteger width = self.frame.size.width / 4 / 2;
    // 两个按钮的距离
    NSInteger spacing = self.frame.size .width / 4;
    
    // y 坐标
    NSInteger height = self.frame.size.height / 2;

    [self.backButton setFrame:CGRectMake(0, 0, 30, 30)];
    [self.backButton setCenter:CGPointMake(width, height)];
//    [self.backButton setBackgroundColor:[UIColor grayColor]];
    UIImage * image = [UIImage imageNamed:@"fanhui"];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.backButton setImage:image forState:UIControlStateNormal];
    
    [self.reflashButton setFrame:CGRectMake(0, 0, 30, 30)];
    [self.reflashButton setCenter:CGPointMake(width + spacing, height)];
//    [self.reflashButton setBackgroundColor:[UIColor grayColor]];
    [self.reflashButton setImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
//    [self.reflashButton addTarget:self.superclass  action:@selector(reflashPage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.goForwardButton setFrame:CGRectMake(0, 0, 30, 30)];
    [self.goForwardButton setCenter:CGPointMake(width + spacing * 2, height)];
//    [self.goForwardButton setBackgroundColor:[UIColor grayColor]];
    [self.goForwardButton setImage:[UIImage imageNamed:@"qianjin"] forState:UIControlStateNormal];
    
  
    
    [self.collectionButton setFrame:CGRectMake(0, 0, 30, 30)];
    [self.collectionButton setCenter:CGPointMake(width + spacing * 3, height)];
//    [self.collectionButton setBackgroundColor:[UIColor grayColor]];
    

}




-(void)reflashPage:(UIViewController *)VC web:(UIWebView *)web{
    self.web = web;
    [self.reflashButton addTarget:VC action:@selector(re) forControlEvents:UIControlEventTouchUpInside];
}


-(void)re{
    [self.web reload];
}





@end
