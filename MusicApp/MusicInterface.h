//
//  MusicInterface.h
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MusicPad;

@interface MusicInterface : CCLayer {
    NSMutableArray *musicPadArray;
    MusicPad *currentPad;
    bool isPlaying;
    int musicPadSideLength;
    int boardWidth;
    int boardHeight;
    int beatNum;
    float timeSinceLastBeat;
}

@property int musicPadSideLength, boardWidth, boardHeight;

+ (id) musicInterface;
- (MusicPad *) getPadForTouch:(UITouch *)touch;
- (BOOL) checkIndexBounds:(CGPoint)index;
- (void) play;

@end
