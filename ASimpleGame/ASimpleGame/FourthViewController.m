//
//  FourthViewController.m
//  ASimpleGame
//
//  Created by qingyun on 15/11/2.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *showView;

@property (nonatomic) CGFloat redNum;
@property (nonatomic) CGFloat greenNum;
@property (nonatomic) CGFloat blueNum;

@end

@implementation FourthViewController

#define SJRGBMax 255

#define SJRGBStep  5

#define SJRowNum SJRGBMax/SJRGBStep + 1

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [self randomShowView];
}

- (void)randomShowView
{
    [self selectPickerView:_pickerView forRow:round(random()%52) inComponent:RGBComponentTypeRed];
    [self selectPickerView:_pickerView forRow:round(random()%52) inComponent:RGBComponentTypeGreen];
    [self selectPickerView:_pickerView forRow:round(random()%52) inComponent:RGBComponentTypeBlue];
}

- (void)selectPickerView:(UIPickerView *)pickerView forRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView selectRow:row inComponent:component animated:YES];
    [self pickerView:pickerView didSelectRow:row inComponent:component];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return SJRowNum;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = [NSString stringWithFormat:@"%ld",SJRGBStep * row];

    return string;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = [NSString stringWithFormat:@"%ld",SJRGBStep * row];
    
    CGFloat redColor = 0;
    CGFloat greenColor = 0;
    CGFloat blueColor = 0;
    
    switch (component) {
        case RGBComponentTypeRed:
            redColor = row * SJRGBStep/255.0;
            break;
        case RGBComponentTypeGreen:
            greenColor = row * SJRGBStep/255.0;
            break;
        case RGBComponentTypeBlue:
            blueColor = row * SJRGBStep/255.0;
            break;
            
        default:
            break;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0]}];
    return attributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CGFloat value = row * SJRGBStep / 255.0;
    
    switch (component) {
        case RGBComponentTypeRed:
            _redNum = value;
            break;
        case RGBComponentTypeGreen:
            _greenNum = value;
            break;
        case RGBComponentTypeBlue:
            _blueNum = value;
            break;
            
        default:
            break;
    }
    _showView.backgroundColor = [UIColor colorWithRed:_redNum green:_greenNum blue:_blueNum alpha:1.0];
}

@end
