//
//  WineStoreScene.h
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class WineStoreScrollLayer;

@interface WineStoreScene : CCScene {
    
}

@end

@interface WineStoreLayer : CCLayer {
    NSMutableArray *pageIndexArray;
    CCSpriteBatchNode	*_backgroundLayer;
    WineStoreScrollLayer *wineStoreScrollLayer;
}

- (void)initScrollLayer;
- (void)initPageIndex:(int)defaultPage maxPage:(int)maxPage;

@end
