//
//  Model.m
//  TableDemo
//
//  Created by xxx on 14-3-12.
//  Copyright (c) 2014年 xxxx. All rights reserved.
//

#import "Model.h"


@implementation Model

@dynamic typeName;
@dynamic clsName;
@dynamic iDMCC;
@dynamic shopType;
@dynamic rate;

-(Model *)modelFromModel:(Model *)model
{
    self.iDMCC = model.iDMCC;
    self.typeName = model.typeName;
    self.clsName = model.clsName;
    self.shopType = model.shopType;
    self.rate = model.rate;
    
    return self;
}

@end
