//
//  BOCOPAccessDataManager.m
//  BOCOPSDK
//
//  Created by SuWang on 13-11-25.
//  Copyright (c) 2013年 SuWang. All rights reserved.
//

#import "BOCOPAccessDataManager.h"
#import "BOCOPObjectSingleton.h"

#import "AccessUnloginMcisCspDataRequest.h"
#import "AccessUnloginMcisDataRequest.h"

#import "AccessLoginMcisCspDataRequest.h"
#import "AccessLoginMcisDataRequest.h"




@implementation BOCOPAccessDataManager

BOCOPOBJECT_SINGLETON_BOILERPLATE(BOCOPAccessDataManager, sharedManager)


- (id)init{
    self = [super init];
    if(self){
        [self restore];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
}

#pragma mark - private methods
- (void)restore{
}

//分行通用接口查询(无登陆)
- (void)searchUnloginMcisCspWithRequestHeaders:(NSDictionary*)headers
                                searchCriteria:(NSString *) param
                                    onComplete:(void (^)(NSString *info))onComplete
                                       onError:(void (^)(NSError *error))onError
{
    AccessUnloginMcisCspDataRequest *request = [AccessUnloginMcisCspDataRequest requestWithHeaders:headers];
    request.postJSON = param;
    [request onRequestDidFinishLoadingWithResult:^(NSString *result) {
        if (onComplete) {
            onComplete(result);
        }
    }];
    [request onRequestFailWithError:^(NSError *error) {
        onError(error);
    }];
    [request connect];

}

//分行通用接口查询(需要登陆)
- (void)searchLoginMcisCspWithRequestHeaders:(NSDictionary *)headers
                              searchCriteria:(NSString *)param
                                  onComplete:(void (^)(NSString *info))onComplete
                                     onError:(void (^)(NSError *error))onError
{
    AccessLoginMcisCspDataRequest *request = [AccessLoginMcisCspDataRequest requestWithHeaders:headers];
    request.postJSON = param;

    [request onRequestDidFinishLoadingWithResult:^(NSString *result) {
        if (onComplete) {
            onComplete(result);
        }
    }];
    [request onRequestFailWithError:^(NSError *error) {
        onError(error);
    }];
    [request connect];

}
//总行通用接口查询(无登陆)
- (void)searchUnloginMcisWithRequestHeaders:(NSDictionary*)headers
                             searchCriteria:(NSString *) param
                                 onComplete:(void (^)(NSString *info))onComplete
                                    onError:(void (^)(NSError *error))onError
{
    AccessUnloginMcisDataRequest * request = [AccessUnloginMcisDataRequest requestWithHeaders:headers];
    request.postJSON = param;

    [request onRequestDidFinishLoadingWithResult:^(NSString *result) {
        if (onComplete) {
            onComplete(result);
        }
    }];
    [request onRequestFailWithError:^(NSError *error) {
        onError(error);
    }];
    [request connect];
}

//总行通用接口查询(需要登录)
- (void)searchLoginMcisWithRequestHeaders:(NSDictionary *)headers
                           searchCriteria:(NSString *)param
                               onComplete:(void (^)(NSString *info))onComplete
                                  onError:(void (^)(NSError *error))onError
{
    AccessUnloginMcisDataRequest *request =[AccessUnloginMcisDataRequest requestWithHeaders:headers];
    request.postJSON = param;

    [request onRequestDidFinishLoadingWithResult:^(NSString *result) {
        if (onComplete) {
            onComplete(result);
        }
    }];
    [request onRequestFailWithError:^(NSError *error) {
        onError(error);
    }];
    [request connect];
}
@end
