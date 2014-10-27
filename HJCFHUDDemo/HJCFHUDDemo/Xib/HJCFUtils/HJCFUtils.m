//
//  HJCFUtils.m
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "HJCFUtils.h"
#import "HJCFActivityView.h"
#import "HJCFSucceedView.h"
#import "HJCFHUBBackView.h"
#import "HJCFProgressView.h"

static NSString *const AlertTitleString = @"温馨提示";

#define HJCFErrorMessageNone                @"未知错误"
#define HJCFErrorMessageNoNet               @"无网络"
#define HJCFErrorMessageOutTime             @"服务器超时"
#define HJCFErrorMessageSystError           @"系统错误"


@implementation HJCFUtils

+(void)showHUBToView:(UIView *)view
{
    [self showHUBToView:view withMsg:nil];
}

+(void)showHUBToView:(UIView *)view withMsg:(NSString *)message
{
 
    [self hideHUBFromView:view];
    
    HJCFHUBBackView *grayView = [HJCFHUBBackView loadFromNib];
    grayView.frame = view.bounds;
    [view addSubview:grayView];
    
    HJCFActivityView *HUB = [HJCFActivityView loadFromNib];
    HUB.center = grayView.center;
    HUB.msg = message;
    [view addSubview:HUB];
}

+(void)hideHUBFromView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[HJCFHUBBackView class]] || [subView isKindOfClass:[HJCFActivityView class]] || [subView isKindOfClass:[HJCFSucceedView class]] || [subView isKindOfClass:[HJCFProgressView class]]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - succeed view
+(void)showSucceedToView:(UIView *)view
{
    [self hideHUBFromView:view];
    
    HJCFHUBBackView *grayView = [HJCFHUBBackView loadFromNib];
    grayView.frame = view.bounds;
    [view addSubview:grayView];
    
    HJCFSucceedView *succeedView = [HJCFSucceedView loadFromNib];
    succeedView.center = grayView.center;
    [view addSubview:succeedView];
}

+(HJCFProgressView *)showProgressViewToView:(UIView *)view
{
    [self hideHUBFromView:view];
    
    HJCFHUBBackView *grayView = [HJCFHUBBackView loadFromNib];
    grayView.frame = view.bounds;
    [view addSubview:grayView];
    
    HJCFProgressView *progressView = [HJCFProgressView loadFromNib];
    progressView.center = grayView.center;
    progressView.progressWidth = 8;
    progressView.trackColor = [UIColor grayColor];
    progressView.progressColor = [UIColor colorWithRed:56/255.0 green:59/255.0 blue:65/255.0 alpha:0.8];
    [view addSubview:progressView];
    
    return progressView;
}

+(void)SHowErrorMessage:(NSError *)error
{
    NSInteger code = error.code;
    NSString *message = @"系统错误";
    
    switch (code) {
        case kErrorCodeTypeNone:
            message = HJCFErrorMessageNone;
            break;
        case kErrorCodeTypeNoNet:
            message = HJCFErrorMessageNoNet;
            break;
        case kErrorCodeTypeOutTime:
            message = HJCFErrorMessageOutTime;
            break;
        case kErrorCodeTypeSystError:
            message = HJCFErrorMessageSystError;
            break;
            
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlertTitleString message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
