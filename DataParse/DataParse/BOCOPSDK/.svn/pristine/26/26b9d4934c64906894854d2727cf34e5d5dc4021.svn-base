//
//  NSString+ITTAdditions.m
//
//  Created by Jack on 11-9-19.
//  Copyright (c) 2011年 iTotem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "UIFont+BOCOPAdditions.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (BOCOPAdditions)

- (NSInteger)numberOfLinesWithFont:(UIFont*)font
                     withLineWidth:(NSInteger)lineWidth{
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(lineWidth, CGFLOAT_MAX)
                       lineBreakMode:NSLineBreakByTruncatingTail];
	NSInteger lines = size.height / [font ittLineHeight];
	return lines;
}
- (CGFloat)heightWithFont:(UIFont*)font
            withLineWidth:(NSInteger)lineWidth{
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(lineWidth, CGFLOAT_MAX)
                       lineBreakMode:NSLineBreakByTruncatingTail];
	return size.height;
	
}

- (NSString *)md5{
	const char *concat_str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++){
		[hash appendFormat:@"%02X", result[i]];
	}
	return [hash lowercaseString];        
}

- (BOOL)isStartWithString:(NSString*)start
{
    BOOL result = FALSE;
    NSRange found = [self rangeOfString:start options:NSCaseInsensitiveSearch];
    if (found.location == 0)
    {
        result = TRUE;
    }
    return result;
}

- (BOOL)isEndWithString:(NSString*)end
{
    NSInteger endLen = [end length];
    NSInteger len = [self length];
    BOOL result = TRUE;
    if (endLen <= len) {
        NSInteger index = len - 1;
        for (NSInteger i = endLen - 1; i >= 0; i--) {
            if ([end characterAtIndex:i] != [self characterAtIndex:index]) {
                result = FALSE;
                break;
            }
            index--;
        }
    }
    else {
        result = FALSE;
    }
    return result;
}


+(NSString*)changeStr:(NSString *)str
{
    str = [str substringFromIndex:1];  
    str = [NSString stringWithFormat:@"%f",[str floatValue]/100];
    if ([str hasPrefix:@"0.00"]) {
        return @"0.00";
    }
    
    NSString *formattedNumberString;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    [numberFormatter release];
    return formattedNumberString;
}


+(NSString*)strmethodComma:(NSString*)string
{
    
    string = [NSString strmethod:string];
    NSString *sign = nil;
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        sign = [string substringToIndex:1];
        string = [string substringFromIndex:1];
    }
    
    NSString *pointLast = [string substringFromIndex:[string length]-3];
    NSString *pointFront = [string substringToIndex:[string length]-3];
    
    int commaNum = ([pointFront length]-1)/3;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < commaNum+1; i++) {
        int index = [pointFront length] - (i+1)*3;
        int leng = 3;
        if(index < 0)
        {
            leng = 3+index;
            index = 0;
            
        }
        NSRange range = {index,leng};
        NSString *stq = [pointFront substringWithRange:range];
        [arr addObject:stq];
    }
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = [arr count]-1; i>=0; i--) {
        
        [arr2 addObject:arr[i]];
    }
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    if (sign) {
        commaString = [sign stringByAppendingString:commaString];
    }
    return commaString;

}

+(NSString *)strmethod:(NSString*)string
{
    if ([string hasPrefix:@"+"] || [string hasPrefix:@"-"]) {
        double completeStr = [string doubleValue]/100;
        return [NSString stringWithFormat:@"%.2f",completeStr];
    }else
    {
        NSString *preStr        = [[string substringToIndex:[string length] - 2] isEqualToString:@""]?@"0":[string substringToIndex:[string length] - 2];
        NSString *backStr       = [string substringFromIndex:[string length] - 2];
        
        for (int index = 0; index < [preStr length]; index++) {
            if ([[preStr substringToIndex:1] compare:@"0"] == NSOrderedSame) {
                preStr = [preStr substringFromIndex:1];
                index = 0;
            }
            else
                break;
        }
        
        NSString *completeStr   = [NSString stringWithFormat:@"%@.%@",preStr,backStr];
        return completeStr;
    }
}

+(NSString*)limitStrMethod:(NSString*)string
{
    NSString *preStr        = [string substringToIndex:[string length] - 2];
//    NSString *backStr       = [string substringFromIndex:[string length] - 2];
    
    for (int index = 0; index < [preStr length]; index++) {
        if ([[preStr substringToIndex:1] compare:@"0"] == NSOrderedSame) {
            preStr = [preStr substringFromIndex:1];
            index = 0;
        }
        else
            break;
    }
    
    NSString *completeStr   = [NSString stringWithFormat:@"%@",preStr];
    return completeStr;
}
+(NSString*)normalNumToBankNum:(NSString*)normalString
{
    int size=(normalString.length/4);
    NSMutableArray *temStrArr=[[NSMutableArray alloc] init];
    for (int n=0; n<size; n++) {
        [temStrArr addObject:[normalString substringWithRange:NSMakeRange(n*4,4)]];
    }
    [temStrArr addObject:[normalString substringWithRange:NSMakeRange(size*4, (normalString.length % 4))]];
    normalString=[temStrArr componentsJoinedByString:@" "];
    [temStrArr release];
    return normalString;
}
+(NSMutableString*)phoneChange:(NSString*)phoneNum
{
    NSMutableString *newPhone = [NSMutableString stringWithFormat:@"%@",phoneNum];
    
    [newPhone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return newPhone;
}
@end

