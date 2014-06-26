//
//  KFGameScene.m
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFGameScene.h"

#import "KFBackground.h"

static KFGameScene *game;

@implementation KFGameScene
{
    KFBackground *background;
}

+(instancetype)sceneWithSize:(CGSize)size
{
    if (!game)
        game = [[KFGameScene alloc] initWithSize:size];
    
    return game;
}

+(KFGameScene *)shared
{
    return game;
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor colorWithRed:0.004 green:0.020 blue:0.125 alpha:1.000];
        
        //Physics setup
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        _world = [SKNode new];
        
    }
    return self;
}

-(void)setup
{
    //Add bg
    background = [[KFBackground alloc] initWithSize:self.size];
    [self addChild:background];
    
    //Add floor
    KFObject *floor = [[KFObject alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width, 80)];
    floor.position = CGPointMake(self.size.width/2, floor.size.height/2);
    floor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
    floor.physicsBody.dynamic = NO;
    [self addChild:floor];
    
    [self addChild:_world];
    
    _player = [[KFCharacter alloc] initWithTexturePrefix:@"knight"];
    _player.position = CGPointMake(self.size.width/2, self.size.height/2);
    [_world addChild:_player];
    [_player initPhysics];
    
    SKSpriteNode *test = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    test.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:test.size];
    test.position = CGPointMake(self.size.width*3/4, 200);
    [_world addChild:test];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self.player.physicsBody applyImpulse:CGVectorMake(2, 0)];
    
}

-(void)didSimulatePhysics
{
    CGPoint offset = CGPointMake(-self.player.position.x + self.size.width/2, background.position.y);
    
    background.position = offset;
    self.world.position = offset;
    
    [background update];
}

@end
