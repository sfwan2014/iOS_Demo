//
//  AccessUnloginMcisCspDataRequest.m
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import "AccessUnloginMcisCspDataRequest.h"
#import "BOCOPConstants.h"

@implementation AccessUnloginMcisCspDataRequest

- (NSString *)getURLString
{
    return BOCOP_UNLOGIN_MCISCSP;
}

- (BOCOPHttpRequestMethod)getHttpMethod
{
    return BOCOPHttpRequestMethodPost;
}

@end
