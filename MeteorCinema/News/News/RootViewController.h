//
//  RootViewController.h
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseViewController.h"

#import "InformationBar.h"



@interface RootViewController : BaseViewController

@property (nonatomic, strong) InformationBar * info;

@property (nonatomic, strong) NSMutableArray * boardArray;


-(void)refresh:(NSArray *)boardArray;


@end
