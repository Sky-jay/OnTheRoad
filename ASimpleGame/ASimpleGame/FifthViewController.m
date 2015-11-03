//
//  FifthViewController.m
//  ASimpleGame
//
//  Created by qingyun on 15/11/3.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSArray *values;
@end

@implementation FifthViewController
#define ScreenW [UIScreen mainScreen].bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self loadData];
}

- (void)addSubViews
{
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, ScreenW, 200)];
    [self.view addSubview:_pickerView];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    CGFloat btnW = 105;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake( (ScreenW - btnW) / 2, 450, btnW, 40)];
    [btn setTitle:@"选择" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 6;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    _keys = [[_dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _values = _dict[_keys.firstObject];
}

- (void)btnAction:(UIButton *)btn
{
    NSInteger firstComponent = [_pickerView selectedRowInComponent:0];
    NSInteger secondComponent = [_pickerView selectedRowInComponent:1];
    NSString *string = [NSString stringWithFormat:@"所选信息：%@ : %@",_keys[firstComponent],_values[secondComponent] ];
    
#if 0
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请确认你选择的信息是：" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
#else
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:string delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"信息有误，点此反馈！" otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
    
#endif
    
}

#pragma mark - UIpickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _keys.count;
    }else{
        return _values.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _keys[row];
    }else{
        return _values[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString *key = _keys[row];
        _values = _dict[key];
        [_pickerView reloadComponent:1];
        [_pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

@end
