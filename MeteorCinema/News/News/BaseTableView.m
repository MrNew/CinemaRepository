//
//  BaseTableView.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        [self listener];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]) {
            self.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        }else{
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    return self;
}


#pragma mark- 监听主题切换通知
-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"style" object:nil];
}


- (void) recvBcast:(NSNotification *)notify
{
    
    
    NSDictionary *dict = [notify userInfo];
    
    NSNumber * number = [dict objectForKey:@"style"];
    
    NSLog(@"%d",[number boolValue]);
    
    if ([number boolValue]) {
        
        [UIView animateWithDuration:1 animations:^{
            self.backgroundColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        }];
        
        
        
    }else{
        
        [UIView animateWithDuration:1 animations:^{
            self.backgroundColor = [UIColor whiteColor];
        }];
       
        
        
        
    }
    
}

@end
