//
//  TopView.m
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import "TopView.h"

@interface TopView ()



@property (nonatomic, assign) CGFloat eachWidth;


@end

@implementation TopView

-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        self.buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

-(void)setTitleButton:(NSArray *)array{
    
    self.eachWidth = self.bounds.size.width / array.count;
    
    for (int i = 0; i < array.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(i * self.eachWidth, 0, self.eachWidth, self.bounds.size.height);
        
        button.backgroundColor = [UIColor orangeColor];
        
        [button setTitle:array[i] forState:UIControlStateNormal];
        
        if (i == 0) {
            [button setTitleColor:(self.selectButtonTitleColor == nil ? [UIColor blueColor] :self.selectButtonTitleColor) forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
            
        }
        
        
        
        [self addSubview:button];
        button.tag = i + 10;
        
        [self.buttonArray addObject:button];
        
        
        [button addTarget:self action:@selector(moveView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, self.eachWidth, 2)];
    [self addSubview:self.bottomView];
    self.bottomView.backgroundColor = self.selectButtonTitleColor == nil ? [UIColor blueColor] :self.selectButtonTitleColor;
    
}


-(void)moveView:(UIButton *)button{
    

    
        
    
    for (UIButton * button1 in self.buttonArray) {
        if (button1.tag != button.tag) {
            [button1 setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        }
    }

    [button setTitleColor:(self.selectButtonTitleColor == nil ? [UIColor blueColor] :self.selectButtonTitleColor) forState:UIControlStateNormal];
    self.bottomView.frame = CGRectMake(self.eachWidth * (button.tag - 10), self.bounds.size.height - 2, self.eachWidth, 2);
    
    
}


-(void)setTitleButtonColor:(UIColor *)color{
    for (UIButton * button in self.buttonArray) {
        [button setBackgroundColor:color];
    }
    
}



@end
