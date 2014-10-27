//
//  HelloWorldScene.m
//  GameDemo
//
//  Created by shaofa on 14-1-9.
//  Copyright shaofa 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_sprite;
    NSMutableArray *_targets;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    self = [super initWithColor:[CCColor whiteColor]];
    if (self) {
        _targets = [[NSMutableArray alloc] init];
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        
        CCTexture *texture = [CCTexture textureWithFile:@"Player.png"];
        CCSprite *player = [CCSprite spriteWithTexture:texture rect:CGRectMake(0, 0, 27, 40)];
        player.position = ccp(player.contentSize.width/2, winSize.height/2);
        [self addChild:player];
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addTarget) userInfo:nil repeats:YES];
        
    }
	return self;
}

// -----------------------------------------------------------------------

-(void)addTarget
{
    CCSprite *target;
//    if (_targets.count > 3) {
//        target = _targets[0];
//    }
    
    if (target == nil) {
        CCTexture *texture = [CCTexture textureWithFile:@"Target.png"];
        target = [CCSprite spriteWithTexture:texture rect:CGRectMake(0, 0, 27, 40)];
    }

    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    int minY = target.contentSize.height/2;
    int maxY = viewSize.height - minY;
    int rangY = maxY-minY;
    int actualY = (arc4random()%rangY)+minY;
    
    target.position = ccp(viewSize.width + target.contentSize.width/2, actualY);
    [self addChild:target];
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    
    int actualDuration = (arc4random()%rangeDuration)+minDuration;
    
    id actionMove = [CCActionMoveTo actionWithDuration:actualDuration position:ccp(-target.contentSize.width/2, actualY)];
    id actionMoveDone = [CCActionCallFunc actionWithTarget:self selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCActionSequence actions:actionMove, actionMoveDone, nil]];
    [_targets addObject:target];
}

-(void)spriteMoveFinished:(id)sender
{
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    CCTexture *texture = [CCTexture textureWithFile:@"Projectile.png"];
    CCSprite *sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(0, 0, 20, 20)];

    sprite.position = ccp(20, viewSize.height/2);
    
    [self addChild:sprite];
    
}

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Pr frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_sprite runAction:actionMove];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end