//
//  ResultTableViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/11/1.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ResultTableViewController.h"
#import "SJCellModel.h"
#import "SJGroupBuyTableViewCell.h"

@interface ResultTableViewController ()
@property (nonatomic, strong)NSArray *results;
@end

@implementation ResultTableViewController

static NSString *identifier = @"cell";
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filterString = searchController.searchBar.text;
    if (filterString.length == 0) {
        _results = _array;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[CD] %@", filterString];
        _results = [_array filteredArrayUsingPredicate:predicate];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SJGroupBuyTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 100;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJGroupBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    SJCellModel *model = _results[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor redColor];
    
    cell.detailTextLabel.text = model.price;
    cell.SJLable.text = model.buycount;
    cell.imageView.image = [UIImage imageNamed:model.icon];
    
    return cell;
}

@end
