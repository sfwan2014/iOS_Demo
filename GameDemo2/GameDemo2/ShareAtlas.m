//
//  ShareAtlas.m
//  GameDemo2
//
//  Created by shaofa on 14-3-15.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ShareAtlas.h"

static ShareAtlas *_shared = nil;

@implementation ShareAtlas

+(instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = (ShareAtlas *)[ShareAtlas atlasNamed:@"gameArts-hd"];
    });
    
    return _shared;
}

+(SKTexture *)textureWithType:(TextureType)type
{
    switch (type) {
        case TextureTypeBackground:
            return [[[self class] shared] textureNamed:@"background_2.png"];
            break;
        case TextureTypeBullet:
            return [[[self class] shared] textureNamed:@"bullet1.png"];
            break;
        case TextureTypePlayerPlane:
            return [[[self class] shared] textureNamed:@"hero_fly_1.png"];
            break;
        case TextureTypeSmallFoePlane:
            return [[[self class] shared] textureNamed:@"enemy1_fly_1.png"];
            break;
        case TextureTypeMediumFoePlane:
            return [[[self class] shared] textureNamed:@"enemy3_fly_1.png"];
            break;
        case TextureTypeBigFoePlane:
            return [[[self class] shared] textureNamed:@"enemy2_fly_1.png"];
            break;
        default:
            break;
    }
    
    return nil;
}

#pragma mark ---
+(SKTexture *)playerPlaneTextureWithIndex:(int)index
{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_fly_%d.png", index]];
}

+(SKTexture *)playerPlaneBlowupTextureWithIndex:(int)index
{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_blowup_%d.png", index]];
}

#pragma mark --- 
+(SKTexture *)hitTextureWithPlaneType:(int)type animationIndex:(int)animationIndex
{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_hit_%d.png", type, animationIndex]];
}

+(SKTexture *)blowupTextureWithPlaneType:(int)type animationIndex:(int)animationIndex
{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_blowup_%d.png", type, animationIndex]];
}

#pragma mark ---


+(SKAction *)playerPlaneAction
{
    NSMutableArray *textures = [[NSMutableArray alloc] init];
    
    for (int i = 1; i<= 2; i++) {
        SKTexture *texture = [[self class] playerPlaneTextureWithIndex:i];
        [textures addObject:texture];
    }
    
    return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
}

+(SKAction *)playerPlaneBlowupAction
{
    NSMutableArray *textures = [[NSMutableArray alloc] init];
    
    for (int i = 1; i<= 4; i++) {
        SKTexture *texture = [[self class] playerPlaneBlowupTextureWithIndex:i];
        [textures addObject:texture];
    }
    
    SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    return [SKAction sequence:@[dieAction, [SKAction removeFromParent]]];
}
+(SKAction *)hitActionWithFoePlaneType:(FoePlaneType)type
{
    switch (type) {
        case FoePlaneTypeBig:
        {
            NSMutableArray *textures = [[NSMutableArray alloc] init];
            SKTexture *texture1 = [[self class] hitTextureWithPlaneType:2 animationIndex:1];
            SKAction *action1 = [SKAction setTexture:texture1];
            
            SKTexture *texture2 = [[self class] textureWithType:TextureTypeBigFoePlane];
            SKAction *action2 = [SKAction setTexture:texture2];
            
            [textures addObject:action1];
            [textures addObject:action2];
            
            return [SKAction sequence:textures];
        }
            break;
            
        case FoePlaneTypeMedium:
        {
            NSMutableArray *textures = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 2; i++) {
                SKTexture *texture = [[self class] hitTextureWithPlaneType:3 animationIndex:i];
                SKAction *action = [SKAction setTexture:texture];
                
                [textures addObject:action];
            }
            
            return [SKAction sequence:textures];
        }
            break;
        case FoePlaneTypeSmall:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

+(SKAction *)blowupActionWithFoePlaneType:(FoePlaneType)type
{
    switch (type) {
        case FoePlaneTypeBig:
        {
            NSMutableArray *textures = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 7; i++) {
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:2 animationIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction, [SKAction removeFromParent]]];
        }
            break;
        case FoePlaneTypeMedium:
        {
            NSMutableArray *textures = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 4; i++) {
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:3 animationIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction, [SKAction removeFromParent]]];
        }
            break;
        case FoePlaneTypeSmall:
        {
            NSMutableArray *textures = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 4; i++) {
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:1 animationIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction, [SKAction removeFromParent]]];
        }
            break;
        default:
            break;
    }
    
    return nil;
}

@end
