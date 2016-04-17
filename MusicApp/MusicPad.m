//
//  MusicPad.m
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicPad.h"
#import "GameConfig.h"
#import "SimpleAudioEngine.h"


@implementation MusicPad

@synthesize indexX, indexY;

+ (id) musicPadWithIndexX:(int)x andIndexY:(int)y {
    return [[[MusicPad alloc] initMusicPadWithIndexX:x andIndexY:y] autorelease];
}

- (id) initMusicPadWithIndexX:(int)x andIndexY:(int)y {
    if ((self = [super initWithFile:@"button.png"])) {
        indexX = x;
        indexY = y;
        isOn = NO;
    }
    return self;
}

- (void) setAudioFile:(int)fileNum {
    [audioFileName release];
    audioFileName = [[NSString stringWithFormat:@"%i.mp3", fileNum] retain];
}

- (void) changeState {
    if (isOn) {
        self.color = ccWHITE;
        //self.color = ccc3(0, 0, 255);
    }
    else {
        //self.color = ccGREEN;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        if(self.position.x < winSize.width * 0.4)self.color = ccc3(0, 255, 255);
        else self.color = ccc3(255, 77 ,219);
    }
    
    isOn = !isOn;
}

- (void) play {
    if (isOn) {
        [[SimpleAudioEngine sharedEngine] playEffect:audioFileName];
    }
    CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:0.1 scale:1.05];
    CCScaleTo *scaleDown = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    CCSequence *scaleSequence = [CCSequence actions:scaleUp, scaleDown, nil];
    [self runAction:scaleSequence];
}

- (void) dealloc {
    [audioFileName release];
    
    [super dealloc];
}

@end
