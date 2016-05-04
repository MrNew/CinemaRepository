//
//  NetWorkRequestManager.m
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager


// 设为 加号方法 是为了封装后使用会比较方便
+(void)requestWithType:(RequestType)type URLString:(NSString *)URLString parDic:(NSDictionary *)parDic HTTPHeader:(NSDictionary *)httpHeader finish:(RequestFinsih)finish error:(RequestError)err{
    
    NetWorkRequestManager * manager = [[NetWorkRequestManager alloc] init];
    
    [manager requestWithType:type URLString:URLString parDic:parDic HTTPHeader:httpHeader finish:finish error:err];
    
    
    
}


// 最后还是写回 减号方法 (行业规定)
-(void)requestWithType:(RequestType)type URLString:(NSString *)URLString parDic:(NSDictionary *)parDic HTTPHeader:(NSDictionary *)httpHeader finish:(RequestFinsih)finish error:(RequestError)err{
    
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    // 装化字符串为 URL 格式
    NSURL * url = [NSURL URLWithString:URLString];
    // 创建一个可变请求
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    // 判断请求类型
    if (type == POST) {
        [request setHTTPMethod:@"POST"];
    
        // 添加body
        //
        // 首先判断是否有装 body 的字典 parDic 是否为空
        if (parDic.count > 0) {
            // 将 parDic 内容转化为 NSData 方法
            // 由于 不能一步达成,故写到一个私有方法中
            NSData * data = [self DicToData:parDic];
            // 添加到body中
            [request setHTTPBody:data];
        }
    }

    // 判断是否要  添加 httpHeader
    if (httpHeader.count > 0) {
        for (NSString * key in httpHeader) {
            [request addValue:httpHeader[key] forHTTPHeaderField:key];
        }
    }
    
    // 请求数据
    // 1.0 配置 网络环境
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 2.0 创建会话
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    //
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 判断是否请求到数据
        if (data) {
            // 有,就将值传递到 finish 中
            finish(data,response);
        }else{
            err(error);
        }
    }];
    [task resume];
    
    
}


-(NSData *)DicToData:(NSDictionary *)dic{
    // 创建一个字符串,用于装body体
    NSString * string = @"";
    
    for (NSString * key in dic) {
        string = [NSString stringWithFormat:@"%@&%@=%@",string,key,dic[key]];
    }
    
    // 清空第一个多加的 & 符号
    string = [string substringFromIndex:1];
    
    // 将字符串转化为NSData
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    return data;
    
}












@end
