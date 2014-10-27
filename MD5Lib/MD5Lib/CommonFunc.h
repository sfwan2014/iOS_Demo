//
//  CommonFunc.h
//  CCBZZB_iPhone
//
//  Created by shaofa on 13-12-20.
//  Copyright (c) 2013年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __BASE64(text)      [CommonFunc base64StringFromText:text]
#define __TEXT(base64)      [CommonFunc textFromBase64String:base64]

@interface CommonFunc : NSObject

// 将文本转化为base64格式字符串
+(NSString *)base64StringFromText:(NSString *)text;
// 将base64格式字符串转化为文本
+(NSString *)textFromBase64String:(NSString *)base64;

+(NSString *)createReqId;

//+(NSString *)md5:(NSString *)inPutText;

+(NSMutableDictionary *)params;

//+(NSString *)verifyCode:(NSMutableDictionary *)params;

+ (long long)countDirectorySize:(NSString *)directory;

+(NSString *)currentPushId;

@end
