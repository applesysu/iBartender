//
//  WineStoreScrollLayer.h
//  iBartender
//
//  Created by again on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScrollLayer.h"

@interface WineStoreScrollLayer : CCLayer<UIAlertViewDelegate> {
    // Holds the current height and width of the screen
	int scrollHeight;
	int scrollWidth;
	
	// Holds the height and width of the screen when the class was inited
	int startHeight;
	int startWidth;
	
	// Holds the current page being displayed
	int currentScreen;
	
	// A count of the total screens available
	int totalScreens;
	
	// The initial point the user starts their swipe
	int startSwipe;
    
    BOOL isAlert;
    
    int freeLockNo;
	
	NSInvocation *onPageMoved;
}

@property (nonatomic, retain) NSInvocation *onPageMoved;

@property (nonatomic, readonly) int currentScreen;

-(id) initWithLayers:(NSMutableArray *)layers widthOffset: (int) widthOffset;
-(void) moveToPage:(int)page;
-(void)requestForBuy:(int)identifier;
@end
