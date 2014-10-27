//
//  SecondViewController.m
//  htmlTest
//
//  Created by shaofa on 14-1-6.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "SecondViewController.h"
#define JsStr @"var MyContent= {}; (function initialize() {alert('调用2'); MyContent.getContent = function () {alert('调用3'); return '%@'; };})();"
#define BASEURL [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]

@interface SecondViewController ()<UIWebViewDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    NSString *basePath = [ [[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"trunt/html"];
    //
    //    NSString *filePath =[NSString stringWithFormat:@"%@/%@", basePath,@"jiaoyikaihu.html"];
    //
    //    NSString *html = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //
    //    NSURL *baseURL = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"trunt/html"]];
    
    NSURL *url = [NSURL URLWithString:@"https://kyfw.12306.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:request];
    webView.delegate = self;
    //    [webView loadHTMLString:html baseURL:baseURL];
    
    [self.view addSubview:webView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL *url = request.URL;
    NSString *absoluteString = [url absoluteString];
    NSLog(@"absoluteString %@", absoluteString);
    
//    // 返回登录前页面
//    if ([absoluteString hasSuffix:@"dengluqian.html"]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        return NO;
//    }
//    
//    //返回 或登出
//    if ([absoluteString hasSuffix:@"cancel"]) {// 登出
//        
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        return NO;
//    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSString *js = [NSString stringWithFormat:JsStr, @"ios"];
//    [webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
