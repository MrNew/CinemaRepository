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
    
    return (UIScreenWidth*h)/w;
}
//计算label高度的方法
-(CGFloat)getLabelHeight:(NSString *)content font:(UIFont *)font
{
    CGSize size = CGSizeMake(UIScreenWidth - 120, 100000);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
//计算label高度的方法
-(CGFloat)getContentLabelHeight:(NSString *)content font:(UIFont *)font
{
    CGSize size = CGSizeMake(UIScreenWidth - 70, 100000);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
//计算label高度的方法
-(CGFloat)getSContentLabelHeight:(NSString *)content font:(UIFont *)font
{
    CGSize size = CGSizeMake(UIScreenWidth - 90, 100000);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


@end
