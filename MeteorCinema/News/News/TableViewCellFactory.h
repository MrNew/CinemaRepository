//
//  TableViewCellFactory.h
//  News
//
//  Created by lanou on 16/4/13.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewsWithoutImageTableViewCell.h"

#import "NewsWithOneImageTableViewCell.h"

#import "NewsWithThreeMoreImageTableViewCell.h"

@interface TableViewCellFactory : NSObject

@property (nonatomic, assign) BOOL state;
// 创建单例
+(TableViewCellFactory *)share;


+(NewsWithoutImageTableViewCell *)createNewsWithoutImageTableViewCell;

+(NewsWithOneImageTableViewCell *)createNewsWithOneImageTableViewCell;

+(NewsWithThreeMoreImageTableViewCell *)createNewsWithThreeMoreTableViewCell;




@end
