//
//  AccessUnloginMcisDataRequest.m
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import "AccessUnloginMcisDataRequest.h"
#import "BOCOPConstants.h"

@implementation AccessUnloginMcisDataRequest

- (NSString *)getURLString
{
    return BOCOP_UNLOGIN_MCIS;
}

- (BOCOPHttpRequestMethod)getHttpMethod
{
    return BOCOPHttpRequestMethodPost;
}

@end
