//
//  CustomClass.m
//  创意家居
//
//  Created by Fudongdong on 13-10-25.
//  Copyright (c) 2013年 Fudongdong. All rights reserved.
//

#import "CustomClass.h"

@implementation CustomClass

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (ASIHTTPRequest *)requestWithURL:(NSString *)url
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                      finishBlock:(FinishLoadData)block
{

    NSComparisonResult compResult1 =[httpMethod caseInsensitiveCompare:@"GET"];
    if (compResult1 == NSOrderedSame) {
        NSMutableString *paramsString = [NSMutableString string];
        
        //如果是get请求,则将参数拼接在url后面
        NSArray *allkeys = [params allKeys];
        for (int i = 0;i < [allkeys count]; i++) {
             NSString *value = [params objectForKey:allkeys[i]];
            if (i == 0) {
                [paramsString appendFormat:@"?%@=%@", allkeys[i], value];
            }else{
                [paramsString appendFormat:@"&%@=%@", allkeys[i], value];
            }
        }
        
        if (paramsString.length > 0) {
            url = [url stringByAppendingString:paramsString];
        }
    }
    
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:httpMethod];
    [request setTimeOutSeconds:20];
    
    
    //4.POST请求
    NSComparisonResult compResult2 =[httpMethod caseInsensitiveCompare:@"POST"];
    if (compResult2 == NSOrderedSame) {
        //如果是get请求,则将参数拼接在url后面
        NSArray *allkeys = [params allKeys];
        for (NSString *key in allkeys) {
            id value = [params objectForKey:key];
            
            //判断是否上传文件
            if([value isKindOfClass:[NSData class]])
            {
                [request addData:value forKey:key];
            }else{
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    //  成功block
    [request setCompletionBlock:^{
        //解析json
        NSData *responseData = request.responseData;
        id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        
        //block传值
        if(block){
            block(result);
        }
    }];
    
    //  失败block
    [request setFailedBlock:^{
        NSLog(@"请求失败:%@", request.error);
        if (block) {
            block(nil);
        }
    }];
    
    //发异步请求
    [request startSynchronous];
    
    return request;

}
@end
