//
//  Login.m
//  News
//
//  Created by lanou on 16/4/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "Login.h"

#import "Label.h"

#import "MoreViewController.h"

#import "CollectionViewController.h"

#import "WeatherViewController.h"








#define WIDTH self.frame.size.width

#define HEIGHT self.frame.size.height


@interface Login ()
//< UITableViewDataSource,UITableViewDelegate >


@property (nonatomic, strong) Label * left;

@property (nonatomic, strong) Label * middle;

@property (nonatomic, strong) Label * right;

@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation Login

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:@"LoginImage.jpg"];
        
//        self.tableView = [[UITableView alloc] init];
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        [self addSubview:self.tableView];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.leftButton];
        
        self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.middleButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.rightButton];
        
        
        self.left = [[Label alloc] init];
        [self addSubview:self.left];
        
        self.middle = [[Label alloc] init];
        [self addSubview:self.middle];
        
        self.right = [[Label alloc] init];
        [self addSubview:self.right];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.tableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT / 6 * 3);
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.bounces = NO;
//    self.tableView.backgroundColor = [UIColor purpleColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.imageView.frame = self.bounds;

    
    
    self.leftButton.frame = CGRectMake(0, 0, 32, 32);
    self.leftButton.center = CGPointMake(WIDTH / 3 / 2, HEIGHT - WIDTH / 3 / 2);
    [self.leftButton setImage:[UIImage imageNamed:@"无痕模式"] forState:UIControlStateNormal];
    self.left.frame = CGRectMake(0, 0, WIDTH / 3, 20);
    self.left.center = CGPointMake(WIDTH / 3 / 2, HEIGHT - 15);
    self.left.text = @"无痕模式";
    self.left.textAlignment = NSTextAlignmentCenter;
    [self.leftButton addTarget:self action:@selector(scaneStyle:) forControlEvents:UIControlEventTouchUpInside];

    
    self.middleButton.frame = CGRectMake(0, 0, 32, 32);
    self.middleButton.center = CGPointMake(WIDTH / 3 / 2 * 3, HEIGHT - WIDTH / 3 / 2);
    [self.middleButton setImage:[UIImage imageNamed:@"night"] forState:UIControlStateNormal];
    [self.middleButton addTarget:self action:@selector(readStyle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.middle.frame = CGRectMake(0, 0, WIDTH / 3, 20);
    self.middle.center = CGPointMake(self.middleButton.center.x, HEIGHT - 15);
    self.middle.text = @"夜间模式";
    self.middle.textColor = [UIColor whiteColor];
    self.middle.textAlignment = NSTextAlignmentCenter;
    
    

    self.rightButton.frame = CGRectMake(0, 0, 32, 32);
    self.rightButton.center = CGPointMake(WIDTH / 3 / 2 * 5, HEIGHT - WIDTH / 3 / 2);
    [self.rightButton setImage:[UIImage imageNamed:@"text"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(newsContentType:) forControlEvents:UIControlEventTouchUpInside];
    self.right.frame = CGRectMake(0, 0, WIDTH / 3, 20);
    self.right.center = CGPointMake(self.rightButton.center.x, HEIGHT - 15);
    self.right.text = @"文字模式";
    self.right.textColor = [UIColor whiteColor];
    self.right.textAlignment = NSTextAlignmentCenter;
    
}



//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 6;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * identifier = @"cell";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    
//    cell.backgroundColor = [UIColor clearColor];
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    if (indexPath.row == 0) {
////        cell.imageView.image = [UIImage imageNamed:@"head64"];
//        cell.textLabel.text = @"广州天气";
//        cell.textLabel.font = [UIFont systemFontOfSize:20];
//    }
//    
//    if (indexPath.row == 1) {
//        cell.textLabel.text = @"订阅";
//        cell.imageView.image = [UIImage imageNamed:@"message"];
//    }
//    if (indexPath.row == 2) {
//        cell.textLabel.text = @"收藏";
//        cell.imageView.image = [UIImage imageNamed:@"shoucang"];
//        
//    }
////    if (indexPath.row == 3) {
////        cell.textLabel.text = @"评论";
////        cell.imageView.image = [UIImage imageNamed:@"pinglun"];
////    }
//    if (indexPath.row == 4) {
//        cell.textLabel.text = @"更多";
//        cell.imageView.image = [UIImage imageNamed:@"gengduo"];
//    }
//    if (indexPath.row == 5) {
//        cell.textLabel.text = @"请输入关键词";
//        cell.imageView.image = [UIImage imageNamed:@"sousuo"];
//    }
//    
//    
//    return cell;
//}


-(void)scaneStyle:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"有痕模式"] forState:UIControlStateNormal];
        self.left.text = @"有痕模式";
        
        [[NSUserDefaults standardUserDefaults] setObject:@"无痕模式" forKey:@"scaneStyle"];
        
        
    }else{
        [button setImage:[UIImage imageNamed:@"无痕模式"] forState:UIControlStateNormal];
        self.left.text = @"无痕模式";
        
        [[NSUserDefaults standardUserDefaults] setObject:@"有痕模式" forKey:@"scaneStyle"];
    }
    
    // 取得ios系统唯一的全局的广播站 通知中心
    
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    
    
    //设置广播内容
    
//    NSNumber * number = [[NSNumber alloc] initWithBool:button.selected];
    //    NSLog(@"%d",[number boolValue]);
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:number forKey:@"scaneStyle"];
    
    //将内容封装到广播中 给ios系统发送广播
    
    // ChangeTheme频道
    
//    [nc postNotificationName:@"kNotificationScaneStyle" object:self userInfo:dict];
    
    
    
    
}




-(void)readStyle:(UIButton *)button{
    
    button.selected = !button.selected;

    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"day"] forState:UIControlStateNormal];
        self.middle.text = @"日间模式";
        
        [[NSUserDefaults standardUserDefaults] setObject:@"夜间模式" forKey:@"DayStyle"];
        
        
    }else{
        [button setImage:[UIImage imageNamed:@"night"] forState:UIControlStateNormal];
        self.middle.text = @"夜间模式";
        
        [[NSUserDefaults standardUserDefaults] setObject:@"日间模式" forKey:@"DayStyle"];
    }
    
    // 取得ios系统唯一的全局的广播站 通知中心
  
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  
    
   
    //设置广播内容
 
    NSNumber * number = [[NSNumber alloc] initWithBool:button.selected];
//    NSLog(@"%d",[number boolValue]);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:number forKey:@"style"];
  
    //将内容封装到广播中 给ios系统发送广播
 
    // ChangeTheme频道

    [nc postNotificationName:@"style" object:self userInfo:dict];
    
}

-(void)newsContentType:(UIButton *)button{
    
    button.selected = !button.selected;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(changeStyle:)]) {
//        
//        [self.delegate changeStyle:button.selected];
//    }
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
        self.right.text = @"图片模式";
    }else{
        [button setImage:[UIImage imageNamed:@"text"] forState:UIControlStateNormal];
        self.right.text = @"文字模式";
    }
    
    // 取得ios系统唯一的全局的广播站 通知中心
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    
    
    //设置广播内容
    
    NSNumber * number = [[NSNumber alloc] initWithBool:button.selected];
//        NSLog(@"%d",[number boolValue]);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:number forKey:@"style"];
    
    //将内容封装到广播中 给ios系统发送广播
    
    // ChangeTheme频道
    
    [nc postNotificationName:@"text" object:self userInfo:dict];
    
}



@end
