//
//  BaseNavigationController.h
//  Bandit-Client
//
//  Created by dajun on 14-4-6.
//  Copyright (c) 2014年 dajun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

- (void)pushViewControllerRetro:(UIViewController *)viewController;
- (void)popViewControllerRetro;

@end

@interface UINavigationBar (customBackground)

@end