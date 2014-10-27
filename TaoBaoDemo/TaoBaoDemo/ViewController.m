//
//  ViewController.m
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "TaoBaoLoginView.h"
#import "Tools.h"

/*
 h1ttp://gw.api.taobao.com/router/rest?sign=5819C32FDF85F8C43DA2534C273C6E56&timestamp=2014-02-11+17%3A40%3A24&v=2.0&app_key=12129701&method=tmall.items.discount.search&partner_id=top-apitools&format=json&cat=12313&q=qq
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TaoBaoLoginView *loginView = [[TaoBaoLoginView alloc] initWithFrame:self.view.bounds];
    
    __block ViewController *this = self;
    loginView.block = ^(TaoBaoLoginView *view){
        if (view.superview != nil) {
            [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3];
            ViewController *strong = this;
            [strong didLogin];
        }
    };
    [self.view addSubview:loginView];
    
}

-(void)didLogin
{
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.text = [userInfo objectForKey:@"taobao_user_nick"];
    [self.view addSubview:label];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd+HH:mm:ss";
    NSString *timestamp = [formatter stringFromDate:date];
    [params setObject:timestamp forKey:@"timestamp"];
    
    [params setObject:@"1.0" forKey:@"v"];
    [params setObject:App_Key forKey:@"app_key"];
    [params setObject:@"tmall.items.discount.search" forKey:@"method"];
    [params setObject:@"top-apitools" forKey:@"partner_id"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:@"123" forKey:@"cat"];
    [params setObject:@"qq" forKey:@"q"];
    
    NSString *text = [Tools sortParams:params];
    NSString *sign = [Tools md5:text];
    
    [params setObject:sign forKey:@"sign"];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
