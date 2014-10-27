//
//  Tools.m
//  LogViewDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "Tools.h"

#define kDefaultLabelHeight     10000

@implementation Tools

+ (NSString *)handleContent:(NSString *)content
{
    if ([content hasPrefix:kAnswerPrefix]) {
        content = [content substringFromIndex:kAnswerPrefix.length];
    } else if ([content hasPrefix:kQuestionPrefix]) {
        content = [content substringFromIndex:kQuestionPrefix.length];
    }
    
    return content;
}

+(CGFloat) cellHeightFromContent:(NSString *)text
{
    CGFloat height = [Tools heightFromContent:text labelWidth:kLabelDefaultWidth font:[UIFont systemFontOfSize:14]];
    height += 70;
    if (height < kDefaultCellHeight) {
        height = kDefaultCellHeight;
    }
    
    return height;
}

+ (CGFloat) heightFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font
{
    CGFloat height = 0;
    
    CGSize size = [Tools sizeFromContent:content labelWidth:width font:font];
    height += size.height;
    
    return height;
}

+ (CGFloat) widthFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font
{
    CGFloat contentWidth = 0;
    CGSize size = [Tools sizeFromContent:content labelWidth:width font:font];
    contentWidth += size.width;
    
    return contentWidth;
}

+ (CGSize) sizeFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font
{
    return [content sizeWithFont:font constrainedToSize:CGSizeMake(width, kDefaultLabelHeight)];
}

@end
