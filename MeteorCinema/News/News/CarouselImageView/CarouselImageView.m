//
//  CarouselImageView.m
//  封装轮播图
//
//  Created by lanou on 16/4/16.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "CarouselImageView.h"


typedef NS_ENUM(NSInteger,Direction){
    DirectionNone,
    DirectionRight,
    DirectionLeft
};


@interface CarouselImageView () < UIScrollViewDelegate >

@property (nonatomic, strong) UIScrollView * scrollView;


// 已转化为图片的数组
@property (nonatomic, strong) NSMutableArray * image;
// 描述图片的label
@property (nonatomic, strong) UILabel * messageLabel;


// 当前imageView
@property (nonatomic, strong) UIImageView * currentImageView;
// 其他的imageView
@property (nonatomic, strong) UIImageView * otherImageView;

// 标志转动方向
@property (nonatomic, assign) Direction direction;

// 设置图片索引
@property (nonatomic, assign) NSInteger index;

// 原来的偏移量
@property (nonatomic, assign) CGFloat pastOffSet;

// 初始化一个定时器
@property (nonatomic, strong) NSTimer * timer;

// 定时器的速度
@property (nonatomic, assign) CGFloat time;


@end


@implementation CarouselImageView

#pragma mark- 懒加载
-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
        self.scrollView.delegate = self;
    }
    
    return _scrollView;
}


-(NSMutableArray *)image{
    if (!_image) {
        self.image = [NSMutableArray array];
    }
    return _image;
}


-(UILabel *)messageLabel{
    if (!_messageLabel) {
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - self.bounds.size.height / 5, self.bounds.size.width, self.bounds.size.height / 10)];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.text = @"";
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.messageLabel];
    }
    return _messageLabel;
}




-(UIImageView *)currentImageView{
    if (!_currentImageView) {
        self.currentImageView = [[UIImageView alloc] init];
        self.currentImageView.backgroundColor = [UIColor grayColor];
        self.currentImageView.image = self.image[0];
        self.currentImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchIndex:)];
        [self.currentImageView addGestureRecognizer:tap];
        
        // 设置索引
        self.index = 0;
        
        [self.scrollView addSubview:self.currentImageView];
    }
    return _currentImageView;
}

-(UIImageView *)otherImageView{
    if (!_otherImageView) {
        self.otherImageView = [[UIImageView alloc] init];
        self.otherImageView.backgroundColor = [UIColor grayColor];
        
        [self.scrollView addSubview:self.otherImageView];
    }
    return _otherImageView;
}


-(Direction)direction{
    if (_direction == DirectionNone) {
        
    }else if (_direction == DirectionLeft){
        
    }else{
        
    }
    
    return _direction;
}



-(UIPageControl *)pageControl{
    if (!_pageControl) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.bounds.size.height / 10 * 9, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height / 10)];
        self.pageControl.numberOfPages = self.imageArray.count;
        self.pageControl.enabled = NO;
        [self addSubview:self.pageControl];
    }
    return _pageControl;
}




#pragma mark- 初始化方法
// 初始化方法
-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray time:(CGFloat)intervaltime{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        self.imageArray = imageArray;
        
        [self handleImageArray];
        
        if (_image.count > 1) {
            
            self.pageControl.currentPage = 0;
            
            self.otherImageView.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            
            self.time = intervaltime;
            
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(changeScrollViewContentOffset) userInfo:nil repeats:YES];
        }
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray messageArray:(NSArray *)messageArray time:(CGFloat)intervaltime{
    if (self = [self initWithFrame:frame imageArray:imageArray time:intervaltime]) {
        self.messageArray = messageArray;
        self.messageLabel.text = self.messageArray[0];
    }
    return self;
}


// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    //有导航控制器时，会默认在scrollview上方添加64的内边距，这里强制设置为0
    self.scrollView.contentInset = UIEdgeInsetsZero;
}


