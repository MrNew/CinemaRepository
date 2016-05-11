//
//  Tool.h
//  UI12cell自适应
//
//  Created by lanou on 16/1/28.
//  Copyright © 2016年 马善武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject
//计算图片高度的方法
-(CGFloat)getImageHeight:(NSString *)urlString;
//计算label高度的方法
-(CGFloat)getLabelHeight:(NSString *)content font:(UIFont *)font;


@end
