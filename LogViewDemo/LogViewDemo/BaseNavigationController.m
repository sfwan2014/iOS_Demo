//
//  BaseNavigationController.m
//  Bandit-Client
//
//  Created by dajun on 14-4-6.
//  Copyright (c) 2014年 dajun. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController (Retro)

- (void)pushViewControllerRetro:(UIViewController *)viewController;
- (void)popViewControllerRetro;

@end

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationBar setTitleTextAttributes:@{UITextAttributeFont:[UIFont boldSystemFontOfSize:18], UITextAttributeTextColor:[UIColor whiteColor]}];
    // 5.0之后调用
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        if(ABOVE_IOS7)
        {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_title_back.png"] forBarMetrics:UIBarMetricsDefault];
        }

    }
}

- (void)pushViewControllerRetro:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:viewController animated:NO];
}

- (void)popViewControllerRetro {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

@implementation UINavigationBar (customBackground)

- (void)drawRect:(CGRect)rect
{
    UIImage *img = [UIImage imageNamed:@"nav_bg_all"];
    [img drawInRect:rect];
}

@end