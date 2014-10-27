//
//  ViewController.m
//  WebViewTest
//
//  Created by shaofa on 14-1-14.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:Nil];
    [webView loadHTMLString:htmlString baseURL:Nil];
    //<script type="text/javascript" src="iphone.js"></script>
    
}

//webView的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    //    NSLog(@"%@", url.absoluteString);
    
    if ([url.absoluteString hasPrefix:@"click:"]) {
        [self _loadImage:url.absoluteString];
    }
    
    return YES;
}

-(void)_loadImage:(NSString *)urlstring
{
    urlstring = [urlstring substringFromIndex:6];
    //    NSLog(@"%@", urlstring);
    NSArray *urlArray = [urlstring componentsSeparatedByString:@";"];
    NSRange range = NSMakeRange(1, urlArray.count-1);
    NSArray *images = [urlArray subarrayWithRange:range];
    NSString *currentUrl = [urlArray objectAtIndex:0];
    int index = [images indexOfObject:currentUrl];
    
    NSLog(@"%d--------%@", index, currentUrl);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"iPhone.js" ofType:Nil];
    NSString *jsStr = [[NSString alloc] initWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = %@", jsStr]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"self.onload()"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
