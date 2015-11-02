//
//  SJPhotoAlbumScrollView.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/31.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJPhotoAlbumScrollView.h"

@interface SJPhotoAlbumScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imgView;
@end
@implementation SJPhotoAlbumScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imgView = imageView;

        self.maximumZoomScale = 2;
        self.minimumZoomScale = 0.5;
        self.delegate = self;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];

        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)doubleClick:(UITapGestureRecognizer *)tap
{
    if (self.zoomScale != 1.0) {
        self.zoomScale = 1.0;
        return;
    }

    CGPoint location = [tap locationInView:self];
    
    CGRect rect = CGRectMake(location.x - 100, location.y - 100, 200, 200);
    
    [self zoomToRect:rect animated:YES];
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
