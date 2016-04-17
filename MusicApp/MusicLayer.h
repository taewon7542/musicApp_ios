//
//  MusicLayer.h
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MusicInterface;

@interface MusicLayer : CCLayer {
    MusicInterface *musicInterface;
}

+ (id) scene;

@end
