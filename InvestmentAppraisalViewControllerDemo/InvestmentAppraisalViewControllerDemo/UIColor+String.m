//
//  UIColor+String.m
//  InvestmentAppraisalViewControllerDemo
//
//  Created by sfwan on 14-12-16.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "UIColor+String.h"
int convertToInt(char c)
{
    if (c >= '0' && c <= '9') {
        return c - '0';
    } else if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    } else if (c >= 'A' && c <= 'F') {
        return c - 'A' + 10;
    } else {
        return printf("字符非法!");
    }
}
@implementation UIColor (String)
+ (UIColor *)colorWithString:(NSString *)name
{
    if (![[name substringToIndex:0] isEqualToString:@"#"] && name.length < 7) {
        return nil;
    }
    const char *str = [[name substringWithRange:NSMakeRange(1, 6)] UTF8String];
    NSString *alphaString = [name substringFromIndex:7];
    CGFloat red = (convertToInt(str[0])*16 + convertToInt(str[1])) / 255.0f;
    CGFloat green = (convertToInt(str[2])*16 + convertToInt(str[3])) / 255.0f;
    CGFloat blue = (convertToInt(str[4])*16 + convertToInt(str[5])) / 255.0f;
    CGFloat alpha = [alphaString isEqualToString:@""] ? 1 : alphaString.floatValue/255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
