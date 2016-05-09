//
//  TopView.h
//  MeteorCinema
//
//  Created by lanou on 16/5/5.
//  Copyright © 2016年 LiuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic, strong) NSMutableArray * buttonArray;

@property (nonatomic, strong) UIView * bottomView;

@property (nonatomic, strong) UIColor * selectButtonTitleColor;

-(void)setTitleButton:(NSArray *)array;

-(void)setTitleButtonColor:(UIColor *)color;

@end
