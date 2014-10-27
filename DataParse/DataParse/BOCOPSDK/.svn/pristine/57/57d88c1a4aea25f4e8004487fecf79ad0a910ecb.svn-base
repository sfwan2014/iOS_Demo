//
//  BOCPayRequestManager.m
//  
//
//  Created by Jack Lian on 01/16/13.
//  Copyright (c) 2012 BOC. All rights reserved.
//

#import "BOCOPRequestManager.h"
#import "BOCOPObjectSingleton.h"
#import "BOCOPDataRequest.h"

@interface BOCOPRequestManager()
- (void)restore;
@end

@implementation BOCOPRequestManager
BOCOPOBJECT_SINGLETON_BOILERPLATE(BOCOPRequestManager, sharedManager)
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

- (void)addRequest:(BOCOPDataRequest*)request{
    [_requests addObject:request];
}
- (void)removeRequest:(BOCOPDataRequest*)request{
    [_requests removeObject:request];
}
- (void)cleanAllRequest
{
    
    //NSArray *requestArr = [NSArray arrayWithArray:_requests];
    
    for (int i=0; i<_requests.count; i++) {
        BOCOPDataRequest *req = [_requests objectAtIndex:i];
        [req disconnect];
    }
    
    for (BOCOPDataRequest *dataRequest in _requests) {
        if (dataRequest) {
            [dataRequest disconnect];
        }
    }
}
@end
