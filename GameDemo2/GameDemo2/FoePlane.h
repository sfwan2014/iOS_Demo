//
//  FoePlane.h
//  GameDemo2
//
//  Created by shaofa on 14-3-15.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, FoePlaneType){
    FoePlaneTypeBig = 1,
    FoePlaneTypeMedium = 2,
    FoePlaneTypeSmall = 3
};

@interface FoePlane : SKSpriteNode

@property(nonatomic, assign) int hp;
@property(nonatomic, assign) FoePlaneType type;

+(instancetype)createBigPlane;
+(instancetype)createMediumPlane;
+(instancetype)createSmallPlane;


@end
