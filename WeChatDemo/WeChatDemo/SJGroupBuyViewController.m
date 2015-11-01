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
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
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
    _tableView = groupBuyTableView;
    groupBuyTableView.delegate = self;
    groupBuyTableView.dataSource = self;
    groupBuyTableView.rowHeight = 100;
    groupBuyTableView.tableHeaderView = _scrollView;
    
    //添加右边的UIBarButtonItem
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    

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

#pragma mark - Edit

//编辑（增加，删除）

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//指定编辑风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //更改数据源
//        [array removeObjectAtIndex:indexPath.row];
        
        //更改界面
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}


@end
