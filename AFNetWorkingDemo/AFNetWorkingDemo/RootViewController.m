//
//  RootViewController.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
//#import "TestProvider2.h"
#import "TestProvider.h"
#import "TestModel.h"
//#import "TestModel2.h"
#import "BaseDBManager.h"
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
    
    HJServerProvider *provider = [[TestProvider alloc] initWithDelegate:self];
    [provider setRequestMethod:@"GET" params:nil];
//    [provider refresh];
    
    [provider query];
}

-(void)requestFinish:(HJServerProvider *)provider
{
    NSArray *array = provider.allDatas;
    TestModel *model = [array lastObject];
    NSArray *tags = model.tags;
    NSLog(@"%@", [tags[0] objectForKey:@"name"]);
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
