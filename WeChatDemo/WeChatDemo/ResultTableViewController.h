//
//  ResultTableViewController.h
//  WeChatDemo
//
//  Created by qingyun on 15/11/1.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic, strong)NSArray *datas;
@end
