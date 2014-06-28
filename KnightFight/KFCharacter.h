//
//  KFCharacter.h
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFObject.h"

@interface KFCharacter : KFObject

@property BOOL isBlocking;
@property BOOL isAttacking;

-(void)loadAnimations;

-(void)block;
-(void)attack;

@end
