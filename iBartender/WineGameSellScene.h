//
//  WineGameSellScene.h
//  iBartender
//
//  Created by again on 2/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WineGameSellScene : CCScene {
    
}

@end

@interface WineGameSellLayer : CCLayer<UIPickerViewDelegate,UIPickerViewDataSource> {
    CCSpriteBatchNode	*_backgroundLayer;
    NSArray *pickerValues;
}

@property(nonatomic,retain)NSArray *pickerValues;
@end
