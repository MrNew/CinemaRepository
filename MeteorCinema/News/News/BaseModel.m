//
//  BaseModel.m
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
