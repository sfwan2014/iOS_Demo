//
//  ShareAtlas.h
//  GameDemo2
//
//  Created by shaofa on 14-3-15.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FoePlane.h"

typedef NS_ENUM(int, TextureType){
    TextureTypeBackground = 1,
    TextureTypeBullet = 2,
    TextureTypePlayerPlane = 3,
    TextureTypeSmallFoePlane = 4,
    TextureTypeMediumFoePlane = 5,
    TextureTypeBigFoePlane = 6,
};

@interface ShareAtlas : SKTextureAtlas

+(SKTexture *)textureWithType:(TextureType)type;
+(SKAction *)playerPlaneAction;
+(SKAction *)playerPlaneBlowupAction;
+(SKAction *)hitActionWithFoePlaneType:(FoePlaneType)type;
+(SKAction *)blowupActionWithFoePlaneType:(FoePlaneType)type;

@end
