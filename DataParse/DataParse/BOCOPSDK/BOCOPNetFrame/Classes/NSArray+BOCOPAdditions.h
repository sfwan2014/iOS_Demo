//
//  NSArray+ITTAdditions.h
//
//  Created by guo hua on 11-9-21.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(BOCOPAdditions)
/**
 判断字符是否在该数组中
 @prama [NSString] string
 return BOOL 找到返回YES 找不到返回NO
 */
-(BOOL)contentString:(NSString *)string;

/**
 判断字符在数组中哪个位置
 @prama [NSString] string
 return NSInteger 找到返回 位置,找不到返回 NSNotFound
 */
-(NSInteger)indexOfString:(NSString *)string;
@end
