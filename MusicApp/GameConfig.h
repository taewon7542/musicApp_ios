//
//  GameConfig.h
//  MusicApp
//
//  Created by Taewon Kim
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

#define ROWS_NUM 8
#define COLUMNS_NUM 7
#define PADDING 2
#define BEAT_TIME 0.2

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationUIViewController

#endif // __GAME_CONFIG_H