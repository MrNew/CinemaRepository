//
//  FirsView.h
//  说走就走
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 韦海泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDTH self.frame.size.width
#define HEIGTH self.frame.size.height

@protocol FirsViewDelegate <NSObject>

-(void)buttonClikeFinish;




@end


@interface FirsView : UIView<UIScrollViewAccessibilityDelegate>
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIImageView *imageV1;
@property(nonatomic,strong)UIImageView *imageV2;
@property(nonatomic,strong)UIImageView *imageV3;
@property(nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *buttom;



@property (nonatomic, weak) id < FirsViewDelegate > delegate;

@end
