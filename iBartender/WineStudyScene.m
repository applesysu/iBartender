//
//  WineStudyScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineStudyScene.h"
#import "WineMenuScene.h"
#import "SimpleAudioEngine.h"


@implementation WineStudyScene

-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineStudyLayer node]];
	}
	return self;   
}

@end

@implementation WineStudyLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"studyPage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"studyPage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"teachpage.png"];
        background.position = ccp(160, 240);
        [self addChild:background z:1];

        
        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"teachpage_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"teachpage_back.png"] target:self selector:@selector(startBack:)];
//        
//        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] target:self selector:@selector(startGo:)];
        CCMenu *menuHead = [CCMenu menuWithItems:back, nil];
        [menuHead alignItemsHorizontallyWithPadding:133];
        menuHead.position = ccp(275,465);
        [self addChild:menuHead z:3];
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
