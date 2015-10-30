//
//  SJCellModel.h
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJCellModel : NSObject
@property (nonatomic, strong) NSString *buycount;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
