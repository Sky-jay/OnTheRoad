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


//设置imageView的Image
-(void)setImg:(UIImage *)img
{
    //setter方法本身要完成的事情
    _img = img;
    
    //额外完成的事情
    _imgView.image = img;
}

//方法设置
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
