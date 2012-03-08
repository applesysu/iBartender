//
//  WineAboutScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineAboutScene.h"
#import "WineMenuScene.h"
#import "SimpleAudioEngine.h"


@implementation WineAboutScene

- (id)init {
	if( (self = [super init]) ){
		[self addChild:[WineAboutLayer node]];
	}
	return self;
}

@end

@implementation WineAboutLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"aboutPage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"aboutPage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"aboutpage_background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"aboutpage_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"aboutpage_back.png"] target:self selector:@selector(startBack:)];
        CCSprite *paper = [CCSprite spriteWithSpriteFrameName:@"aboutpage_paper.png"];
        paper.position = ccp(160, 240);
        [self addChild:paper z:2];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"aboutpage_title.png"];
        title.position = ccp(242, 424);
        [self addChild:title z:3];
        
//        
//        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] target:self selector:@selector(startGo:)];
        CCMenu *menuHead = [CCMenu menuWithItems:back, nil];
//        [menuHead alignItemsHorizontallyWithPadding:133];
        menuHead.position = ccp(55,455);
        [self addChild:menuHead z:2];
    }
    return self;
}

-(void)startBack:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3f scene:[WineMenuScene node]]];
}

-(void)startGo:(id)sender
{
    
}

@end
