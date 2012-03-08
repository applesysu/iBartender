//
//  WineMenuScene.h
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineMenuScene : CCScene {
    
}

@end


@interface WineMenuLayer : CCLayer {
    CCSpriteBatchNode	*_backgroundLayer;
    BOOL isBackgroungMusicRunning;
}

@end
