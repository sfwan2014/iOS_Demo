//
//  MyScene.m
//  GameDemo2
//
//  Created by shaofa on 14-3-15.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "MyScene.h"
#import "ShareAtlas.h"
#import "FoePlane.h"

typedef NS_ENUM(uint32_t, RoleCategory){
    RoleCategoryBullet = 1,
    RoleCategoryFoePlane = 4,
    RoleCategoryPlayerPlane = 8,
};

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */

        [self initPhysicsWorld];
        [self initAction];
        [self initBackground];
        [self initScroe];
        [self initPlayerPlane];
        [self firingBullets];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restart) name:@"restartNotification" object:Nil];
    }
    return self;
}

-(void)restart
{
    [self removeAllChildren];
    [self removeAllActions];
    [self initBackground];
    [self initScroe];
    [self initPlayerPlane];
    [self firingBullets];
    _smallPlaneTime = 0;
    _mediumPlaneTime = 0;
    _bigPlaneTime = 0;
}


-(void)initPhysicsWorld
{
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
}

-(void)initAction
{
    _smallFoePlaneHitAction = [ShareAtlas hitActionWithFoePlaneType:FoePlaneTypeSmall];
    _mediumFoePlaneHitAction = [ShareAtlas hitActionWithFoePlaneType:FoePlaneTypeMedium];
    _bigFoePlaneHitAction = [ShareAtlas hitActionWithFoePlaneType:FoePlaneTypeBig];
    
    _smallFoePlaneBlowupAction = [ShareAtlas blowupActionWithFoePlaneType:FoePlaneTypeSmall];
    _mediumFoePlaneBlowupAction = [ShareAtlas blowupActionWithFoePlaneType:FoePlaneTypeMedium];
    _bigFoePlaneBlowupAction = [ShareAtlas blowupActionWithFoePlaneType:FoePlaneTypeBig];
}

-(void)initBackground
{
    _adjustmentBackgroundPosition = self.size.height;
    
    _background1 = [SKSpriteNode spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeBackground]];
    _background1.position = CGPointMake(self.size.width/2, 0);
    _background1.anchorPoint = CGPointMake(0.5, 0);
    _background1.zPosition = 0;
    
    _background2 = [SKSpriteNode spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeBackground]];
    _background2.position = CGPointMake(self.size.width/2, _adjustmentBackgroundPosition - 1);
    _background2.anchorPoint = CGPointMake(0.5, 0);
    _background2.zPosition = 0;
    
    [self addChild:_background1];
    [self addChild:_background2];
    
    [self runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"game_music.mp3" waitForCompletion:YES]]];
}

-(void)scrollBackground
{
    _adjustmentBackgroundPosition --;
    
    if (_adjustmentBackgroundPosition <= 0) {
        _adjustmentBackgroundPosition = 568;
    }
    
    [_background1 setPosition:CGPointMake(self.size.width/2, _adjustmentBackgroundPosition - 568)];
    [_background2 setPosition:CGPointMake(self.size.width/2, _adjustmentBackgroundPosition - 1)];
}

-(void)initScroe
{
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
    _scoreLabel.text = @"0000";
    _scoreLabel.zPosition = 2;
    _scoreLabel.fontColor = [SKColor blackColor];
    _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _scoreLabel.position = CGPointMake(50, self.size.height-52);
    [self addChild:_scoreLabel];
}

-(void)initPlayerPlane
{
    _playerPlane = [SKSpriteNode spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypePlayerPlane]];
    _playerPlane.position = CGPointMake(160, 50);
    _playerPlane.zPosition = 1;
    _playerPlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_playerPlane.size];
    _playerPlane.physicsBody.categoryBitMask = RoleCategoryPlayerPlane;
    _playerPlane.physicsBody.collisionBitMask = 0;
    _playerPlane.physicsBody.contactTestBitMask = RoleCategoryFoePlane;
    [self addChild:_playerPlane];
    [_playerPlane runAction:[ShareAtlas playerPlaneAction]];
}

