//
//  SJSectionHeaderView.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/30.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJSectionHeaderView.h"
#import "SJFriendGroup.h"
@interface SJSectionHeaderView ()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UILabel *label;
@end

@implementation SJSectionHeaderView

static NSString *headerViewIdentifier = @"headerView";
+(instancetype)headerViewWithTableView:(UITableView *)tableView
{
    SJSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[SJSectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
        
    }
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
   
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgBtn];
        
       
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        UIImage *highLightedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bgBtn setBackgroundImage:highLightedImage forState:UIControlStateHighlighted];
        
       
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
       
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
        
        bgBtn.imageView.clipsToBounds = NO;
        
        [bgBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
       
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
       
        label.textAlignment = NSTextAlignmentRight;
        
        _bgBtn = bgBtn;
        _label = label;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _bgBtn.frame = self.bounds;
    
    
    CGFloat labelW = 100;
    CGFloat labelH = self.bounds.size.height;
    CGFloat labelX = self.bounds.size.width - labelW - 10;
    CGFloat labelY = 0;
    
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}


-(void)bgBtnClick:(UIButton *)btn
{
    
    if (_friendGroup.isOpen) {
        _friendGroup.isOpen = NO;
        
    }else{
        _friendGroup.isOpen = YES;
    }
    
   
    if (_headerViewClick) {
        _headerViewClick();
    }
}


-(void)setFriendGroup:(SJFriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    
 
    [_bgBtn setTitle:friendGroup.name forState:UIControlStateNormal];
    _label.text = [NSString stringWithFormat:@"%ld/%lu",(long)friendGroup.online,(unsigned long)friendGroup.friends.count];
    
    
    if (!_friendGroup.isOpen) {
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }else{
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

@end
