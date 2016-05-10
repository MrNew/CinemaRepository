//
//  NewsModel.m
//  News
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(void)setValuesWithDic:(NSDictionary *)dic{
    self.identifier = [dic objectForKey:@"id"];
    
    self.index = [dic objectForKey:@"index"];
    
    self.time = [dic objectForKey:@"time"];
    
    self.title = [dic objectForKey:@"title"];
    
    self.haveImg = [dic objectForKey:@"haveImg"];
    
    self.site = [dic objectForKey:@"site"];
    
    self.imgSids = [dic objectForKey:@"imgSids"];
    
  
}





@end
