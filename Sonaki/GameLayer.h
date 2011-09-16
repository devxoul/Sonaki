//
//  HelloWorldLayer.h
//  Sonaki
//
//  Created by 전 수열 on 11. 9. 7..
//  Copyright Joyfl 2011년. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Rain.h"

// HelloWorldLayer
@interface GameLayer : CCLayer
{
    int direction;
    int lastDirection;
    float speed;
    
    CCSprite *character;
    NSMutableArray *rains;
    
    float rainInterval;
    
    CGSize winSize;
    
    float cloudX;
    float cloudY;
    int cloudWidth;
    
    CCLabelTTF *scoreLabel;
    int score;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+ (CCScene *) scene;

- (void) createBackground;
- (void) createCharacter;
- (void) createCloud;
- (void) createScoreLabel;

- (void) removeRain:(Rain *)rain;

- (void) move;
- (void) updateScore;

@end
