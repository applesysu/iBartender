//
//  WineGameShakeScene.h
//  iBartender
//
//  Created by again on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineGameShakeScene : CCScene {
    
}

@end

@interface WineGameShakeLayer : CCLayer<UIAccelerometerDelegate,UIAlertViewDelegate> {
    CCSpriteBatchNode	*_backgroundLayer;
    BOOL isShake;
    BOOL isAlert;
}

-(void)clearActions;
@end
