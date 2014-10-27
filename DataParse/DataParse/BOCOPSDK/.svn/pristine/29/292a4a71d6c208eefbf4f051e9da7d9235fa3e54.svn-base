//
//  BOCPayRequestManager.m
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import "BOCOPByteRequestManager.h"
#import "BOCOPObjectSingleton.h"
#import "BOCOPByteDataRequest.h"

@interface BOCOPByteRequestManager()
- (void)restore;
@end

@implementation BOCOPByteRequestManager
BOCOPOBJECT_SINGLETON_BOILERPLATE(BOCOPByteRequestManager, sharedManager)
- (id)init{
    self = [super init];
    if(self){
        [self restore];
    }
    return self;
}

- (void)dealloc{
    [_requests release];
    _requests = nil;
    [super dealloc];
}

#pragma mark - private methods
- (void)restore{
    [_requests release];
    _requests = nil;
    _requests = [[NSMutableArray alloc] init];
}

#pragma mark - public methods

- (void)addRequest:(BOCOPByteDataRequest*)request{
    [_requests addObject:request];
}

- (void)removeRequest:(BOCOPByteDataRequest*)request{
    [_requests removeObject:request];
}

- (void)cleanAllRequest
{
    //NSArray *requestArr = [NSArray arrayWithArray:_requests];
    
    for (int i=0; i<_requests.count; i++) {
        BOCOPByteDataRequest *req = [_requests objectAtIndex:i];
        [req disconnect];
    }
    
    for (BOCOPByteDataRequest *dataRequest in _requests) {
        if (dataRequest) {
            [dataRequest disconnect];
        }
    }
}
@end
