//
//  CustomNavigationController.m
//  CustomTabBarControllerDemo
//
//  Created by sfwan on 14-7-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomNavigationController.h"

@interface UINavigationBar (Hide)
-(void)customSetTop;
@end

@implementation UINavigationBar (Hide)

-(void)customSetTop
{
    NSArray *array = [self.superview subviews];
    for (UIView *view in array) {
        if ([view isKindOfClass:[UINavigationBar class]]) {
            NSArray *array = [view subviews];
            for (UIView *vie in array) {
                if ([vie isKindOfClass:[NSClassFromString(@"_UINavigationBarBackground") class]]) {
                    NSArray *rr = [vie subviews];
                    for (UIView *vi in rr) {
                        if ([vi isKindOfClass:[NSClassFromString(@"_UIBarBackgroundTopCurtainView") class]]) {
                            vi.backgroundColor = [UIColor redColor];
                            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 20, 20)];
                            imageView.image = [UIImage imageNamed:@"circle1.png"];
                            [vi addSubview:imageView];
                        }
                    }
                }
            }
        }
    }
}

-(BOOL)hidden
{
    return self.hidden;
}

@end

@interface CustomNavigationController ()<UINavigationBarDelegate>

@end

@implementation CustomNavigationController

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
    
    // UIBarMetricsLandscapePhone , UIBarMetricsLandscapePhonePrompt, UIBarMetricsDefaultPrompt
    
    [self.navigationBar setBackgroundImage:self.navigationBarBackImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:self.navigationBarBackImage]];
    // 设置状态栏高亮
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationBar setTitleTextAttributes:self.textAttributes];
}


-(NSDictionary *)textAttributes
{
    NSDictionary *dic = @{UITextAttributeFont:[UIFont systemFontOfSize:20], UITextAttributeTextColor:[UIColor redColor]};
    
    return dic;
}

-(UIImage *)navigationBarBackImage
{
    UIImage *image = [UIImage imageNamed:@"navgation_tab.png"];
    return image;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self.navigationBar customSetTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
