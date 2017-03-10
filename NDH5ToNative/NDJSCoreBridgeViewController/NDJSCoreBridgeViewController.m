//
//  NDJSCoreBridgeViewController.m
//  NDH5ToNative
//
//  Created by NDMAC on 16/3/14.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDJSCoreBridgeViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface NDJSCoreBridgeViewController () <UIWebViewDelegate>

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation NDJSCoreBridgeViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self nd_configWebView];
}

#pragma mark - private

- (void)nd_configWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    web.frame = CGRectMake(0,64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64) ;
    web.delegate = self;
    [self.view addSubview:web];
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"NDJSCoreBridgeIndex" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [web loadHTMLString:appHtml baseURL:baseURL];
}

#pragma mark - delegate

#pragma mark -- UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!self.jsContext)
    {
        self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        /// 关联打印异常
        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
        };
        
        self.jsContext[@"jsBack"] = ^(NSDictionary *param) {
            NSLog(@"%@",param);
            if (!param)
            {
                NSLog(@"no message");
                return ;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:param[@"message"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
#pragma clang diagnostic pop
                [alert show];
            });
        };
    }
}

@end
