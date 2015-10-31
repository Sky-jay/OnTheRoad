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
    
    //创建并添加滚动的底部的ScrollView
    [self addScrollView];
    
    //在底部的ScrollView上添加缩放的scrollView
    [self addSubViewForScrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//创建并添加滚动的底部的ScrollView
-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SJScreenW + 25, SJScreenH)];
    [self.view addSubview:scrollView];
    
    //contentSize
    scrollView.contentSize = CGSizeMake((SJScreenW + 25) * 3, SJScreenH);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    _scrollView.backgroundColor = [UIColor blackColor];
    
}
//在底部的ScrollView上添加缩放的scrollView
-(void)addSubViewForScrollView
{
    for (int i = 0; i < 3; i++) {
        
        SJPhotoAlbumScrollView *qyScrollView = [[SJPhotoAlbumScrollView alloc] initWithFrame:CGRectMake((SJScreenW + 25) * i, 0, SJScreenW, SJScreenH)];
        [_scrollView addSubview:qyScrollView];
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        //通过方法设置
        //[qyScrollView setImage:[UIImage imageNamed:imageName]];
        //通过属性设置
        qyScrollView.img = [UIImage imageNamed:imageName];
    }
}

//减速完成  把上个界面的缩放的scrollview缩放比例设置1.0
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (id scroll in scrollView.subviews) {
        //判断scroll对象是否是QYScrollView类型的
        if ([scroll isKindOfClass:[SJPhotoAlbumScrollView class]]) {
            SJPhotoAlbumScrollView *qyScrollView = (SJPhotoAlbumScrollView *)scroll;
            //设置缩放比例
            qyScrollView.zoomScale = 1.0;
        }
    }
}

@end
