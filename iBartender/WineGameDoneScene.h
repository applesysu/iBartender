//
//  WineGameDoneScene.h
//  iBartender
//
//  Created by again on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineGameDoneScene : CCScene {
    
}

@end

@interface WineGameDoneLayer : CCLayer<UIAlertViewDelegate> {

    CCSpriteBatchNode	*_backgroundLayer;
    CCSprite *wine_pour;
    CCSpriteBatchNode *_winePour;
    CCMenu *menuBar;
    int sales;
    int randomTimes;
    BOOL isBackToMenu;
    int bottleKind;
}

-(void)actionPourWine:(int)tag;
-(void)menuBarMove;
-(void)dealForSales;
-(void)askForMore;
@end
