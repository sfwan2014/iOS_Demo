//
//  SFAnotationModel.m
//  MapDemo
//
//  Created by sfwan on 14-9-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "SFAnotationModel.h"

@implementation SFAnotationModel
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
    }
    
    return self;
}

@end
