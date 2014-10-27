//
//  WebViewController.m
//  WebViewJavascriptDemo
//
//  Created by shaofa on 14-4-2.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *javascriptBridge;

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:appHtml baseURL:nil];
    
    [self _initView];
}

-(void)_initView
{
    [WebViewJavascriptBridge enableLogging];
    
    _javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@", data);
        responseCallback(@"OC 回调");
    }];
    
    [_javascriptBridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@", data);
        responseCallback(@"OC 某名称的 回调");
    }];
    
    [_javascriptBridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
        NSLog(@"objc got response! %@", responseData);
    }];
    
    [_javascriptBridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
    [_javascriptBridge send:@"A string sent from ObjC after Webview has loaded."];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(id)sender {
    
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_javascriptBridge send:data responseCallback:^(id responseData) {
        NSLog(@"%@", responseData);
    }];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

@end
