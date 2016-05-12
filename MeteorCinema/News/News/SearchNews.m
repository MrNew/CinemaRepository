//
//  SearchNews.m
//  News
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 Pei. All rights reserved.
//

#import "SearchNews.h"

@implementation SearchNews

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(void)setSearchNewsWithDic:(NSDictionary *)dic{
    
    self.channelName = [dic objectForKey:@"channelName"];
    
    self.imageurls = [dic objectForKey:@"imageurls"];
    
    self.link = [dic objectForKey:@"link"];
    
    self.pubDate = [dic objectForKey:@"pubDate"];
    
    self.source = [dic objectForKey:@"source"];
    
    self.title = [dic objectForKey:@"title"];
    
    
}



@end
