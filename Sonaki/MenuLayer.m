//
//  MenuLayer.m
//  Sonaki
//
//  Created by 전 수열 on 11. 9. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "MenuLayer.h"
#import "GameLayer.h"


@implementation MenuLayer
{
       
}

enum {
    kTagBackground = 0,
    kTagMenu = 1
};

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return scene;    
}

- (id) init
{
    if(self = [super init])
    {
        CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png"];
        bg.anchorPoint = ccp(0, 0);
        [bg setPosition:ccp(0, 0)];
        [self addChild:bg z:kTagBackground tag:kTagBackground];
        
        CCMenuItemImage *playMenuItem = [CCMenuItemImage itemFromNormalImage:@"play_button_normal.png" selectedImage:@"play_button_selected.png" target:self selector:@selector(playMenuItemCallback:)];
        CCMenuItemImage *helpMenuItem = [CCMenuItemImage itemFromNormalImage:@"help_button_normal.png" selectedImage:@"help_button_selected.png" target:self selector:@selector(helpMenuItemCallback:)];
        CCMenuItemImage *rankingMenuItem = [CCMenuItemImage itemFromNormalImage:@"ranking_button_normal.png" selectedImage:@"ranking_button_selected.png" target:self selector:@selector(rankingMenuItemCallback:)];
        
        [playMenuItem setPosition:ccp(-60, -30)];
        [helpMenuItem setPosition:ccp(60, -105)];
        [rankingMenuItem setPosition:ccp(-50, -175)];
        
        CCMenu *menu = [CCMenu menuWithItems:playMenuItem, helpMenuItem, rankingMenuItem, nil];
        [self addChild:menu];
    }
    return self;
}

- (void) playMenuItemCallback: (id)sender
{
    CCCallFunc *onPlayMenuItemActionEnd = [CCCallFunc actionWithTarget:self selector:@selector(onPlayMenuItemActionEnd:)];
    CCEaseInOut *action = [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.6 position:ccp(0, -395)] rate:2];
    [self runAction:[CCSequence actions:action, onPlayMenuItemActionEnd, nil]];
    [action retain];
}

- (void) onPlayMenuItemActionEnd: (id)sender
{
    [[CCDirector sharedDirector] pushScene:[GameLayer scene]];
}

- (void) helpMenuItemCallback: (id)sender
{
    
}

- (void) rankingMenuItemCallback: (id)sender
{
    
}

- (void) onEnter
{
    [super onEnter];
    [[CCDirector sharedDirector] resume];
    CCAction *action = [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.6 position:ccp(0, 0)] rate:2];
    [self runAction:action];
}

@end
