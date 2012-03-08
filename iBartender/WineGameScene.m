//
//  WineGameScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineGameScene.h"
#import "WineMenuScene.h"
#import "WineMainGameScene.h"
#import "SimpleAudioEngine.h"


@implementation WineGameScene

- (id)init {
	if( (self = [super init]) ){
		[self addChild:[WineGameLayer node]];
	}
	return self;
}


@end


@implementation WineGameLayer

-(id)init {
    if ((self = [super init])) {
//        [self setIsTouchEnabled:YES];
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSNumber* count = [ud objectForKey:@"selectedIndex"]; 
        selectedIndex = [count intValue];

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"allCup.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"allCup.png"];
		[[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"glasschoose_background.png"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background z:1];
        
        CCSprite *backgroundDesk = [CCSprite spriteWithSpriteFrameName:@"glasschoose_desk.png"];
        backgroundDesk.position = ccp(160,31);
        [self addChild:backgroundDesk z:2];
        
        CCSprite *backgroundShelf = [CCSprite spriteWithSpriteFrameName:@"glasschoose_shelf.png"];
        backgroundShelf.position = ccp(160,400);
        [self addChild:backgroundShelf z:2];
        
        CCSprite *backgroundLeftbottle = [CCSprite spriteWithSpriteFrameName:@"glasschoose_leftbottle.png"];
        backgroundLeftbottle.position = ccp(98,130);
        

        [self addChild:backgroundLeftbottle z:2];
        
        CCSprite *backgroundCover = [CCSprite spriteWithSpriteFrameName:@"glasschoose_cover.png"];
        backgroundCover.position = ccp(98,248);
        [self addChild:backgroundCover z:2];
        
        CCSprite *backgroundSelected = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"glasschoose_glass%dbig.png",selectedIndex]];
        backgroundSelected.position = ccp(245,110);
        if (selectedIndex == 3) {
            backgroundSelected.position = ccp(245,80);
        }
        
        backgroundSelected.tag = 10;
        [self addChild:backgroundSelected z:2];
        
        CCMenuItemSprite *one = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass1small.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass1small.png"] target:self selector:@selector(selectGlass:)];
        one.tag = 101;
         CCMenuItemSprite *two = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass2small.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass2small.png"] target:self selector:@selector(selectGlass:)];
        two.tag = 102;
         CCMenuItemSprite *three = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass3small.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass3small.png"] target:self selector:@selector(selectGlass:)];
        three.tag = 103;
         CCMenuItemSprite *four = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass4small.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass4small.png"] target:self selector:@selector(selectGlass:)];
        four.tag = 104;
         CCMenuItemSprite *five = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass5small.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_glass5small.png"] target:self selector:@selector(selectGlass:)];
        five.tag = 105;
//        five.position = ccp(300, 400);
//        [self addChild:five];
        
        CCMenu *menuGlass = [CCMenu menuWithItems:one, two, three, four, five, nil];
        [menuGlass alignItemsHorizontallyWithPadding:20];
        menuGlass.position = ccp(160, 395);
        one.position = ccp(-117, -5.0);
        two.position = ccp(-55.0, -1.0);
        three.position = ccp(7.5, -14.0);
        four.position = ccp(66.0, 1.0);
        [self addChild:menuGlass z:3];
        NSLog(@"%f,%f",five.position.x,five.position.y);
//        NSLog(@"%f,%f",one.position.x,one.position.y);

        
        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_back.png"] target:self selector:@selector(startBack:)];
        
        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] target:self selector:@selector(startGo:)];
        CCMenu *menuHead = [CCMenu menuWithItems:back, go, nil];
        [menuHead alignItemsHorizontallyWithPadding:133];
        menuHead.position = ccp(160,465);
        [self addChild:menuHead z:3];
    }
    return self;
}

-(void)startBack:(id)sender
{
//    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"homePage.plist"];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3f scene:[WineMenuScene node]]];
}

-(void)startGo:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineMainGameScene node]]];
}

-(void)selectGlass:(id)sender
{
    int tag = [(CCMenuItem *)sender tag];
    NSLog(@"%d,%d",selectedIndex,tag);
    if (tag != selectedIndex+100) {
        CCSprite *tmp = (CCSprite *)[self getChildByTag:10];
        selectedIndex = tag - 100;
        [tmp removeFromParentAndCleanup:YES];
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    CCSprite *tmp2 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"glasschoose_glass%dbig.png",selectedIndex]];
        switch (tag) {
            case 101:
                tmp2.position = ccp(245,110);
                break;
            case 102:
                tmp2.position = ccp(245,115);
                break;
            case 103:
                tmp2.position = ccp(245, 85);
                break;
            case 104:
                tmp2.position = ccp(245,120);
                break;
            case 105:
                tmp2.position = ccp(245,120);
                break;
            default:
                break;
        }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithInt:selectedIndex] forKey:@"selectedIndex"]; 
      tmp2.tag = 10;
      [self addChild:tmp2 z:2];

    }
}

@end
