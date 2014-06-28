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
    
    [self addChild:_world];
    
    _player = [[KFCharacter alloc] initWithTexturePrefix:@"knight"];
    _player.position = CGPointMake(self.size.width/2, self.size.height/2);
    [_world addChild:_player];
    [_player initPhysics];
    
    _player.physicsBody.velocity = CGVectorMake(60, 0);
    
    [self spawnNext];
}

-(void)spawnNext
{
    [self runAction:[SKAction waitForDuration:4] completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            KFCharacter *opponent = [[KFCharacter alloc] initWithTexturePrefix:@"knight"];
            opponent.position = CGPointMake(_player.position.x + self.size.width, _player.position.y + 10);
            opponent.xScale = -4;
            [self.world addChild:opponent];
            [opponent initPhysics];
        });
        
        
        [self spawnNext];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (location.x < self.size.width/2)
        {
            //blocking
            [self.player block];
        }else{
            //Attacking
            [self.player attack];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self.player.physicsBody applyImpulse:CGVectorMake(2, 0)];
}

-(void)didSimulatePhysics
{
    CGPoint offset = CGPointMake(-self.player.position.x + self.size.width/4, background.position.y);
    
    background.position = offset;
    self.world.position = offset;
    
    [background update];
}

@end
