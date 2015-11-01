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

@interface SJContactsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;


@end

@implementation SJContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

static NSString *identifier = @"cell";
//懒加载
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
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SJFriendGroup *friendGroup = self.groups[section];
    if (friendGroup.isOpen) {
        return friendGroup.friends.count;
    }
    return 0;
}
//每行单元格
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

//设置sectionHeaderView高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#if 0
//section的头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    QYFriendGroup *friendGroup = self.groups[section];
    return friendGroup.name;
}
#endif

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建sectionHeaderView（已经复用）
    SJSectionHeaderView *sectionHeaderView = [SJSectionHeaderView headerViewWithTableView:tableView];
    //取出当前section对应的数据模型QYFriendGroup
    SJFriendGroup *fg = self.groups[section];
    sectionHeaderView.friendGroup = fg;
    
    sectionHeaderView.headerViewClick = ^(){
        [tableView reloadData];
    };
    
    return sectionHeaderView;
}

@end
