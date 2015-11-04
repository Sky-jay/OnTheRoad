//
//  SJFriendGroup.h
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJFriendGroup : NSObject

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger online;

@property (nonatomic) BOOL isOpen;


-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)friendGroupWithDictionary:(NSDictionary *)dict;

@end
