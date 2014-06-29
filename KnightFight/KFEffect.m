//
//  KFEffect.m
//  KnightFight
//
//  Created by Jon Como on 6/28/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFEffect.h"

static NSMutableArray *effects;

@implementation KFEffect

+(void)initialize
{
    [super initialize];
    
    effects = [NSMutableArray array];
    
    [effects addObject:[KFEffect framesForPrefix:@"blood"]];
    [effects addObject:[KFEffect framesForPrefix:@"sparks"]];
}

+(void)showEffect:(KFEffectType)effect atPosition:(CGPoint)position
{
    NSArray *frames = effects[effect];
    KFEffect *effectSprite = [[KFEffect alloc] initWithTexture:(SKTexture *)frames[0]];
    
    effectSprite.position = position;
    effectSprite.xScale = effectSprite.yScale = 4;
    
    [[KFGameScene shared].world addChild:effectSprite];
    
    __weak KFEffect *weak = effectSprite;
    
    [effectSprite runAction:[SKAction animateWithTextures:frames timePerFrame:0.1 resize:NO restore:NO] completion:^{
        [weak removeFromParent];
    }];
}

+(NSArray *)framesForPrefix:(NSString *)prefix
{
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i<4; i++){
        SKTexture *tex = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_%i", prefix, i]];
        tex.filteringMode = SKTextureFilteringNearest;
        [frames addObject:tex];
    }
    
    return frames;
}

@end