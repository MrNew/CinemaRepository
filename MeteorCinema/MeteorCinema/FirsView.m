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
        [UIApplication sharedApplication].statusBarHidden = YES;

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
    for (int i = 0; i<2; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGTH)];
        [_scroll addSubview:imageV];
        //添加图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"qidongtu%d.jpg",i+1]];
        imageV.image = image;
    }
    UIImage *image = [UIImage imageNamed:@"qidongtu3.jpg"];
    _imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH/2, HEIGTH)];
    _imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*2.5, 0, WIDTH/2, HEIGTH)];
    CGImageRef ref1 = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width/2, image.size.height));
    CGImageRef ref2 = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(image.size.width/2, 0, image.size.width/2, image.size.height));
    _imageV1.image = [UIImage imageWithCGImage:ref1];
    _imageV2.image = [UIImage imageWithCGImage:ref2];
//     UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGTH)];
//    imageV3.image = [UIImage imageNamed:@"q3.jpg"];
    
    [_scroll addSubview:_imageV1];
    [_scroll addSubview:_imageV2];
  //  [_scroll addSubview:imageV3];
   
    
    
    
    UIButton *buttom = [[UIButton alloc] initWithFrame:CGRectMake(130+WIDTH*2, 260, 120, 40)];
    buttom.backgroundColor = [UIColor redColor];
    [buttom setTitle:@"进入影视" forState:UIControlStateNormal];
    [buttom addTarget:self action:@selector(touchInterface) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:buttom];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, UIScreenHeight - 75, WIDTH, 30)];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(touchPage:) forControlEvents:UIControlEventValueChanged];

}
-(void)touchInterface
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageV1.transform = CGAffineTransformMakeTranslation(-WIDTH/2, 0);
        _imageV2.transform = CGAffineTransformMakeTranslation(WIDTH/2, 0);
    } completion:^(BOOL finished) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:@"you" forKey:@"标记"];
        [self removeFromSuperview];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/WIDTH;
}
-(void)touchPage:(UIPageControl *)pageV
{
    _scroll.contentOffset = CGPointMake(WIDTH*_pageControl.currentPage, 0);
}
@end
