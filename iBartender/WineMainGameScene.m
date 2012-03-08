//
//  WineMainGameScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineMainGameScene.h"
#import "WineGameScene.h"
#import "WineGameGlassLayer.h"
#import "WineGameShakeScene.h"
#import "SimpleAudioEngine.h"


@implementation WineMainGameScene

- (id)init {
	if( (self = [super init]) ){
		[self addChild:[WineMainGameLayer node]];
	}
	return self;
}

@end

@implementation WineMainGameLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
//        [[SimpleAudioEngine sharedEngine]preloadEffect:@"water.wav"];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  
        NSNumber *num = [NSNumber numberWithInt:0];
        [ud setValue:num forKey:@"sales"];
        isUseWine = NO;

        NSNumber* count = [ud objectForKey:@"selectedIndex"]; 
        selectedIndex = [count intValue];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"game.png"];
		[[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"winechoose_background.png"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background z:1];
        
        CCSprite *backgroundDesk = [CCSprite spriteWithSpriteFrameName:@"winechoose_desk.png"];
        backgroundDesk.position = ccp(160,31);
        [self addChild:backgroundDesk z:2];
        
//        CCSprite *backgroundShelf = [CCSprite spriteWithSpriteFrameName:@"glasschoose_shelf.png"];
//        backgroundShelf.position = ccp(160,400);
//        [self addChild:backgroundShelf z:2];
        
        CCSprite *backgroundLeftbottle = [CCSprite spriteWithSpriteFrameName:@"winechoose_leftbottle.png"];
        backgroundLeftbottle.position = ccp(98,130);
        [self addChild:backgroundLeftbottle z:2];
        
//        CCSprite *backgroundCover = [CCSprite spriteWithSpriteFrameName:@"glasschoose_cover.png"];
//        backgroundCover.position = ccp(98,248);
//        [self addChild:backgroundCover z:2];
//        if (selectedIndex == 0) {
//            selectedIndex = 1;
//            
//        }
        CCSprite *backgroundSelected = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_glass%d.png",selectedIndex]];
        backgroundSelected.position = ccp(245,110);
        if (selectedIndex == 3) {
            backgroundSelected.position = ccp(245,80);
        }
        backgroundSelected.tag = 10;
        [self addChild:backgroundSelected z:2];
        
        
        pageIndexArray = [[NSMutableArray alloc] init];
		
		[self initScrollLayer];
		
		[self initPageIndex:0 maxPage:5];

        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"winechoose_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"winechoose_back.png"] target:self selector:@selector(startBack:)];
        
        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"winechoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"winechoose_next.png"] target:self selector:@selector(startGo:)];

        CCMenu *menuHead = [CCMenu menuWithItems:back, go, nil];
        [menuHead alignItemsHorizontallyWithPadding:133];
        menuHead.position = ccp(160,465);
        [self addChild:menuHead z:3];
    }
    return self;
}

-(void)startBack:(id)sender
{
    [wineGameGlassLayer removeFromParentAndCleanup:YES];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3f scene:[WineGameScene node]]];
}

-(void)startGo:(id)sender
{
    if(!isUseWine)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"选好酒了吗？" message:@"你貌似没有选择任何酒哦" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"ice.mp3"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineGameShakeScene node]]];
}


- (void)testCallback:(id)sender
{
	int a;
	a = 1;
}

- (void)setPageIndex:(int)pageIndex
{
	if ([pageIndexArray objectAtIndex:pageIndex] == nil)
	{
		return;
	}
	
	for (CCLabelTTF *lab in pageIndexArray)
	{
		lab.color = ccGRAY;
	}
	
	((CCLabelTTF *)[pageIndexArray objectAtIndex:pageIndex]).color = ccWHITE;
}

- (void)onPageMoved:(WineGameGlassLayer *)scrollLayer
{
	[self setPageIndex:scrollLayer.currentScreen - 1];
}

- (void)initScrollLayer
{
	// get screen size
    //	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	/////////////////////////////////////////////////
	// PAGE 1
	////////////////////////////////////////////////
	// create a blank layer for page 1
	CCLayer *pageOne = [[CCLayer alloc] init];
	
	/////////////////////////////////////////////////
	// PAGE 2
	////////////////////////////////////////////////
	// create a blank layer for page 2
	CCLayer *pageTwo = [[CCLayer alloc] init];
	
	
	/////////////////////////////////////////////////
	// PAGE 3
	////////////////////////////////////////////////
	// create a blank layer for page 1
	CCLayer *pageThree = [[CCLayer alloc] init];
	
    
	
    
    //    // PAGE 4
    //	////////////////////////////////////////////////
    //	// create a blank layer for page 1
    	CCLayer *pageFour = [[CCLayer alloc] init];
    //	
    //    // PAGE 5
    //	////////////////////////////////////////////////
    //	// create a blank layer for page 1
    	CCLayer *pageFive = [[CCLayer alloc] init];
    
	// now create the wineStoreScrollLayer and pass-in the pages (set widthOffset to 0 for fullscreen pages)
	wineGameGlassLayer = [[WineGameGlassLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,pageThree, pageFour, pageFive,nil] widthOffset: 0 WithScene:self];
	// finally add the wineStoreScrollLayer to your scene
	[self addChild:wineGameGlassLayer z:10];
    
	
	// page moved delegate
	{
		NSMethodSignature* signature = 
		[[self class] instanceMethodSignatureForSelector:@selector(onPageMoved:)];
		
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
		
		[invocation setTarget:self];
		[invocation setSelector:@selector(onPageMoved:)];
		
		wineGameGlassLayer.onPageMoved = invocation;
	}
}

- (void)initPageIndex:(int)defaultPage    //--下方的小点
			  maxPage:(int)maxPage
{
	CGPoint indexPos = ccp(125, 480);
	CGPoint offsetPos = ccp(20, 0);
	for (int i = 0; i < maxPage; ++i)
	{
		CCLabelTTF *lab = [CCLabelTTF labelWithString:@"." 
											 fontName:@"Arial" 
											 fontSize:64];
		
		lab.position = ccpAdd(indexPos, ccpMult(offsetPos, i));
		[self addChild:lab z:10];
		[pageIndexArray addObject:lab]; 
	}
	
	[self setPageIndex:defaultPage];
}

-(void)setUseWine
{
    isUseWine = YES;
}



@end
