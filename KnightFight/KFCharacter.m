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
}

-(id)initWithTexturePrefix:(NSString *)prefix
{
    if (self = [super initWithTexturePrefix:prefix]) {
        //init
        
    }
    
    return self;
}

-(void)initPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.allowsRotation = NO;
    
    wheel = [[SKSpriteNode alloc] initWithColor:[UIColor blueColor] size:CGSizeMake(self.size.width, self.size.width)];
    wheel.position = CGPointMake(self.position.x, self.position.y - self.size.height/2);
    wheel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:wheel.size.width/2];
    [self.parent addChild:wheel];
    
    jointWheel = [SKPhysicsJointPin jointWithBodyA:self.physicsBody bodyB:wheel.physicsBody anchor:wheel.position];
    [[KFGameScene shared].physicsWorld addJoint:jointWheel];
}

@end