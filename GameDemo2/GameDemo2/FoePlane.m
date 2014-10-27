//
//  FoePlane.m
//  GameDemo2
//
//  Created by shaofa on 14-3-15.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "FoePlane.h"
#import "ShareAtlas.h"

@implementation FoePlane

+(instancetype)createBigPlane
{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeBigFoePlane]];
    foePlane.hp = 7;
    foePlane.type = FoePlaneTypeBig;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    
    return foePlane;
}

+(instancetype)createMediumPlane
{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeMediumFoePlane]];
    foePlane.hp = 5;
    foePlane.type = FoePlaneTypeMedium;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    
    return foePlane;
}

+(instancetype)createSmallPlane
{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeSmallFoePlane]];
    foePlane.hp = 1;
    foePlane.type = FoePlaneTypeSmall;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    
    return foePlane;
}

@end
