//
//  ClientInfoTool.h
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultContentFontSize     14
#define kDefaultBackCellHeight      120
#define kDefaultInfoCellHeight      44
#define kDefaultContentLabelWidth   180
#define kDefaultTimeLabelHeight     25
#define kDefaultCloclViewHeight     30

@interface ClientInfoTool : NSObject
+(CGFloat)cellHeightForContent:(NSDictionary *)dic;
+(CGSize)sizeWithContentStr:(NSString *)text fontSize:(CGFloat)fontSize;
@end
