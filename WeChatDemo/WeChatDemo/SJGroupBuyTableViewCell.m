//
//  SJGroupBuyTableViewCell.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJGroupBuyTableViewCell.h"

@implementation SJGroupBuyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *lable = [[UILabel alloc]init];
        [self.contentView addSubview:lable];
        _SJLable = lable;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(170, 5, 200, 30);
    //    self.textLabel.font = [UIFont boldSystemFontOfSize:15];
    self.detailTextLabel.frame = CGRectMake(170, 70, 100, 30);
    _SJLable.frame = CGRectMake(250, 40, 100, 30);
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
