//
//  FirstViewController.m
//  ASimpleGame
//
//  Created by qingyun on 15/11/2.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "FirstViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface FirstViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic) NSInteger hardLevel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hardLevel = 2;
    _label.layer.cornerRadius = 6;
    _label.clipsToBounds = YES;
    _label.text = @"请点击开始！";
    _label.textColor = [UIColor blackColor];
    [self loadData];
    
}

- (void)loadData
{
    _datas = @[@"apple", @"bar", @"cherry", @"crown", @"lemon", @"seven"];
}

- (IBAction)startAction:(UIButton *)sender {
    _label.text = @"";
    
    NSInteger numOfContinous = 1;
    NSInteger compareRow = 0;
    BOOL isWin = NO;
    
    for (int i = 0; i < 5; i++) {
        
        NSInteger selectRow = round(random()%_datas.count);
        [_pickView selectRow:selectRow inComponent:i animated:YES];
        
        if (i == 0) {
            compareRow = selectRow;
            numOfContinous = 1;
        }else{
            if (compareRow == selectRow) {
                numOfContinous++;
            }else{
                numOfContinous = 1;
            }
            compareRow = selectRow;
        }
        if (numOfContinous >= _hardLevel) {
            isWin = YES;
        }
    }
    [self playSoundWithFileName:@"crunch"];
    
    if (isWin) {
        _label.text = @"WIN!!!";
        _label.textColor = [UIColor redColor];
        [self playSoundWithFileName:@"win"];
    }else{
        _label.text = @"再接再厉！";
        _label.textColor = [UIColor blueColor];
    }
    [self performSelector:@selector(changeLabel) withObject:nil afterDelay:2];
}

- (void)changeLabel
{
    _label.textColor = [UIColor blackColor];
    _label.text = @"请点击开始！";
}

- (void)playSoundWithFileName:(NSString *)name
{
    SystemSoundID soundId;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    //把声音文件转化成NSURL,然后再强转成CFURLRef
    CFURLRef ref = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    //用ref创建soundId
    AudioServicesCreateSystemSoundID(ref, &soundId);
    //播放soundId指定的声音
    AudioServicesPlaySystemSound(soundId);
}

- (IBAction)segmentedControlAction:(UISegmentedControl *)sender {
    _hardLevel = sender.selectedSegmentIndex + 2;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datas.count;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *imageName = [NSString stringWithFormat:@"%@",_datas[row]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    return imageView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 100;
}

@end
