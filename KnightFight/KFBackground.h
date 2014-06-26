//
//  KFBackground.h
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface KFBackground : SKNode

@property CGSize size;

-(id)initWithSize:(CGSize)size;

-(void)update;

@end