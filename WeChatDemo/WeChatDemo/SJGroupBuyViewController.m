//
//  SJGroupBuyViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJGroupBuyViewController.h"
#import "SJGroupBuyTableViewCell.h"
#import "SJCellModel.h"

@interface SJGroupBuyViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSArray *datas;

@end

@implementation SJGroupBuyViewController

static NSString *identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *groupBuyTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    [self.view addSubview:groupBuyTableView];
    groupBuyTableView.delegate = self;
    groupBuyTableView.dataSource = self;
    groupBuyTableView.rowHeight = 100;
}

- (NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            SJCellModel *cellModel = [SJCellModel modelWithDictionary:dict];
            [models addObject:cellModel];
        }
        _datas = models;
    }
    return _datas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJGroupBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    SJCellModel *model = self.datas[indexPath.row];
    if (cell == nil) {
        cell = [[SJGroupBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor redColor];
    
    cell.detailTextLabel.text = model.price;
    cell.SJLable.text = model.buycount;
    cell.imageView.image = [UIImage imageNamed:model.icon];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
