//
//  CustomTabBarViewController.m
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "CustomTabBarItem.h"
#import "CustomNavigationController.h"

@interface CustomTabBarViewController ()<UINavigationControllerDelegate>

@end

@implementation CustomTabBarViewController
{
    UIView *_customTabBar;
    UIImageView *_selectView;
}

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
    
    [self _loadTabBarItems];
    
    [self _loadSubControllers];
}

-(void)_loadTabBarItems
{
    self.tabBar.hidden = YES;
    
    _customTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight, kScreenWidth, kTabBarHeight)];
    _customTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_back.png"]];
    
    NSArray *btnImgNames = @[@"tab_item.png", @"tab_item.png", @"tab_item.png", @"tab_item.png" ];
    NSArray *btnTitleNames = @[@"1234",@"2345",@"2345",@"2345",@"2345"];
    
    CGFloat width = kScreenWidth/btnImgNames.count;
    CGRect frame = CGRectMake(0, 0, width, kTabBarHeight);
    for (int i = 0; i < btnImgNames.count; i++) {
        
        frame.origin.x = i*width;
        
        UIImage *image = [UIImage imageNamed:btnImgNames[i]];
        NSString *title = btnTitleNames[i];
        CustomTabBarItem *item = [[CustomTabBarItem alloc] initWithFrame:frame target:self action:@selector(itemClickAction:) type:UIButtonTypeCustom title:title normImage:image selectedImage:nil];
        
        item.alpha = 0.5;
        item.tag = i;
        
        [_customTabBar addSubview:item];
    }
    
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, kTabBarHeight)];
//    _selectView.image = [UIImage imageNamed:btnTitleNames[0]];
    _selectView.backgroundColor = [UIColor cyanColor];
    _selectView.alpha = 0.5;
    [_customTabBar addSubview:_selectView];
    
    [self.view addSubview:_customTabBar];
}

-(NSArray *)viewControllersName{
    return @[@"HomeViewController", @"HomeViewController", @"HomeViewController", @"HomeViewController"];
}

-(void)_loadSubControllers
{
    NSMutableArray *viewcontrollers = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < self.viewControllersName.count; i++) {
        UIViewController * controller = [[NSClassFromString(self.self.viewControllersName[i]) alloc] init];
        controller.title = [NSString stringWithFormat:@"title--%d", i];
        CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:controller];
        nav.delegate = self;
        [viewcontrollers addObject:nav];
    }
    
    self.viewControllers = viewcontrollers;
}

-(void)hideTabBar:(BOOL)animation
{
    CGRect frame = _customTabBar.frame;
    frame.origin.y = kScreenHeight;
    if (animation) {
        [UIView animateWithDuration:0.35 animations:^{
            _customTabBar.frame = frame;
        }];
    } else {
        _customTabBar.frame = frame;
    }
}

-(void)showTabBar:(BOOL)animation
{
    CGRect frame = _customTabBar.frame;
    frame.origin.y = kScreenHeight-kTabBarHeight;
    if (animation) {
        [UIView animateWithDuration:0.35 animations:^{
            _customTabBar.frame = frame;
        }];
    } else {
        _customTabBar.frame = frame;
    }
}

-(void)itemClickAction:(UIButton *)button
{
    [UIView animateWithDuration:0.35 animations:^{
        _selectView.center = button.center;
    }];
    self.selectedIndex = button.tag;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 是否隐藏tabbar
    NSArray *viewControllers = navigationController.viewControllers;
    int count = viewControllers.count;
    if (count <= 1) {
        [self showTabBar:YES];
    } else {
        [self hideTabBar:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
