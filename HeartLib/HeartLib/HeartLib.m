//
//  HeartLib.m
//  HeartLib
//
//  Created by shaofa on 14-1-22.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "HeartLib.h"
#import <CommonCrypto/CommonCryptor.h>
#import "CommonCrypto/CommonDigest.h"

#define kSecretKey  @"123456"

@implementation HeartLib

+(NSString *) md5: (NSString *) inPutText
{
    NSString *text = [NSString stringWithFormat:@"%@%@", inPutText, kSecretKey];
    const char *cStr = [text UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


@end
