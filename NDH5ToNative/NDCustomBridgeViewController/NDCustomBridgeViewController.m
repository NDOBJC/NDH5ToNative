//
//  NDCustomBridgeViewController.m
//  NDH5ToNative
//
//  Created by NDMAC on 16/3/8.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDCustomBridgeViewController.h"

@interface NDCustomBridgeViewController () <UIWebViewDelegate>

@end

@implementation NDCustomBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWebView];
}

#pragma mark - private

- (void)configWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    web.frame = CGRectMake(0,64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64) ;
    web.delegate = self;
    [self.view addSubview:web];
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"NDCustomBridgeIndex" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [web loadHTMLString:appHtml baseURL:baseURL];
}

#pragma mark - delegate

#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString containsString:@"jsBack"]) {
        ///获取到请求的 url中传回的信息 包含 jsBack 则返回上一级
        [self.navigationController popViewControllerAnimated:YES];
        ///不发起请求
         return NO;
    }
    return YES;
}

@end
