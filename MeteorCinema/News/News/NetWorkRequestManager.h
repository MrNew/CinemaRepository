//
//  NetWorkRequestManager.h
//  News
//
//  Created by lanou on 16/4/11.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义一个枚举类型 表示请求类型
typedef NS_ENUM(NSInteger,RequestType){
    Get = 0,
    POST
};

// 定义一个 请求结束的 block作为回调 (请求成功)
typedef void(^RequestFinsih)(NSData * data,NSURLResponse * response);

//                               (请求失败)
typedef void(^RequestError)(NSError * error);

@interface NetWorkRequestManager : NSObject



+(void)requestWithType:(RequestType)type URLString:(NSString *)URLString parDic:(NSDictionary *)parDic HTTPHeader:(NSDictionary *)httpHeader finish:(RequestFinsih)finish error:(RequestError)err;


@end
