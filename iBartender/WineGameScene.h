//
//  WineGameScene.h
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineGameScene : CCScene {
    
}

@end

@interface WineGameLayer : CCLayer {
    CCSpriteBatchNode	*_backgroundLayer;
    int selectedIndex;
}
@end
