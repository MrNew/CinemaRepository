//
//  NewsViewController.h
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseViewController.h"

#import "BaseTableView.h"

@interface NewsViewController : BaseViewController



// 传值
// 板块名字
@property (nonatomic, strong) NSString * boardString;


//-(void)passBoard:(NSString *)boardString;

//-(void)finedelegate;

-(void)updata;

@end
