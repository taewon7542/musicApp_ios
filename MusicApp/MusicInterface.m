//
//  MusicInterface.m
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicInterface.h"
#import "GameConfig.h"
#import "MusicPad.h"

@implementation MusicInterface

@synthesize musicPadSideLength, boardWidth, boardHeight;

+ (id) musicInterface {
    return [[[MusicInterface alloc] init] autorelease];
}

- (id) init {
    if ((self = [super init])) {
        musicPadArray = [[NSMutableArray arrayWithCapacity:ROWS_NUM] retain];
        musicPadSideLength = 0;
        timeSinceLastBeat = BEAT_TIME;
        beatNum = 0;
        isPlaying = NO;
        currentPad = nil;
        
        for (int i = 0; i < ROWS_NUM; i++) {
            NSMutableArray *musicPadRow = [NSMutableArray arrayWithCapacity:COLUMNS_NUM];
            for (int j = 0; j < COLUMNS_NUM; j++) {
                MusicPad *newMusicPad = [MusicPad musicPadWithIndexX:j andIndexY:i];
                if (musicPadSideLength == 0) {
                    musicPadSideLength = newMusicPad.contentSize.width;
                }
                newMusicPad.position = ccp((musicPadSideLength + PADDING) * j + PADDING + musicPadSideLength / 2, (musicPadSideLength + PADDING) * i + PADDING + musicPadSideLength / 2);
                [newMusicPad setAudioFile:j];
                [musicPadRow insertObject:newMusicPad atIndex:j];
                [self addChild:newMusicPad];
            }
            [musicPadArray insertObject:musicPadRow atIndex:i];
        }
        
        boardWidth = (musicPadSideLength + PADDING) * COLUMNS_NUM + PADDING;
        boardHeight = (musicPadSideLength + PADDING) * ROWS_NUM + PADDING;
        
        self.isTouchEnabled = YES;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:TRUE];
    }
    return self;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    MusicPad *currentMusicPad = [self getPadForTouch:touch];
    currentPad = currentMusicPad;
    [currentPad changeState];
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    MusicPad *currentMusicPad = [self getPadForTouch:touch];
    if (currentPad != currentMusicPad) {
        currentPad = currentMusicPad;
        [currentPad changeState];
    }
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    currentPad = nil;
}

- (BOOL) checkIndexBounds:(CGPoint)index {
    if (index.x < 0 || index.x >= COLUMNS_NUM || index.y < 0 || index.y >= ROWS_NUM) {
        return NO;
    }
    else {
        return YES;
    }
}

- (MusicPad *) getPadForTouch:(UITouch *)touch {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    int touchIndexX = ((int)touchLocation.x - (int)touchLocation.x % (musicPadSideLength + PADDING)) / (musicPadSideLength + PADDING);
    int touchIndexY = ((int)touchLocation.y - (int)touchLocation.y % (musicPadSideLength + PADDING)) / (musicPadSideLength + PADDING);
    
    if ([self checkIndexBounds:ccp(touchIndexX, touchIndexY)]) {
        MusicPad *currentMusicPad = [[musicPadArray objectAtIndex:touchIndexY] objectAtIndex:touchIndexX];
        if (CGRectContainsPoint(currentMusicPad.boundingBox, touchLocation)) {
            return currentMusicPad;
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
}

- (void) play {
    if (isPlaying) {
        isPlaying = NO;
        timeSinceLastBeat = 1.0;
        [self unscheduleUpdate];
    }
    else {
        isPlaying = YES;
        beatNum = 7;
        [self scheduleUpdate];
    }
}

- (void) update:(ccTime)delta {
    timeSinceLastBeat += delta;
    
    if (timeSinceLastBeat >= BEAT_TIME) {
        timeSinceLastBeat = 0;
        for (int i = 0; i < COLUMNS_NUM; i++) {
            MusicPad *currentMusicPad = [[musicPadArray objectAtIndex:beatNum] objectAtIndex:i];
            [currentMusicPad play];
        }
        beatNum--;
        if (beatNum < 0) {
            beatNum = 7;
        }
    }
}

- (void) dealloc {
    [musicPadArray release];
    
    [super dealloc];
}

@end
