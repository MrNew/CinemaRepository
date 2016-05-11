//
//  InformationBar.m
//  News
//
//  Created by lanou on 16/4/8.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "InformationBar.h"

#import "Button.h"

#import "BaseButton.h"

#define WIDTH self.frame.size.width

#define HEIGHT self.frame.size.height



@interface InformationBar () < UIScrollViewDelegate >
{
    // button按钮的标题字数
    NSInteger stringlength;
}

@property (nonatomic, strong) UIImageView * imageView;

@end


@implementation InformationBar




-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        self.headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.headButton];
        
        self.array = [NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.addButton];
        
        
        self.moveView = [[UIView alloc] init];
        [self.scrollView addSubview:self.moveView];
        
        
        [self listener];
        
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.imageView.frame = self.bounds;
//    self.imageView.image = [UIImage imageNamed:@"InformationBarImage.jpg"];
    
    
    
    self.headButton.frame = CGRectMake(0, 0, HEIGHT / 1.5 , HEIGHT / 1.5 );
    self.headButton.center = CGPointMake(HEIGHT / 2, HEIGHT / 2 + 8);
    [self.headButton setBackgroundColor:[UIColor clearColor]];
    UIImage * image = [UIImage imageNamed:@"head"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.headButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    self.scrollView.frame = CGRectMake(HEIGHT, 8, WIDTH - 2 * HEIGHT, HEIGHT);
    self.scrollView.backgroundColor = self.backgroundColor;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.pagingEnabled = YES;
    
    
    
    self.addButton.frame = CGRectMake(WIDTH - HEIGHT, 0, HEIGHT / 2.5, HEIGHT / 2.5);
    self.addButton.center = CGPointMake(WIDTH - HEIGHT / 2, HEIGHT / 2 + 8);
    [self.addButton setBackgroundColor:[UIColor clearColor]];
    UIImage * image1 = [UIImage imageNamed:@"add"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.addButton setBackgroundImage:image1 forState:UIControlStateNormal];
    
    
    self.moveView.frame = CGRectMake(0, 0, HEIGHT * 2.5, HEIGHT / 2);
    self.moveView.center = CGPointMake(HEIGHT * 2.5 / 2, HEIGHT / 2);
    self.moveView.layer.cornerRadius = 5;
    self.moveView.layer.masksToBounds = YES;
    self.moveView.backgroundColor = COLOR(200, 240, 254, 1);
    
    
}




-(void)addCategory:(NSMutableArray *)array{
    
    for (int i = 0; i < array.count; i++) {
        
        NSString * string = array[i];
        stringlength = string.length;
        
        BaseButton * button = [BaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * HEIGHT * 2.5, 0, HEIGHT * 2.5 , HEIGHT);
//        NSLog(@"----%f------",button.frame.origin.x);
        
        
        
        button.tag = i;
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
        
        if (i == 0) {
            [button setTitleColor:COLOR(146, 183, 154, 1) forState:UIControlStateNormal];
        }
        
        
//        button.showsTouchWhenHighlighted = YES;
        
        // 添加点击事件
        [button addTarget:self action:@selector(touchMove:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        [self.array addObject:button];
    
        
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width + button.frame.size.width, HEIGHT)];
    }
    
    
}


-(void)touchMove:(BaseButton *)button{
    
    
    
    for (int i = 0; i < self.array.count; i++) {
 
        
        if (button.tag == i) {
            [button setTitleColor:COLOR(146, 183, 154, 1) forState:UIControlStateNormal];
            
            // 处理Button的方法
            [self setMoveViewLoacation:button];
            

            // 让button居中显示
//            [self setButtonCenter:button];
            
            
        }else{
            BaseButton * button3 = self.array[i];
            [button3 setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
            
            
        }
        
        
        
    }
    
    
}





// 控制Button的方法
-(void)setMoveViewLoacation:(BaseButton *)button{

    [UIView animateWithDuration:0.5 animations:^{
        self.moveView.frame = CGRectMake(HEIGHT * 2.5 * button.tag , 0, HEIGHT * 2.5, HEIGHT / 2);
        self.moveView.center = CGPointMake(HEIGHT * 2.5  * button.tag  + HEIGHT * 2.5 / 2, HEIGHT / 2);
    } completion:^(BOOL finished) {
       
    }];
    
}


// // 让button居中显示
-(void)setButtonCenter:(BaseButton *)button{
    
}







-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"style" object:nil];
}


- (void) recvBcast:(NSNotification *)notify
{
    
    //    static int index;
    
    //    NSLog(@"recv bcast %d", index++);
    // 取得广播内容
    
    NSDictionary *dict = [notify userInfo];
    
    NSNumber * number = [dict objectForKey:@"style"];
    
 
    if ([number boolValue]) {
        [UIView animateWithDuration:1 animations:^{
            
            self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
            self.scrollView.backgroundColor = self.backgroundColor;
        }];
        
    }else{
        [UIView animateWithDuration:1 animations:^{
            
            self.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            self.scrollView.backgroundColor = self.backgroundColor;
        }];
    }
    
    
}


-(void)deleteCategory{
    for (UIView * view in self.scrollView.subviews) {
        if ([view isKindOfClass:[BaseButton class]]) {
            [view removeFromSuperview];
        }
   
    }
    
    [self.array removeAllObjects];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
