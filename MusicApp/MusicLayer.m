//
//  MusicLayer.m
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicLayer.h"
#import "MusicInterface.h"
#import "SimpleAudioEngine.h"

@implementation MusicLayer

+ (id) scene {
    CCScene *scene = [CCScene node];
    MusicLayer *musicLayer = [MusicLayer node];
    [scene addChild:musicLayer];
    return scene;
}

- (id) init {
    if ((self = [super init])) {
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(255, 0, 0, 0)];
        //background.color = ccWHITE;
        [self addChild:background];
        
        for (int i = 0; i < 7; i++) {
            NSString *audioFileName = [NSString stringWithFormat:@"%i.mp3"];
            [[SimpleAudioEngine sharedEngine] preloadEffect:audioFileName];
        }
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        musicInterface = [MusicInterface musicInterface];
        musicInterface.position = ccp((winSize.width - musicInterface.boardWidth) / 2, (winSize.height - musicInterface.boardHeight) / 2 + 25);
        [self addChild:musicInterface];
        
        CCMenuItemImage *buttonItem = [CCMenuItemImage itemFromNormalImage:@"playButton.png" selectedImage:nil target:musicInterface selector:@selector(play)];
        CCMenu *buttonMenu = [CCMenu menuWithItems:buttonItem, nil];
        buttonMenu.position = ccp(winSize.width / 2, 40);
        [self addChild:buttonMenu];
    }
    return self;
}

@end
