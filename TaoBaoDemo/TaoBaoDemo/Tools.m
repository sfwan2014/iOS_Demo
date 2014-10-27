//
//  Tools.m
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonCryptor.h>
#import "CommonCrypto/CommonDigest.h"

@implementation Tools

+(NSString *) md5: (NSString *) inPutText
{
    NSString *text = [NSString stringWithFormat:@"%@%@", inPutText, App_Key];
    const char *cStr = [text UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+(NSString *)sortParams:(NSMutableDictionary *)params
{
    
    NSArray *allKeys = [params allKeys];
    allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in allKeys) {
        NSString *value = [params objectForKey:key];
        [result appendFormat:@"%@%@", key, value];
    }
    
    return result;
}

//+(id)requestWithURL:(NSString *)url httpMethod:(NSString *)httpMethod params:(NSMutableDictionary *)params finishBlock:(CompletionBlock)block
//{
//    NSMutableString *urlstring = [NSMutableString stringWithFormat:@"%@/%@", BASE_URL_TEST, url];
//    if ([httpMethod isEqualToString:@"GET"]) {
//        [urlstring appendString:@"?"];
//        
//        NSArray *allKeys = [params allKeys];
//        for (int i = 0; i < allKeys.count; i++) {
//            NSString *key = allKeys[i];
//            NSString *value = params[key];
//            [urlstring appendFormat:@"%@=%@", key, value];
//            if (i < allKeys.count-1) {
//                [urlstring appendString:@"&"];
//            }
//        }
//    }
//    NSLog(@"%@", urlstring);
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
//    [request setTimeoutInterval:60];
//    [request setHTTPMethod:httpMethod];
//    
//    if ([httpMethod isEqualToString:@"POST"]) {
//        
//        NSArray *allKeys = [params allKeys];
//        NSMutableString *postString = [NSMutableString string];
//        for (NSString *key  in allKeys) {
//            id value = params[key];
//            
//            [postString appendFormat:@"%@=%@&", key, value];
//        }
//        NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:postData];
//    }
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////        id result = [jsonString JSONValue];
//        NSLog(@"%@", result);
//        
//        NSString *error = nil;
//        if (connectionError != nil) {
//            error = @"请求超时";
//        }
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            block(result, error);
//        });
//    }];
//    
//    return request;
//    
//}

@end
