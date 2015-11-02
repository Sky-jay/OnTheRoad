//
//  SJPhotoAlbumViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/10/31.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SJPhotoAlbumViewController.h"
#import "SJPhotoAlbumScrollView.h"

@interface SJPhotoAlbumViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SJPhotoAlbumViewController

#define SJScreenW [UIScreen mainScreen].bounds.size.width
#define SJScreenH [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addSubViewForScrollView];

}

-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SJScreenW + 25, SJScreenH)];
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake((SJScreenW + 25) * 3, SJScreenH);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    _scrollView.backgroundColor = [UIColor blackColor];
    
}

-(void)addSubViewForScrollView
{
    for (int i = 0; i < 3; i++) {
        
        SJPhotoAlbumScrollView *sjScrollView = [[SJPhotoAlbumScrollView alloc] initWithFrame:CGRectMake((SJScreenW + 25) * i, 0, SJScreenW, SJScreenH)];
        [_scrollView addSubview:sjScrollView];
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];

        sjScrollView.img = [UIImage imageNamed:imageName];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (id scroll in scrollView.subviews) {

        if ([scroll isKindOfClass:[SJPhotoAlbumScrollView class]]) {
            SJPhotoAlbumScrollView *sjScrollView = (SJPhotoAlbumScrollView *)scroll;

            sjScrollView.zoomScale = 1.0;
        }
    }
}

@end
