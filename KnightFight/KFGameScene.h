//
//  KFGameScene.h
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "KFCharacter.h"

@class KFGameScene;

@interface KFGameScene : SKScene

@property (nonatomic, strong) SKNode *world;
@property (nonatomic, strong) KFCharacter *player;

+(KFGameScene *)shared;
-(void)setup;

@end