//
//  BOCOPDataRequest.h
//  
//  Based on OAuth 2.0
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
	BOCOPHttpRequestMethodGet = 0,
	BOCOPHttpRequestMethodPost = 1,
	BOCOPHttpRequestMethodPut = 2,
    BOCOPHttpRequestMethodDelete = 3
} BOCOPHttpRequestMethod;

@interface BOCOPByteDataRequest : NSObject

@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, retain) NSDictionary *headers;
@property (nonatomic, retain) NSString *postJSON;
@property (nonatomic, retain) NSString *Cookie;

+ (id)requestWithParams:(NSDictionary *)params
            headers:(NSDictionary*)headers;

+ (id)requestWithHeaders:(NSDictionary*)headers;

+ (id)requestWithParams:(NSDictionary *)params;

- (void)connect;
- (void)disconnect;

- (void)onRequestFailWithError:(void (^)(NSError *error))onRequestFailWithError;
- (void)onRequestDidFinishLoadingWithResult:(void (^)(NSString *result))onRequestDidFinishLoadingWithResult;

#pragma mark - hook methods
- (NSString*)getURLString;
- (BOCOPHttpRequestMethod)getHttpMethod;
@end
