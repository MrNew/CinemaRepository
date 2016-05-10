//
//  TableViewCellFactory.m
//  News
//
//  Created by lanou on 16/4/13.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "TableViewCellFactory.h"

static TableViewCellFactory * factory = nil;


@implementation TableViewCellFactory

+(TableViewCellFactory *)share{
    if (factory == nil) {
        factory = [[TableViewCellFactory alloc] init];
    
    }
    [factory listener];
    return factory;
}

+(NewsWithoutImageTableViewCell *)createNewsWithoutImageTableViewCell{
    
    NewsWithoutImageTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsWithoutImageTableViewCell" owner:nil options:nil] lastObject];
    
    
    return cell;
  
}


+(NewsWithOneImageTableViewCell *)createNewsWithOneImageTableViewCell{
    NewsWithOneImageTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsWithOneImageTableViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}


+(NewsWithThreeMoreImageTableViewCell *)createNewsWithThreeMoreTableViewCell{
    NewsWithThreeMoreImageTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsWithThreeMoreImageTableViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}


-(void)listener{
    // 注册成为广播站ChangeTheme频道的听众
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 成为听众一旦有广播就来调用self recvBcast:函数
    [nc addObserver:self selector:@selector(recvBcast:) name:@"text" object:nil];
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
        
        // 文字模式
        self.state = [number boolValue];
        NSLog(@"%d",self.state);
    }else{
        
        // 图片模式
        
        self.state = [number boolValue];
        NSLog(@"%d",self.state);
    }
    
    
    
}


@end
