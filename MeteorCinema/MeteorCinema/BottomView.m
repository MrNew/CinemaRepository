//
//  BottomView.m
//  UIJ 汽车市场营销
//
//  Created by lanou on 16/3/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BottomView.h"

@interface BottomView ()

//@property (nonatomic, strong) UIWebView * web;

@property (nonatomic, strong) UILabel * leftLabel;

@property (nonatomic, strong) UILabel * middleLabel;

@property (nonatomic, strong) UILabel * rightLabel;


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
        
//        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:self.collectionButton];
        
        self.leftLabel = [[UILabel alloc] init];
        [self addSubview:self.leftLabel];
        
        self.middleLabel = [[UILabel alloc] init];
        [self addSubview:self.middleLabel];
        
        self.rightLabel = [[UILabel alloc] init];
        [self addSubview:self.rightLabel];
        
//        self.web = [[UIWebView alloc] init];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    // 计算
    // 第一个点的中心x坐标
    NSInteger width = self.frame.size.width / 3 / 2;
    // 两个按钮的距离
    NSInteger spacing = self.frame.size .width / 3;
    
    // y 坐标
    NSInteger height = self.frame.size.height / 2.5;

    [self.backButton setFrame:CGRectMake(0, 0, 50, 50)];
    [self.backButton setCenter:CGPointMake(width, height)];
//    [self.backButton setBackgroundColor:[UIColor grayColor]];
    UIImage * image = [UIImage imageNamed:@"searchMovie"];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.backButton setImage:image forState:UIControlStateNormal];
    
    [self.reflashButton setFrame:CGRectMake(0, 0, 50, 50)];
    [self.reflashButton setCenter:CGPointMake(width + spacing, height)];
//    [self.reflashButton setBackgroundColor:[UIColor grayColor]];
    [self.reflashButton setImage:[UIImage imageNamed:@"searchCiname"] forState:UIControlStateNormal];
//    [self.reflashButton addTarget:self.superclass  action:@selector(reflashPage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.goForwardButton setFrame:CGRectMake(0, 0, 50, 50)];
    [self.goForwardButton setCenter:CGPointMake(width + spacing * 2, height)];
//    [self.goForwardButton setBackgroundColor:[UIColor grayColor]];
    [self.goForwardButton setImage:[UIImage imageNamed:@"searchPersent"] forState:UIControlStateNormal];
    
  
    
//    [self.collectionButton setFrame:CGRectMake(0, 0, 30, 30)];
//    [self.collectionButton setCenter:CGPointMake(width + spacing * 3, height)];
//    [self.collectionButton setBackgroundColor:[UIColor grayColor]];
    
    
    // 字体的中心坐标
    CGFloat heightOfLable = self.frame.size.height / 3 * 2.5;
    self.leftLabel.center = CGPointMake(width, heightOfLable);
    self.leftLabel.text = @"电影";
    [self.leftLabel sizeToFit];
    self.leftLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    
    
    self.middleLabel.center = CGPointMake(width + spacing, heightOfLable);
    self.middleLabel.text = @"影院";
    [self.middleLabel sizeToFit];
    self.middleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    
    self.rightLabel.center = CGPointMake(width + spacing * 2, heightOfLable);
    self.rightLabel.text = @"资讯";
    [self.rightLabel sizeToFit];
    self.rightLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    
    
    

}




//-(void)reflashPage:(UIViewController *)VC web:(UIWebView *)web{
//    self.web = web;
//    [self.reflashButton addTarget:VC action:@selector(re) forControlEvents:UIControlEventTouchUpInside];
//}


//-(void)re{
//    [self.web reload];
//}





@end
