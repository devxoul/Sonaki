//
//  GameLayer.m
//  Sonaki
//
//  Created by 전 수열 on 11. 9. 6..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "GameLayer.h"
#import "Rain.h"

@implementation GameLayer

enum {
    kTagBackground = 0,
    kTagCharacter = 1,
    kTagRain = 2,
    kTagCloud = 3,
    kTagScoreLabel = 4
};

enum {
    kTagGameOverAlert = 0
};

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
	if( (self=[super init]))
    {
        self.isTouchEnabled = YES;
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        [self createBackground];
        [self createCharacter];
        [self createCloud];
        [self createScoreLabel];
        
        rains = [[NSMutableArray alloc] init];
        
        direction = lastDirection = 1;
        speed = 2;
        
        [self schedule:@selector(loop)];
        
        rainInterval = 1.0;
        [self schedule:@selector(createRain:) interval:rainInterval];
        
        score = 0;
    }
    
    return self;
}

- (void) createBackground
{
    CCSprite *bg = [CCSprite spriteWithFile:@"game_bg.png"];
    bg.anchorPoint = CGPointZero;
    [bg setPosition:ccp(0, 0)];
    [self addChild:bg z:kTagBackground tag:kTagBackground];
}

- (void) createCharacter
{
    character = [CCSprite spriteWithFile:@"character.png"];
    character.anchorPoint = CGPointZero;
    character.flipX = YES;
    [character setPosition:ccp(160, 20)];
    [self addChild:character z:kTagCharacter tag:kTagCharacter];
}

- (void) createCloud
{
    CCSprite *cloud = [CCSprite spriteWithFile:@"cloud.png"];
    [cloud setPosition:ccp(159, 413)];
    [self addChild:cloud z:kTagCloud tag:kTagCloud];
    
    cloudX = cloud.boundingBox.origin.x + 5;
    cloudY = cloud.boundingBox.origin.y + 20;
    cloudWidth = (int)cloud.boundingBox.size.width - 10;
}

- (void) createScoreLabel
{
    scoreLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(cloudWidth - 10, 30) alignment:UITextAlignmentRight fontName:@"Helvetica" fontSize:30.0];
    scoreLabel.color = ccc3(133, 201, 250);
    scoreLabel.position = ccp(150, 390);
    [self addChild:scoreLabel z:kTagScoreLabel tag:kTagScoreLabel];
}

- (void) createRain:(ccTime)dt
{
    Rain *rain = [Rain spriteWithFile:@"rain.png"];
    rain.speed = (arc4random() % 5 + 15) / 10.0;
    NSLog(@"%f", rain.speed);
    [rain setPosition:ccp(arc4random() % cloudWidth + cloudX, cloudY)];
    [self addChild:rain z:kTagRain tag:kTagRain];
    
    [rains addObject:rain];
    
    NSLog( @"rainInterval = %f", rainInterval);
    if(rainInterval >= 0.25 ) rainInterval -= 0.05;
    [self unschedule:@selector(createRain:)];
    [self schedule:@selector(createRain:) interval:rainInterval];
}

- (void) removeRain:(Rain *)rain
{
    [self removeChild:rain cleanup:YES];
}

- (void) updateScore
{
    scoreLabel.string = [NSString stringWithFormat:@"%d", ++score];
}

//- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
//{
//    NSLog( @"accel" );
//    float dx = acceleration.x;
//    
//    float x = character.position.x;
//    float width = character.boundingBox.size.width;
//    
//    if(x + dx <= cloudX)
//        [character setPosition:ccp(cloudX, character.position.y)];
//    else if(x + dx >= cloudX + cloudWidth - width)
//        [character setPosition:ccp(cloudX + cloudWidth - width, character.position.y)];
//    else
//        [character setPosition:ccp(x + dx, character.position.y)];
//}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    direction = 0;
    
    if(lastDirection == 1) character.flipX = NO;
    else character.flipX = YES;
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    lastDirection = direction = lastDirection * -1;
}

- (void) loop
{
    [self move];
    
    for(Rain *rain in rains)
    {
        [rain setPosition:ccp(rain.position.x, rain.position.y - rain.speed)];
        
        if( rain.position.y < 0 )
        {
            [self removeRain:rain];
        }
        
        if([rain hitTest:character])
        {
            [[CCDirector sharedDirector] pause];
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Game Over" message:@"Game Over랑께" delegate:self cancelButtonTitle:@"네 형" otherButtonTitles:nil] autorelease];
            [alert show];
        }
    }
    
    [self updateScore];
}

- (void) move
{
    float x = character.position.x;
    int dx = direction * speed;
    float width = character.boundingBox.size.width;
    
    if(x + dx <= cloudX)
        [character setPosition:ccp(cloudX, character.position.y)];
    else if(x + dx >= cloudX + cloudWidth - width)
        [character setPosition:ccp(cloudX + cloudWidth - width, character.position.y)];
    else
        [character setPosition:ccp(x + dx, character.position.y)];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case kTagGameOverAlert:
            [[CCDirector sharedDirector] popScene];
            break;
            
        default:
            break;
    }
}

@end
