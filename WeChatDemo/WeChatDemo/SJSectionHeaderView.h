//
//  SJSectionHeaderView.h
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJFriendGroup;
@interface SJSectionHeaderView : UITableViewHeaderFooterView


@property (nonatomic, strong)SJFriendGroup *friendGroup;

@property (nonatomic, strong) void (^headerViewClick)(void);

+(instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
