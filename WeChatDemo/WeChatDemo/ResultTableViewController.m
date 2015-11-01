//
//  ResultTableViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/11/1.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ResultTableViewController.h"

@interface ResultTableViewController ()
@property (nonatomic, strong)NSArray *results;
@end

@implementation ResultTableViewController

static NSString *identifier = @"cell";
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@", searchController.searchBar.text];
    _results = [_datas filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = _results[indexPath.row];
    
    return cell;
}

@end
