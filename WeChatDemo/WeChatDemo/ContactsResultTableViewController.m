//
//  ContactsResultTableViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/11/4.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ContactsResultTableViewController.h"
#import "SJFriendGroup.h"
#import "SJFriend.h"

@interface ContactsResultTableViewController ()
@property (nonatomic,strong) NSArray *resultArray;
@end

@implementation ContactsResultTableViewController
static NSString *identifier = @"cell";

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterString = searchController.searchBar.text;
    if (0 == filterString.length) {
        _resultArray = self.array;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[CD] %@",filterString];
        _resultArray = [self.array filteredArrayUsingPredicate:predicate];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    SJFriend *friend = _resultArray[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.status;
    
    cell.textLabel.textColor = friend.vip ? [UIColor redColor] : [UIColor blackColor];
    return cell;
}

@end
