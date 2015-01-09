//
//  NSString+MD5.m
//  FinancialIPAD
//
//  Created by zsc on 13-10-14.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "UUIDHelper.h"

@implementation NSString (MD5)

//MD5 加密   -added by zsc
-(NSString *) md5HexDigest{
    NSString *header = [UUIDHelper getUUID];
    NSString * contentStr = self;
    NSString *tail = @"LCZX";
    NSMutableString * str = [[NSMutableString alloc] init];
    [str appendString:header];
    [str appendString:contentStr];
    [str appendString:tail];
    
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%X", result[i]];
    return [hash uppercaseString];
}

@end
