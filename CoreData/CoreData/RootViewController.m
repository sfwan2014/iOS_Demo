//
//  RootViewController.m
//  CoreData
//
//  Created by shaofa on 14-5-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RootViewController.h"
#import "Person.h"

@interface RootViewController ()

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

    Person *p = [Person createModel];
    p.age = @20;
    p.name = @"jack";
    p.cdid = @"122333";
    [p savePerson];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
