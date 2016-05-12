//
//  BaseViewController.m
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self listener];
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DayStyle"] isEqualToString:@"夜间模式"]) {
//        self.view.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
//    }else{
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
    
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
    
    //    NSLog(@"%d",[number boolValue]);
    if ([number boolValue]) {
        // 黑夜模式
        [UIView animateWithDuration:1 animations:^{
            
            self.view .backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        }];
    }else{
        // 日间模式
        [UIView animateWithDuration:1 animations:^{
            
            self.view.backgroundColor = [UIColor whiteColor];
        }];
    }
    
    
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
