//
//  WebViewController.m
//  WeChatDemo
//
//  Created by qingyun on 15/11/1.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBTN;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    
    _webView.scalesPageToFit = YES;
    [self loadReuqest];

}
- (IBAction)backBTNAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{    }];
}

-(void)loadReuqest
{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *string = @"<html><marquee><h1>对不起，链接不存在</h1></marqueea></html>";
    [webView loadHTMLString:string baseURL:nil];
}


@end
