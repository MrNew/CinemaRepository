//
//  Button.m
//  News
//
//  Created by lanou on 16/4/9.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "Button.h"

@implementation Button

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self listener];
    }
    return self;
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
        
    }else{
        
    }
    
    
    
}

@end
