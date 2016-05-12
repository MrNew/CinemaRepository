//
//  ListModel.h
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseModel.h"

@interface ListModel : BaseModel

@property (nonatomic, strong) NSString *  coverimg;

@property (nonatomic, strong) NSString * enname;

@property (nonatomic, strong) NSString * name;

@property (nonatomic, assign) NSInteger type;


@end
