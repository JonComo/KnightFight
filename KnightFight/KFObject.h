//
//  KFObject.h
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface KFObject : SKSpriteNode

@property (nonatomic, copy) NSString *prefix;

-(id)initWithTexturePrefix:(NSString *)prefix;

-(void)initPhysics;

-(void)update:(CFTimeInterval)currentTime;

-(void)die;

@end