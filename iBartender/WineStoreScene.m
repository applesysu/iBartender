//
//  WineStoreScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineStoreScene.h"
#import "WineMenuScene.h"
#import "WineStoreScrollLayer.h"
#import "SimpleAudioEngine.h"


@implementation WineStoreScene

-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineStoreLayer node]];
	}
	return self;   
}

@end

@implementation WineStoreLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"shopPage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"shopPage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"shoppage_background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"shoppage_title.png"];
        title.position = ccp(160, 440);
        [self addChild:title z:2];
        
        CCSprite *money = [CCSprite spriteWithSpriteFrameName:@"shoppage_money.png"];
        money.position = ccp(248, 25);
        [self addChild:money z:2];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSNumber *num = [ud objectForKey:@"money"];
        int t = [num intValue];
        CCLabelTTF *testLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",t] fontName:@"SEGOESC.TTF" fontSize:17];
//        CCLabelTTF *testLabel = [CCLabelTTF labelWithString:@"200" fontName:@"SEGOESC.TTF" fontSize:17];
        [testLabel setColor:ccc3(247, 215, 103)];
//        
        testLabel.position = ccp(253,25);
        testLabel.tag = 21;
        [self addChild:testLabel z:10];
        
        
        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"shoppage_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"shoppage_back.png"] target:self selector:@selector(startBack:)];
//        
//        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] target:self selector:@selector(startGo:)];
        CCMenu *menuHead = [CCMenu menuWithItems:back, nil];
//        [menuHead alignItemsHorizontallyWithPadding:133];
        menuHead.position = ccp(53,27);
        [self addChild:menuHead z:3];
        
        pageIndexArray = [[NSMutableArray alloc] init];
		
		[self initScrollLayer];
		
		[self initPageIndex:0 maxPage:3];

        
    }
    return self;
}

-(void)startBack:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    [wineStoreScrollLayer removeAllChildrenWithCleanup:YES];
    [wineStoreScrollLayer removeFromParentAndCleanup:YES];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3f scene:[WineMenuScene node]]];
}

-(void)startGo:(id)sender
{
    
}

- (void)testCallback:(id)sender
{
	int a;
	a = 1;
}

-(void)setMoney:(int)newValue
{
    CCLabelTTF *tmpLable = (CCLabelTTF *)[self getChildByTag:21];
    [tmpLable setString:[NSString stringWithFormat:@"%d",newValue]];
    
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

- (void)onPageMoved:(WineStoreScrollLayer *)scrollLayer
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
//	CCLayer *pageFour = [[CCLayer alloc] init];
//	
//    // PAGE 5
//	////////////////////////////////////////////////
//	// create a blank layer for page 1
//	CCLayer *pageFive = [[CCLayer alloc] init];
    
	// now create the wineStoreScrollLayer and pass-in the pages (set widthOffset to 0 for fullscreen pages)
	wineStoreScrollLayer = [[WineStoreScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,pageThree,nil] 
                                                 widthOffset: 0];
	
	// finally add the wineStoreScrollLayer to your scene
	[self addChild:wineStoreScrollLayer];
    
	
	// page moved delegate
	{
		NSMethodSignature* signature = 
		[[self class] instanceMethodSignatureForSelector:@selector(onPageMoved:)];
		
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
		
		[invocation setTarget:self];
		[invocation setSelector:@selector(onPageMoved:)];
		
		wineStoreScrollLayer.onPageMoved = invocation;
	}
}

- (void)initPageIndex:(int)defaultPage    //--下方的小点
			  maxPage:(int)maxPage
{
	CGPoint indexPos = ccp(120, 40);
	CGPoint offsetPos = ccp(20, 0);
	for (int i = 0; i < maxPage; ++i)
	{
		CCLabelTTF *lab = [CCLabelTTF labelWithString:@"." 
											 fontName:@"Arial" 
											 fontSize:64];
		
		lab.position = ccpAdd(indexPos, ccpMult(offsetPos, i));
		[self addChild:lab];
		[pageIndexArray addObject:lab]; 
	}
	
	[self setPageIndex:defaultPage];
}


@end
