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
#import "SJScrollView.h"

@interface SJGroupBuyViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *datas;
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation SJGroupBuyViewController
#define SJScreenW [UIScreen mainScreen].bounds.size.width
#define SJScrollH 100
static NSString *identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
    
    [self addSubViewForScrollView];
    
    UITableView *groupBuyTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:groupBuyTableView];
    groupBuyTableView.delegate = self;
    groupBuyTableView.dataSource = self;
    groupBuyTableView.rowHeight = 100;
    groupBuyTableView.tableHeaderView = _scrollView;
    
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

#pragma mark - ScrollView

-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SJScreenW, SJScrollH)];
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(SJScreenW * 3, SJScrollH);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    _scrollView.backgroundColor = [UIColor redColor];
    
}
//在底部的ScrollView上添加缩放的scrollView
-(void)addSubViewForScrollView
{
    for (int i = 0; i < 3; i++) {
        
        SJScrollView *sjScrollView = [[SJScrollView alloc] initWithFrame:CGRectMake(SJScreenW * i, 0, SJScreenW, SJScrollH)];
        [_scrollView addSubview:sjScrollView];
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i +  1];
        
        sjScrollView.img = [UIImage imageNamed:imageName];
    }
}


@end