#pragma mark- 处理其他方法
// 处理图片
-(void)handleImageArray{
    
   // 加载图片
    for (int i = 0; i < self.imageArray.count; i++) {
     
        if ([self.imageArray[i] isKindOfClass:[UIImage class]]) {
            
            [self.image addObject:self.imageArray[i]];
            
        }else if ([self.imageArray[i] isKindOfClass:[NSString class]]){
            
            NSURL * url = [NSURL URLWithString:self.imageArray[i]];
            NSData * data = [NSData dataWithContentsOfURL:url];
            [self.image addObject:[UIImage imageWithData:data]];
        }
    }
    

    
    // 编辑 scrollView的contentSize
    if (self.imageArray.count > 1) {
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 3, self.scrollView.bounds.size.height);
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
        
        // 添加 当前视图
        self.currentImageView.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    }else{
        
        // 只添加但前视图图片
        self.scrollView.contentSize = self.scrollView.frame.size;
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        self.currentImageView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = _image[0];
        [self addSubview:imageView];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchIndex:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView removeFromSuperview];
        
    }
}

// 改变 iamgeView 的图片
-(void)changeImage{
    
//    self.otherImageView.image
    
    // 取得curren图片的索引
    self.index = [self.image indexOfObject:self.currentImageView.image];
    
    // 判断方向 在判断放置什么图片
    if (self.direction == DirectionLeft) {
        
        if (self.index == 0) {
            self.otherImageView.image = self.image[self.image.count - 1];
            
            
        }else{
            
            self.otherImageView.image = self.image[self.index - 1];
        }
        
        
        
    }else if (self.direction == DirectionRight) {
        
        if (self.index == self.image.count - 1){
            self.otherImageView.image = self.image[0];
        }else{
            self.otherImageView.image = self.image[self.index + 1];
        }
    }
   
    
    
    
}


// 设置定时器的 动画
-(void)changeScrollViewContentOffset{
 
    [UIView animateWithDuration:self.time / 2 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * 2, 0);
        
    } completion:^(BOOL finished) {
        if (self.index >= self.image.count - 1){
            self.index = 0;
        }
        
        
        self.currentImageView.image = self.otherImageView.image;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
        self.index = [self.image indexOfObject:self.currentImageView.image];
//        NSLog(@"%ld",self.index);
        self.pageControl.currentPage = self.index;

        self.messageLabel.text = self.messageArray[self.index];
        
    }];
    
    
   
}


// 对外传递点击的 图片下标
-(void)touchIndex:(UITapGestureRecognizer *)tap{
//    NSLog(@"%ld",self.index);
    
    [self.delegate touchImageIndex:self.index];
    
    
}



#pragma mark- 代理方法

// 手动调节图片的 方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%f",scrollView.contentOffset.x);
    
    
    
    // 1.判断方向
    // 2.设置 self.otherImageView 的 frame
    // 3.设置 页数
    if (scrollView.contentOffset.x < scrollView.bounds.size.width) {
        // 图片往左
        self.direction = DirectionLeft;
        self.otherImageView.frame = CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        
        [self changeImage];
        // 设置 图片
        
    }else if (scrollView.contentOffset.x > scrollView.bounds.size.width){
        self.direction = DirectionRight;
        
        // 图片往右
        self.otherImageView.frame = CGRectMake(scrollView.bounds.size.width * 2, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        
        // 设置图片
        [self changeImage];
        
    }else{
        self.direction = DirectionNone;
    }
    
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"sdf");
//    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.x  == 0 || scrollView.contentOffset.x == scrollView.bounds.size.width * 2) {
        self.currentImageView.image = self.otherImageView.image;
        
        self.index = [self.image indexOfObject:self.currentImageView.image];
        
        self.pageControl.currentPage = self.index;
        
        self.messageLabel.text = self.messageArray[self.index];
    }
    
   
    
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    self.otherImageView.frame = CGRectMake(scrollView.bounds.size.width * 2, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
    
    [UIView animateWithDuration:1 animations:^{
        
    } completion:^(BOOL finished) {
        
//        [self.timer setFireDate:[NSDate date]];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeScrollViewContentOffset) userInfo:nil repeats:YES];
    }];
    
}




@end
