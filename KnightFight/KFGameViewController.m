//
//  KFGameViewController.m
//  KnightFight
//
//  Created by Jon Como on 6/25/14.
//  Copyright (c) 2014 Jon Como. All rights reserved.
//

#import "KFGameViewController.h"

#import "KFGameScene.h"

@interface KFGameViewController ()

@end

@implementation KFGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
    
    // Create and configure the scene.
    KFGameScene *game = [KFGameScene sceneWithSize:CGSizeMake(skView.bounds.size.height, skView.bounds.size.width)];
    game.scaleMode = SKSceneScaleModeAspectFit;
    
    [game setup];
    
    // Present the scene.
    [skView presentScene:game];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end