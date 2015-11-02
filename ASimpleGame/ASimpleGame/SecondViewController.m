//
//  SecondViewController.m
//  ASimpleGame
//
//  Created by qingyun on 15/11/2.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
}
- (IBAction)selectBTN:(UIButton *)sender {
    NSString *selectedDate = [_datePicker.date descriptionWithLocale:_datePicker.locale];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你选择的时间是：" message:selectedDate preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:^{    }];
}

- (void)datePickerValueChange:(UIDatePicker *)datePicker
{
    NSLog(@"%@",[datePicker.date descriptionWithLocale:[datePicker locale]]);
}

@end
