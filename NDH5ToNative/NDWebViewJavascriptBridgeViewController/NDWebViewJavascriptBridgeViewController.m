//
//  NDWebViewJavascriptBridgeViewController.m
//  NDH5ToNative
//
//  Created by NDMAC on 16/3/8.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDWebViewJavascriptBridgeViewController.h"

#import "WebViewJavascriptBridge.h"

@interface NDWebViewJavascriptBridgeViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property WebViewJavascriptBridge* bridge;

@end

@implementation NDWebViewJavascriptBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWebView];
}

#pragma mark - private

- (void)configWebView
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"NDWebViewJavascriptBridgeIndex" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [NSURL fileURLWithPath:htmlString];
    [self.webView loadHTMLString:htmlString baseURL:url];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge registerHandler:@"CallHandlerID" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"message from H5: %@", data);
        
        //native send message to H5
        responseCallback(@"Hello H5, I am native , nice to meet you!");
    }];
}
@end
