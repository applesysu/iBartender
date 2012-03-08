//
//  WineMenuScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineMenuScene.h"
#import "WineGameScene.h"
#import "WineAboutScene.h"
#import "WineStoreScene.h"
#import "WineCollectionScene.h"
#import "WineStudyScene.h"
#import "SimpleAudioEngine.h"


@implementation WineMenuScene
#pragma mark -
#pragma mark NSObject


- (id)init {
	if( (self = [super init]) ){
		[self addChild:[WineMenuLayer node]];
	}
	return self;
}


@end

@implementation WineMenuLayer


#pragma mark -
#pragma mark NSObject


- (id)init {
	
	if( (self = [super init]) ){
//		[self setIsTouchEnabled: YES];
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"click.caf"];
        if(![[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying])
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Taikutsu.mp3"];
//        CGSize _winSize = [[CCDirector sharedDirector] winSize];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"homePage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"homePage.png"];
		[[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"homepage_blackground.png"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background z:1];
        
        
        
        CCSprite *backgroundText = [CCSprite spriteWithSpriteFrameName:@"homepage_text.png"];
        backgroundText.position = ccp(212,275);
        [self addChild:backgroundText z:2];
        
        CCSprite *backgroundDesk = [CCSprite spriteWithSpriteFrameName:@"homepage_desk.png"];
        backgroundDesk.position = ccp(160,31);
        [self addChild:backgroundDesk z:2];
        
        CCSprite *backgroundWine = [CCSprite spriteWithSpriteFrameName:@"homepage_wine.png"];
        backgroundWine.position = ccp(80,135);
        [self addChild:backgroundWine z:2];
        
        CCSprite *backgroundTitle = [CCSprite spriteWithSpriteFrameName:@"homepage_title.png"];
        backgroundTitle.position = ccp(160,355);
        [self addChild:backgroundTitle z:2];

        
        CCMenuItemSprite *play = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_game.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_game.png"] target:self selector:@selector(startGame:)];
        
        CCMenuItemSprite *study = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_teach.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_teach.png"] target:self selector:@selector(startStudy:)];
        CCMenuItemSprite *collect = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_favor.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_favor.png"] target:self selector:@selector(startCollection:)];
        CCMenuItemSprite *store = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_shop.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_shop.png"] target:self selector:@selector(startStore:)];
        CCMenuItemSprite *about = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_about.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"homepage_button_about.png"] target:self selector:@selector(startAbout:)];
        
        CCMenu *menuUp = [CCMenu menuWithItems:play, study, nil];
        [menuUp alignItemsVerticallyWithPadding:5];
        menuUp.position = ccp(212,225);
        [self addChild:menuUp z:2];
        
        CCMenu *menuDown = [CCMenu menuWithItems:collect, store, about, nil];
        [menuDown alignItemsVerticallyWithPadding:5];
        menuDown.position = ccp(212,135);
        [self addChild:menuDown z:2];
        
        
	}
	
	return self;
}

-(void)startGame:(id)sender
{
//    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"allCup.plist"];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineGameScene node]]];

}

-(void)startStudy:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineStudyScene node]]];
}

-(void)startCollection:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineCollectionScene node]]];
}

-(void)startStore:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineStoreScene node]]];
}

-(void)startAbout:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineAboutScene node]]];
}

@end
