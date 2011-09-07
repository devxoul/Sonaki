//
//  Rain.m
//  Sonaki
//
//  Created by 전 수열 on 11. 9. 7..
//  Copyright 2011년 Joyfl. All rights reserved.
//

#import "Rain.h"


@implementation Rain

@synthesize speed;

- (BOOL) hitTest:(CCSprite *)character
{
    CGRect charBox = character.boundingBox;
    return CGRectIntersectsRect(CGRectMake(charBox.origin.x + 2, charBox.origin.y + 10, charBox.size.width - 4, charBox.size.height - 10), self.boundingBox);
}

@end
