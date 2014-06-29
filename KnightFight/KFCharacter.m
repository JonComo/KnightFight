//
//  KFCharacter.m
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFCharacter.h"

@implementation KFCharacter
{
    SKSpriteNode *wheel;
    SKPhysicsJointPin *jointWheel;
    
    NSMutableArray *animations;
}

-(id)initWithTexturePrefix:(NSString *)prefix
{
    if (self = [super initWithTexturePrefix:prefix]) {
        //init
        [self loadAnimations];
    }
    
    return self;
}

-(void)loadAnimations
{
    animations = [NSMutableArray array];
    
    [animations addObject:[self framesWithPrefix:[NSString stringWithFormat:@"%@Run_", self.prefix] count:4]];
    [animations addObject:[self framesWithPrefix:[NSString stringWithFormat:@"%@Block_", self.prefix] count:4]];
    [animations addObject:[self framesWithPrefix:[NSString stringWithFormat:@"%@Attack_", self.prefix] count:4]];
    
    [self run];
}

-(NSArray *)framesWithPrefix:(NSString *)framePrefix count:(int)count
{
    NSMutableArray *frames = [NSMutableArray array];
    
    for (int i = 0; i<count; i++){
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@%i", framePrefix, i]];
        texture.filteringMode = SKTextureFilteringNearest;
        [frames addObject:texture];
    }
    
    return frames;
}

-(void)initPhysics
{
    KFGameScene *game = [KFGameScene shared];
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(ABS(self.size.width*4/5), ABS(self.size.height*4/5))];
    self.physicsBody.allowsRotation = NO;
    
    wheel = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(ABS(self.size.width), ABS(self.size.width))];
    wheel.position = CGPointMake(self.position.x, self.position.y);
    wheel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:wheel.size.width*3/7];
    [self.parent addChild:wheel];
    
    jointWheel = [SKPhysicsJointPin jointWithBodyA:self.physicsBody bodyB:wheel.physicsBody anchor:CGPointMake(wheel.position.x + game.world.position.x, wheel.position.y + game.world.position.y)];
    [[KFGameScene shared].physicsWorld addJoint:jointWheel];
}

-(void)block
{
    if (self.isBlocking || self.isAttacking) return;
    self.isBlocking = YES;
    
    __weak KFCharacter *weakSelf = self;
    
    [self runOnce:[SKAction animateWithTextures:animations[1] timePerFrame:0.1 resize:NO restore:NO] completion:^{
        [weakSelf run];
        weakSelf.isBlocking = NO;
    }];
    
    [self runAction:[SKAction playSoundFileNamed:@"block.wav" waitForCompletion:NO]];
    
    //Find any object infront
    KFObject *object = [self objectInFront];
    if (object)
    {
        [KFEffect showEffect:KFEffectTypeSparks atPosition:CGPointMake(object.position.x, object.position.y)];
        [object.physicsBody applyImpulse:CGVectorMake((self.xScale > 0 ? 1 : -1) * 200, 0)];
    }
}

-(void)die
{
    [[KFGameScene shared].physicsWorld removeJoint:jointWheel];
    [wheel removeFromParent];
    
    [self.parent runAction:[SKAction playSoundFileNamed:@"die.wav" waitForCompletion:NO]];
    
    [super die];
}

-(void)run
{
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:animations[0] timePerFrame:0.2 resize:NO restore:NO]]];
}

-(void)attack
{
    if (self.isBlocking || self.isAttacking) return;
    self.isAttacking = YES;
    
    __weak KFCharacter *weakSelf = self;
    
    [self runOnce:[SKAction animateWithTextures:animations[2] timePerFrame:0.1 resize:NO restore:NO] completion:^{
        [weakSelf run];
        weakSelf.isAttacking = NO;
    }];
    
    [self runAction:[SKAction playSoundFileNamed:@"slash.wav" waitForCompletion:NO]];
    
    //Find any object infront
    KFObject *object = [self objectInFront];
    if (object)
    {
        [KFEffect showEffect:KFEffectTypeBlood atPosition:object.position];
        [object die];
    }
}

-(KFObject *)objectInFront
{
    for (KFObject *object in [KFGameScene shared].world.children)
    {
        if (![object isKindOfClass:[KFObject class]] || object == self) continue;
        
        if (ABS(object.position.x - self.position.x) < 200)
        {
            if (self.xScale > 0)
            {
                if (object.position.x > self.position.x)
                    return object;
            }else{
                if (object.position.x < self.position.x)
                    return object;
            }
        }
    }
    
    return nil;
}

-(void)runOnce:(SKAction *)action completion:(void(^)(void))block
{
    [self runAction:action completion:^{
        if (block) block();
    }];
}

@end