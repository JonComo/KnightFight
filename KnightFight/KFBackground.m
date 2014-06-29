//
//  KFBackground.m
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFBackground.h"

@implementation KFBackground

-(id)initWithSize:(CGSize)size
{
    if (self = [super init]) {
        //init
        _size = size;
        
        //setup lamps
        for (int i = 0; i<3; i++) {
            KFObject *lamp = [[KFObject alloc] initWithTexturePrefix:@"torch"];
            lamp.position = CGPointMake(size.width/2 * (i+1), size.height * 3/4);
            [self addChild:lamp];
        }
        
        //floor tiles
        for (int i = 0; i<8; i++) {
            KFObject *floor = [[KFObject alloc] initWithTexturePrefix:@"floorBrick0"];
            floor.position = CGPointMake(size.width/5 * (i + 2) - size.width/2, floor.size.height/2 - 10);
            floor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
            floor.physicsBody.dynamic = NO;
            [self addChild:floor];
        }
    }
    
    return self;
}

-(void)update
{
    for (SKSpriteNode *node in self.children)
    {
        if (node.position.x + self.position.x < -200){
            node.position = CGPointMake(node.position.x + self.size.width + 400, node.position.y);
        }
    }
}

@end
