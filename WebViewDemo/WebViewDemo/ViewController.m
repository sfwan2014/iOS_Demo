//
//  ViewController.m
//  WebViewDemo
//
//  Created by shaofa on 14-1-26.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController
{
    UIWebView *_webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scalesPageToFit = NO;
    NSString *urlstring = @"http://m.anxin.com/activity/zhongqiu2014/338?pl=3&shpl=6";
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", str);
//    }];
    
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSURL *url = request.URL;
//    NSString *urlstring = @"http://m.anxin.com/activity/zhongqiu2014/338?pl=3&shpl=6";
//    NSURL *url = [NSURL URLWithString:urlstring];
//    NSURLRequest *requests = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:requests];
//    NSLog(@"%@", url);
    
    return  YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newslist.js" ofType:nil];
//    // 如果jsString 为nil， 说明newslist.js 文件不在 Build Phases --> Copy Bundle Resources中， 需要手动添加进去
//    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    
//    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
//      "script.type = 'text/javascript';"
//      "script.text = %@", jsString]];
    
//    NSString *message = @"菜鸟";
//    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"self.onload('%@')", message]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
