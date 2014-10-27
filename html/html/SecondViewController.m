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
    
//    NSURL *url = [NSURL URLWithString:@"http://1.linlinyun.sinaapp.com/zzb2/newHtml/denglu.html"];
//    NSURL *url =[[NSURL alloc] initWithString:@"http://www.google.com.hk/m?gl=CN&hl=zh_CN&source=ihp"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/trunt/html/%@", [[NSBundle mainBundle] resourcePath], @"denglu.html"];
    NSString *html = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:Nil];
    NSURL *baseURL = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"trunt/html"]];
    
    [webView loadHTMLString:html baseURL:baseURL];
    
    webView.scalesPageToFit =YES;
//    [webView loadRequest:request];
    webView.delegate = self;
    
    [self.view addSubview:webView];
}


//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    return YES;
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function myFunction(str) { "
//     "var field = document.getElementsByName('q')[0];"
//     "field.value=str;"
//     "document.forms[0].submit();"
//      "alert(str);"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"myFunction('万绍发');"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"function test(){ alert(123123123); var html='string'; return html;}"];
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"test();"];//调用
    NSLog(@"-->%@", str);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
