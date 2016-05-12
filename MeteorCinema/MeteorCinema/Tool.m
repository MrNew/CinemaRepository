//
//  Tool.m
//  UI12cell自适应
//
//  Created by lanou on 16/1/28.
//  Copyright © 2016年 马善武. All rights reserved.
//

#import "Tool.h"

@implementation Tool
//计算图片高度的方法
-(CGFloat)getImageHeight:(NSString *)urlString
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    
    return (375*h)/w;
}
//计算label高度的方法
-(CGFloat)getLabelHeight:(NSString *)content font:(UIFont *)font
{
    CGSize size = CGSizeMake(375, 100000);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
@end