-(void)createFoePlane
{
    _smallPlaneTime++;
    _mediumPlaneTime++;
    _bigPlaneTime++;
    
    FoePlane *(^create)(FoePlaneType) = ^(FoePlaneType type){
        int x = (arc4random() % 220) + 35;
        FoePlane *foePlane = nil;
        switch (type) {
            case 1:
                foePlane = [FoePlane createBigPlane];
                break;
            case 2:
                foePlane = [FoePlane createMediumPlane];
                break;
            case 3:
                foePlane = [FoePlane createSmallPlane];
                break;
                
            default:
                break;
        }
        
        foePlane.zPosition = 1;
        foePlane.physicsBody.categoryBitMask = RoleCategoryFoePlane;
        foePlane.physicsBody.collisionBitMask = RoleCategoryBullet;
        foePlane.physicsBody.contactTestBitMask = RoleCategoryBullet;
        foePlane.position = CGPointMake(x, self.size.height);
        
        return foePlane;
    };
    
    if (_smallPlaneTime > 25) {
        float speed = (arc4random() % 3) + 2;
        FoePlane *foePlane = create(FoePlaneTypeSmall);
        [self addChild:foePlane];
        
        [foePlane runAction:[SKAction sequence:@[[SKAction moveToY:0 duration:speed], [SKAction removeFromParent]]]];
        _smallPlaneTime = 0;
    }
    
    if (_mediumPlaneTime > 400) {
        float speed = (arc4random() % 3) + 4;
        FoePlane *foePlane = create(FoePlaneTypeMedium);
        [self addChild:foePlane];
        
        [foePlane runAction:[SKAction sequence:@[[SKAction moveToY:0 duration:speed], [SKAction removeFromParent]]]];
        _mediumPlaneTime = 0;
    }
    
    if (_bigPlaneTime > 700) {
        float speed = (arc4random() % 3) + 4;
        FoePlane *foePlane = create(FoePlaneTypeBig);
        [self addChild:foePlane];
        
        [foePlane runAction:[SKAction sequence:@[[SKAction moveToY:0 duration:speed], [SKAction removeFromParent]]]];
        
        [self runAction:[SKAction playSoundFileNamed:@"enemy2_out.mp3" waitForCompletion:NO]];
        
        _bigPlaneTime = 0;
    }
}

/*
        *            0
       * *         -1 1
      * * *       -2 0 2
     * * * *     -3-1 1 3
    * * * * *
 */

-(CGFloat)positionX:(int)index count:(int)count bullet:(SKSpriteNode *)bullet
{
    float x = 0.0;
    
    if (count == 1) {
        x = _playerPlane.position.x + 0;
    } else if (count == 2) { // -1  + 1
        x = _playerPlane.position.x - powf(-1, index) * bullet.size.width ;
    } else if (count == 3) { // -2 0 2
        x = _playerPlane.position.x - 2 * sin((1-index)*M_PI_2) * bullet.size.width;
    } else if (count == 4) {
        float l = (3 - 2*index) * bullet.size.width;
        x = _playerPlane.position.x + l;
    }
    
    return x;
}

-(CGFloat)gonePositionX:(int)index count:(int)count bullet:(SKSpriteNode *)bullet
{
    float x = 0.0;
    
    if (count == 1) {
        x = _playerPlane.position.x;
    } else if (count == 2) {
        x = _playerPlane.position.x - powf(-1, index) * bullet.size.width * 5;
    } else if (count == 3) {
        x = _playerPlane.position.x - sin((1-index)*M_PI_2) * bullet.size.width * 5;
    } else if (count == 4) {
        float l = (3 - 2*index) * bullet.size.width;
        x = _playerPlane.position.x + l*5;
    }
    
    return x;
}

-(void)createBullets
{
    int count = 4;
    for (int i = 0; i < count; i++) {
        
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithTexture:[ShareAtlas textureWithType:TextureTypeBullet]];
        float x = [self positionX:i count:count bullet:bullet];
        bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.size];
        bullet.physicsBody.categoryBitMask = RoleCategoryBullet;
        bullet.physicsBody.collisionBitMask = RoleCategoryFoePlane;
        bullet.physicsBody.contactTestBitMask = RoleCategoryFoePlane;
        bullet.zPosition = 1;
        bullet.position = CGPointMake(x, _playerPlane.position.y+(_playerPlane.size.height/2));
        
        [self addChild:bullet];
        
        float _x = [self gonePositionX:i count:count bullet:bullet];
        SKAction *actionMove = [SKAction moveTo:CGPointMake(_x, self.size.height) duration:0.5];
        SKAction *actionMoveDone = [SKAction removeFromParent];
        [bullet runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    }
    
    [self runAction:[SKAction playSoundFileNamed:@"bullet.mp3" waitForCompletion:NO]];
}

-(void)firingBullets
{
    SKAction *action = [SKAction runBlock:^{
        [self createBullets];
    }];
    
    SKAction *interval = [SKAction waitForDuration:0.4];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[action, interval]]]];
}

