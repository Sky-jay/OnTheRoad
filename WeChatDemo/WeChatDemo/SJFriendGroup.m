//
//  SJFriendGroup.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJFriendGroup.h"
#import "SJFriend.h"
@implementation SJFriendGroup

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //把friends中的字典转换成模型friend
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            SJFriend *friend = [SJFriend friendWithDictionary:dict];
            [array addObject:friend];
        }
        self.friends = array;
    }
    
    return self;
}
+(instancetype)friendGroupWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
