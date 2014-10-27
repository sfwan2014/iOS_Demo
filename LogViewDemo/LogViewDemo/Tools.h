//
//  Tools.h
//  LogViewDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDefaultCellHeight      105
#define kLabelDefaultWidth      198
#define kSpaceWidth             45
#define kSpaceHeight            20
#define kLeftWidth              33
#define kRightWidth             32

#define kAnswerPrefix       @"answer_prefix"
#define kQuestionPrefix       @"question_prefix"

@interface Tools : NSObject
+ (NSString *)handleContent:(NSString *)content;
+(CGFloat) cellHeightFromContent:(NSString *)content;

+ (CGFloat) heightFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font;
+ (CGFloat) widthFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font;

+ (CGSize) sizeFromContent:(NSString *)content labelWidth:(CGFloat)width font:(UIFont *)font;

@end
