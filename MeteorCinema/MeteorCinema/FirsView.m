//
//  FirsView.m
//  说走就走
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 韦海泽. All rights reserved.
//

#import "FirsView.h"

@implementation FirsView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scroll = [[UIScrollView alloc] init];
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV3 = [[UIImageView alloc] init];
        [self addSubview:_scroll];
        [self addSubview:_imageV1];
        [self addSubview:_imageV2];
        [self addSubview:_imageV3];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _scroll.frame = CGRectMake(0, 0, WIDTH, HEIGTH);
    _scroll.contentSize = CGSizeMake(WIDTH*3, HEIGTH);
    _scroll.bounces = NO;//取消反弹
    _scroll.showsHorizontalScrollIndicator = NO;
    
    //建立imageView
    for (int i = 1; i<3; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGTH)];
        [_scroll addSubview:imageV];
        //添加图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"q%d.jpg",i]];
        imageV.image = image;
    }
    _imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGTH)];
    _imageV1.image = [UIImage imageNamed:@"q1.jpg"];
    _imageV2.image = [UIImage imageNamed:@"q2.jpg"];
    _imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGTH)];
     UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    imageV3.image = [UIImage imageNamed:@"q3.jpg"];
    
    [_scroll addSubview:_imageV1];
    [_scroll addSubview:_imageV2];
    [_scroll addSubview:imageV3];
   
    
    
    
    UIButton *buttom = [[UIButton alloc] initWithFrame:CGRectMake(130+WIDTH*2, 300, 120, 40)];
    buttom.backgroundColor = [UIColor blackColor];
    [buttom setTitle:@"进入影视" forState:UIControlStateNormal];
    [buttom addTarget:self action:@selector(touchInterface) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:buttom];
    _scroll.pagingEnabled = YES;
   // _scroll.backgroundColor = [UIColor grayColor];
    
    _imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGTH)];
    UIImage *image = [UIImage imageNamed:@"q4.jpg"];
    _imageV3.image = image;
    
[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(xianshitupian) userInfo:nil repeats:1];
    

}
-(void)touchInterface
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageV1.transform = CGAffineTransformMakeTranslation(0, -HEIGTH/2);
        _imageV2.transform = CGAffineTransformMakeTranslation(0, -HEIGTH/2);
    } completion:^(BOOL finished) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:@"you" forKey:@"标记"];
        [self removeFromSuperview];
    }];
}

-(void)xianshitupian
{
    [_imageV3 removeFromSuperview];

}
@end
