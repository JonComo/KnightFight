//
//  KFObject.m
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFObject.h"

@implementation KFObject

-(id)initWithTexturePrefix:(NSString *)prefix
{
    SKTexture *tex = [SKTexture textureWithImageNamed:prefix];
    tex.filteringMode = SKTextureFilteringNearest;
    
    if (self = [super initWithTexture:tex]) {
        //init
        
        _prefix = prefix;
        
        self.xScale = 4;
        self.yScale = 4;
    }
    
    return self;
}

-(void)initPhysics
{
    
}

-(void)update:(NSTimeInterval)currentTime
{
    
}

@end