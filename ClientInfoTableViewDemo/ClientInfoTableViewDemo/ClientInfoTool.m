//
//  ClientInfoTool.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientInfoTool.h"
#define kDefalutSpaceHeight     10

@implementation ClientInfoTool
+(CGFloat)cellHeightForContent:(NSDictionary *)dic
{
    CGFloat height = 0;
    // 文字高度
    NSDictionary *thing = dic[@"thing"];
    NSString *text = thing[@"content"];
    CGSize size = [self sizeWithContentStr:text fontSize:kDefaultContentFontSize];
    height += size.height;
    
    // 上下缝隙高度
    height += kDefalutSpaceHeight;
    
    // 备忘时间高度
    height += kDefaultTimeLabelHeight;
    
    // 提醒视图高度
    BOOL clock = [dic[@"clock"] boolValue];
    if (clock) {
        height += kDefaultCloclViewHeight;
    }
    
    return height;
}

+(CGSize)sizeWithContentStr:(NSString *)text fontSize:(CGFloat)fontSize
{
    return [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(kDefaultContentLabelWidth, 1000)];
}

@end
