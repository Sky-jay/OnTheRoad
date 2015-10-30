//
//  SJCellModel.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJCellModel.h"

@implementation SJCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return  [[self alloc]initWithDictionary:dict];
}

@end

