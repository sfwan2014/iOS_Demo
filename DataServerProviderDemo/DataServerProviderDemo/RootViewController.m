//
//  RootViewController.m
//  DataServerProviderDemo
//
//  Created by sfwan on 14-7-2.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "MyDataProvider.h"

@interface RootViewController ()<ProviderDelegate>

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    MyDataProvider *provider = [[MyDataProvider alloc] initWithDelegate:self];
    [provider setRequestMethod:@"GET" params:nil];
    [provider query];
}

-(void)requestFinish:(HJServerProvider *)provider result:(id)result
{
    
}

-(void)requestFaild:(HJServerProvider *)provider error:(NSError *)error
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
