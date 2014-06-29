//
//  KFEffect.h
//  KnightFight
//
//  Created by Jon Como on 6/28/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum
{
    KFEffectTypeBlood,
    KFEffectTypeSparks
} KFEffectType;

@interface KFEffect : SKSpriteNode

+(void)showEffect:(KFEffectType)effect atPosition:(CGPoint)position;

@end
