//
//  SJContactsViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJContactsViewController.h"
#import "SJFriendGroup.h"
#import "SJFriend.h"
#import "SJSectionHeaderView.h"

@interface SJContactsViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong)UISearchController *searchController;
@end

@implementation SJContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
/****************************SearchController****************************************/
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.searchBar.frame = CGRectMake(0, 0, 375, 44);
    
    _tableView.tableHeaderView = _searchController.searchBar;
    _searchController.searchResultsUpdater = self;
}

-(void)editAction:(UIBarButtonItem *)barButtonItem
{
    if ([barButtonItem.title isEqualToString:@"编辑"]) {
        [_tableView setEditing:YES animated:YES];
        barButtonItem.title = @"完成";
    }else{
        [_tableView setEditing:NO animated:YES];
        barButtonItem.title = @"编辑";
    }
}

static NSString *identifier = @"cell";

-(NSArray *)groups
{
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groupModels = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            SJFriendGroup *friendGroup = [SJFriendGroup friendGroupWithDictionary:dict];
            [groupModels addObject:friendGroup];
        }
        _groups = groupModels;
    }
    return _groups;
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SJFriendGroup *friendGroup = self.groups[section];
    if (friendGroup.isOpen) {
        return friendGroup.friends.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    SJFriendGroup *friendGroup = self.groups[indexPath.section];
    
    SJFriend *friend = friendGroup.friends[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.status;
    
    cell.textLabel.textColor = friend.vip ? [UIColor redColor] : [UIColor blackColor];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    SJSectionHeaderView *sectionHeaderView = [SJSectionHeaderView headerViewWithTableView:tableView];
    
    SJFriendGroup *fg = self.groups[section];
    sectionHeaderView.friendGroup = fg;
    
    sectionHeaderView.headerViewClick = ^(){
        [tableView reloadData];
    };
    
    return sectionHeaderView;
}

#pragma mark - Edit

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJFriendGroup *friendGroup = self.groups[indexPath.section];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:friendGroup.friends];
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        [array removeObjectAtIndex:indexPath.row];

        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}



-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

    SJFriendGroup *sourceFriendGroup = self.groups[sourceIndexPath.section];
    
    SJFriend *sourceFriend = sourceFriendGroup.friends[sourceIndexPath.row];
    NSMutableArray *sourceArray = [NSMutableArray arrayWithArray:sourceFriendGroup.friends];


    SJFriend *tempFriend = sourceArray[sourceIndexPath.row];
   
 
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    

    SJFriendGroup *destinationFriendGroup = self.groups[destinationIndexPath.section];
    
    SJFriend *destinationFriend = destinationFriendGroup.friends[destinationIndexPath.row];
    NSMutableArray *destinationArray = [NSMutableArray arrayWithArray:destinationFriendGroup.friends];



    [destinationArray insertObject:sourceFriend atIndex:destinationIndexPath.row];
    
}

#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if ([searchController.searchBar.text isEqualToString:@""]) {
        
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@",searchController.searchBar.text];
    
    [self.tableView reloadData];
}

@end
