//
//  HJCFUtils.h
//  HJCFHUDDemo
//
//  Created by sfwan on 14-7-3.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJCFProgressView.h"

typedef enum : NSUInteger {
    kErrorCodeTypeNoNet =12580,
    kErrorCodeTypeOutTime,
    kErrorCodeTypeSystError,
    kErrorCodeTypeNone,
} kErrorCodeType;

@interface HJCFUtils : NSObject
+(void)showHUBToView:(UIView *)view;
+(void)showHUBToView:(UIView *)view withMsg:(NSString *)message;
+(void)hideHUBFromView:(UIView *)view;
+(void)showSucceedToView:(UIView *)view;
+(HJCFProgressView *)showProgressViewToView:(UIView *)view;
+(void)SHowErrorMessage:(NSError *)error;

@end
