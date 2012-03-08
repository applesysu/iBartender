//
//  WineCollectionScene.h
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineCollectionScene : CCScene {
    
}

@end

@interface WineCollectionLayer : CCLayer {
    
    CCSpriteBatchNode	*_backgroundLayer;
    CCSprite *paperBackground;
    CCSprite *paper;
}
@end
