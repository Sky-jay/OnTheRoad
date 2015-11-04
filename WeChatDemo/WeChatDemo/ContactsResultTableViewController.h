//
//  ContactsResultTableViewController.h
//  WeChatDemo
//
//  Created by qingyun on 15/11/4.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsResultTableViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic,strong) NSArray *array;
@end
