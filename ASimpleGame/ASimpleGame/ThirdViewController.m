//
//  ThirdViewController.m
//  ASimpleGame
//
//  Created by qingyun on 15/11/2.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    //设置label的圆角，无效。
    _label.layer.cornerRadius = 6;
    _label.text = self.datas[0];
    _label.clipsToBounds = YES;
    
}

- (NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
        _dict = [NSDictionary dictionaryWithContentsOfFile:path];
        _datas = _dict.allKeys;
    }
    return _datas;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datas[row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row % 2) {
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]}];
        
        return attributedString;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _label.text = self.datas[row];
}

@end
