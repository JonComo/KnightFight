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
    
    NSArray *runFrames;
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
    runFrames = [self framesWithPrefix:[NSString stringWithFormat:@"%@Run_", self.prefix] count:4];
    
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:runFrames timePerFrame:0.2 resize:NO restore:NO]]];
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
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width*4/5, self.size.height*4/5)];
    //self.physicsBody.allowsRotation = NO;
    
    wheel = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width, self.size.width)];
    wheel.position = CGPointMake(self.position.x, self.position.y);
    wheel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:wheel.size.width*3/7];
    [self.parent addChild:wheel];
    
    jointWheel = [SKPhysicsJointPin jointWithBodyA:self.physicsBody bodyB:wheel.physicsBody anchor:wheel.position];
    [[KFGameScene shared].physicsWorld addJoint:jointWheel];
}

@end