-(void)changeScore:(FoePlaneType)type
{
    int score = 0;
    switch (type) {
        case FoePlaneTypeBig:
            score = 30000;
            break;
        case FoePlaneTypeMedium:
            score = 6000;
            break;
        case FoePlaneTypeSmall:
            score = 1000;
            break;
            
        default:
            break;
    }
    
    [_scoreLabel runAction:[SKAction runBlock:^{
        _scoreLabel.text = [NSString stringWithFormat:@"%d", _scoreLabel.text.intValue + score];
    }]];
}

-(void)foePlaneCollisionAnimation:(FoePlane *)sprite
{
    if (![sprite actionForKey:@"dieAction"]) {
        SKAction *hitAction = nil;
        SKAction *blowupAction = nil;
        NSString *soundFileName = [[NSString alloc] init];
        
        switch (sprite.type) {
            case FoePlaneTypeBig:
            {
                sprite.hp--;
                hitAction = _bigFoePlaneHitAction;
                blowupAction = _bigFoePlaneBlowupAction;
                soundFileName = @"enemy2_down.mp3";
            }
                break;
            case FoePlaneTypeMedium:
            {
                sprite.hp--;
                hitAction = _mediumFoePlaneHitAction;
                blowupAction = _mediumFoePlaneBlowupAction;
                soundFileName = @"enemy3_down.mp3";
            }
                break;
            case FoePlaneTypeSmall:
            {
                sprite.hp--;
                hitAction = _smallFoePlaneHitAction;
                blowupAction = _smallFoePlaneBlowupAction;
                soundFileName = @"enemy1_down.mp3";
            }
                break;
                
            default:
                break;
        }
        
        if (!sprite.hp) {
            [sprite removeAllActions];
            [sprite runAction:blowupAction withKey:@"dieAction"];
            [self changeScore:sprite.type];
            [self runAction:[SKAction playSoundFileNamed:soundFileName waitForCompletion:NO]];
        } else {
            [sprite runAction:hitAction];
        }
    }
}

-(void)playerPlaneCollisionAnimation:(SKSpriteNode *)sprite
{
    [self removeAllActions];
    [sprite runAction:[ShareAtlas playerPlaneBlowupAction] completion:^{
        [self runAction:[SKAction sequence:@[[SKAction playSoundFileNamed:@"game_over.mp3" waitForCompletion:YES], [SKAction runBlock:^{
            
            SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
            label.text = @"GameOver";
            label.fontColor = [SKColor blackColor];
            label.position = CGPointMake(self.size.width/2, self.size.height/2 + 20);
            [self addChild:label];
            
        }]]]completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOverNotification" object:nil];
        }];
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (location.x >= self.size.width - (_playerPlane.size.width/2)) {
            location.x = self.size.width - (_playerPlane.size.width/2);
        } else if (location.x <= (_playerPlane.size.width/2)) {
            location.x = _playerPlane.size.width/2;
        }
        
        if (location.y >= self.size.height - (_playerPlane.size.height/2)) {
            location.y = self.size.height - (_playerPlane.size.height/2);
        }else if (location.y <= (_playerPlane.size.height/2)){
            location.y = _playerPlane.size.height/2;
        }
        
        SKAction *action = [SKAction moveTo:CGPointMake(location.x, location.y) duration:0];
        [_playerPlane runAction:action];
    }
}

-(void)update:(CFTimeInterval)currentTime {

    [self createFoePlane];
    
    [self scrollBackground];
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    if (contact.bodyA.categoryBitMask & RoleCategoryFoePlane || contact.bodyB.categoryBitMask & RoleCategoryFoePlane) {
        
        FoePlane *sprite = (contact.bodyA.categoryBitMask &RoleCategoryFoePlane) ? (FoePlane *)contact.bodyA.node: (FoePlane *)contact.bodyB.node;
        
        if (contact.bodyA.categoryBitMask & RoleCategoryPlayerPlane || contact.bodyB.categoryBitMask & RoleCategoryPlayerPlane) {
            
            SKSpriteNode *playerPlane = (contact.bodyA.categoryBitMask & RoleCategoryPlayerPlane) ? (SKSpriteNode *)contact.bodyA.node : (SKSpriteNode *)contact.bodyB.node;
            [self playerPlaneCollisionAnimation:playerPlane];
            
        } else {
            SKSpriteNode *bullet = (contact.bodyA.categoryBitMask & RoleCategoryBullet) ? (FoePlane *)contact.bodyA.node : (FoePlane *)contact.bodyB.node;
            [bullet removeFromParent];
            [self foePlaneCollisionAnimation:sprite];
        }
    }
}

-(void)didEndContact:(SKPhysicsContact *)contact
{
    
}

@end
