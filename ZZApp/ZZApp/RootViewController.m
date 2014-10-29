//
//  RootViewController.m
//  ZZApp
//
//  Created by shaofa on 14-4-30.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sendAction:(id)sender {
    if (_textField.text.length > 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input.js" ofType:nil];
        NSString *jsString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *str = [NSString stringWithFormat:@"%@  sendMessage(\"%@\")", jsString, _textField.text];
        
        [self.webView stringByEvaluatingJavaScriptFromString:str];
//        NSString *str = [NSString stringWithFormat:@"receiveMessageToHTML(OC,%@)", _textField.text];
//        [self.webView stringByEvaluatingJavaScriptFromString:st];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSDemo005" ofType:@"html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *url = [[NSBundle mainBundle] resourceURL];
    [_webView loadHTMLString:htmlString baseURL:url];
    _webView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    id result = [webView stringByEvaluatingJavaScriptFromString:@"sendMessageToOC()"];
    NSLog(@"%@", result);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
