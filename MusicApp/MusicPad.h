//
//  MusicPad.h
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MusicPad : CCSprite {
    int indexX;
    int indexY;
    bool isOn;
    NSString *audioFileName;
}

@property int indexX, indexY;

+ (id) musicPadWithIndexX:(int)x andIndexY:(int)y;
- (id) initMusicPadWithIndexX:(int)x andIndexY:(int)y;
- (void) setAudioFile:(int)fileNum;
- (void) changeState;
- (void) play;

@end
