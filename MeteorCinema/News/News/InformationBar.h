//
//  InformationBar.h
//  News
//
//  Created by lanou on 16/4/8.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationBar : UIView
// 抽屉栏按钮
@property (nonatomic, strong) UIButton * headButton;
// 装载版块button数组
@property (nonatomic, strong) NSMutableArray * array;
// 滑动条
@property (nonatomic, strong) UIScrollView * scrollView;
// 添加版块按钮
@property (nonatomic, strong) UIButton * addButton;
// 点击滑块的色块
@property (nonatomic, strong) UIView * moveView;


-(void)addCategory:(NSMutableArray *)array;


-(void)deleteCategory;


@end
