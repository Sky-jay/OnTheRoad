//
//  SJScrollView.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/31.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJScrollView.h"
@interface SJScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIImageView *imgView;
@end

@implementation SJScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imgView = imageView;
        
        self.delegate = self;
        
    }
    return self;
}

-(void)setImg:(UIImage *)img
{
    _img = img;
    
    _imgView.image = img;
}

-(void)setImage:(UIImage *)image
{
    _imgView.image = image;
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}


@end
