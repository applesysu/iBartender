//
//  WineMainGameScene.h
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class WineGameGlassLayer;

@interface WineMainGameScene : CCScene {
    
}

@end

@interface WineMainGameLayer : CCLayer<UIAlertViewDelegate> {
    NSMutableArray *pageIndexArray;
    CCSprite *wine_flow;
    CCSpriteBatchNode *_wineFlow;
    CCSpriteBatchNode	*_backgroundLayer;
    int selectedIndex;
    WineGameGlassLayer *wineGameGlassLayer;
    BOOL isUseWine;

}

- (void)initScrollLayer;
- (void)initPageIndex:(int)defaultPage maxPage:(int)maxPage;
@end
