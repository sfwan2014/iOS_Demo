//
//  AccessLoginMcisDataRequest.m
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import "AccessLoginMcisDataRequest.h"
#import "BOCOPConstants.h"

@implementation AccessLoginMcisDataRequest

- (NSString *)getURLString
{
    return BOCOP_LOGIN_MCIS;
}

- (BOCOPHttpRequestMethod)getHttpMethod
{
    return BOCOPHttpRequestMethodPost;
}

@end
