//
//  Rain.h
//  Sonaki
//
//  Created by 전 수열 on 11. 9. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Rain : CCSprite {
    float speed;
}

@property (nonatomic) float speed;

- (BOOL) hitTest:(CCSprite *)character;

@end
