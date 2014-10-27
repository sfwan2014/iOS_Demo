//
//  NSDate+ITTAdditions.h
//
//  Created by guo hua on 11-9-19.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate(BOCOPAdditions)
+ (NSString *)timeStringWithInterval:(NSTimeInterval) time;
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate;
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval;

- (NSString *)stringWithSeperator:(NSString *)seperator;
- (NSString *)stringWithFormat:(NSString*)format;
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear;
- (NSDate *)relativedDateWithInterval:(NSInteger)interval ;
- (NSString *)weekday;
@end