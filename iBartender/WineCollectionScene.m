//
//  WineCollectionScene.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineCollectionScene.h"
#import "WineMenuScene.h"
#import "SimpleAudioEngine.h"


@implementation WineCollectionScene

-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineCollectionLayer node]];
	}
	return self;   
}

@end

@implementation WineCollectionLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"favorPage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"favorPage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"favorpage_background.png"];
        background.position = ccp(160, 240);
        [self addChild:background z:1];
        
        CCSprite *title = [CCSprite spriteWithSpriteFrameName:@"favorpage_title.png"];
        title.position = ccp(160, 434);
        [self addChild:title z:2];
        
        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"favorpage_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"favorpage_back.png"] target:self selector:@selector(startBack:)];
        
        CCMenuItemSprite *about = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"favorpage_about.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"favorpage_about.png"] target:self selector:@selector(startGo:)];
        CCMenu *menuHead = [CCMenu menuWithItems:back, about, nil];
        [menuHead alignItemsHorizontallyWithPadding:173];
        menuHead.position = ccp(160,445);
        [self addChild:menuHead z:1];
        
        CCSprite *shelf = [CCSprite spriteWithSpriteFrameName:@"favorpage_shelf.png"];
        shelf.position = ccp(160, 196);
        [self addChild:shelf z:2];
        
//        CCSprite *book1 = [CCSprite spriteWithSpriteFrameName:@"favorpage_book01.png"];
//        book1.position = ccp(35, 335);
//        [self addChild:book1 z:3];
//        
//        CCSprite *book2 = [CCSprite spriteWithSpriteFrameName:@"favorpage_book02.png"];
//        book2.position = ccp(55, 335);
//        [self addChild:book2 z:3];
        for(int i = 0; i < 4; i++)
        {
            CCMenuItem *book1 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+1]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+1]] target:self selector:@selector(showPaper:)];
            book1.tag = 1001+i*10;
           CCMenuItem *book2 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+2]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+2]] target:self selector:@selector(showPaper:)];
            book2.tag = 1002+i*10;
            CCMenuItem *book3 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+3]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+3]] target:self selector:@selector(showPaper:)];
            book3.tag = 1003+i*10;
            CCMenuItem *book4 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+4]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+4]] target:self selector:@selector(showPaper:)];
            book4.tag = 1004+i*10;
            CCMenuItem *book5 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+5]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+5]] target:self selector:@selector(showPaper:)];
            book5.tag = 1005+i*10;
            CCMenuItem *book6 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+6]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+6]] target:self selector:@selector(showPaper:)];
            book6.tag = 1006+i*10;
            CCMenuItem *book7 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+7]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+7]] target:self selector:@selector(showPaper:)];
            book7.tag = 1007+i*10;
            CCMenuItem *book8 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+8]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+8]] target:self selector:@selector(showPaper:)];
            book8.tag = 1008+i*10;
            CCMenuItem *book9 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+9]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+9]] target:self selector:@selector(showPaper:)];
            book9.tag = 1009+i*10;
            if(i < 3)
            {
                CCMenuItem *book10 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+10]] selectedSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"favorpage_book%.2d.png",i*10+10]] target:self selector:@selector(showPaper:)];
                book10.tag = 1010+i*10;
                
                CCMenu *bookMenu = [CCMenu menuWithItems:book1, book2, book3, book4, book5, book6, book7, book8, book9, book10, nil];
                switch (i) {
                    case 0:
                        [bookMenu alignItemsHorizontallyWithPadding:-8.5f];
                        break;
                    case 1:
                        [bookMenu alignItemsHorizontallyWithPadding:-0.5f];
                        break;
                    case 2:
                        [bookMenu alignItemsHorizontallyWithPadding:-0.5f];
                        break;
                        
                    default:
                        break;
                }
                
                bookMenu.position = ccp(160, 335-i*93);
                bookMenu.tag = 10+i;
                [self addChild:bookMenu z:3];
            }
            else
            {
                CCMenu *bookMenu = [CCMenu menuWithItems:book1, book2, book3, book4, book5, book6, book7, book8, book9, nil];
                [bookMenu alignItemsHorizontallyWithPadding:-1.0f];
                bookMenu.tag = 10+i;
                bookMenu.position = ccp(185, 335-i*93);
                [self addChild:bookMenu z:3];
                book7.position = ccp(22, book7.position.y);
                book8.position = ccp(54, book8.position.y);
                book9.position = ccp(85, book9.position.y);
//                NSLog(@"x = %f; x = %f; x = %f",book7.position.x,book8.position.x,book9.position.x);
            }
        }
                
    }
    return self;
}

-(void)showPaper:(id)sender
{
    NSLog(@"tag = %d",[sender tag]);
    for (int i = 10; i <= 13; i++) {
        CCMenu *tmpMenu = (CCMenu *)[self getChildByTag:i];
        for (CCMenuItem *child in [tmpMenu children]) {
            [child setIsEnabled:NO];
        }
    }
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    int tag = [sender tag]-1000;
    paper = [CCSprite spriteWithFile:[NSString stringWithFormat:@"favorpage_paper%.2d.png",tag]];
    paper.position = ccp(160, 200);
    paperBackground = [CCSprite spriteWithFile:@"favorpage_gray.png"];
    paperBackground.position = ccp(160, 240);
    
    [self addChild:paperBackground z:4];
//    [paper runAction:[CCEaseOut actionWithDuration:1.0f]];
    [self addChild:paper z:5];
    
    CCMenuItem *cha = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"favorpage_close.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"favorpage_close.png"] target:self selector:@selector(removePaper:)];
    CCMenu *chaMenu = [CCMenu menuWithItems:cha, nil];
    chaMenu.tag = 30;
    chaMenu.position = ccp(265, 346);
    [self addChild:chaMenu z:5];
    
}

-(void)removePaper:(id)sender
{
//    [sender removeFromParentAndCleanup:YES];
    [self removeChildByTag:30 cleanup:YES];
    [paper removeFromParentAndCleanup:YES];
    [paperBackground removeFromParentAndCleanup:YES];
//    CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
//    [sfc removeUnusedSpriteFrames];
//    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    for (int i = 10; i <= 13; i++) {
        CCMenu *tmpMenu = (CCMenu *)[self getChildByTag:i];
        for (CCMenuItem *child in [tmpMenu children]) {
            [child setIsEnabled:YES];
        }
    }
}

-(void)startBack:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.3f scene:[WineMenuScene node]]];
}

-(void)startGo:(id)sender
{
    for (int i = 10; i <= 13; i++) {
        CCMenu *tmpMenu = (CCMenu *)[self getChildByTag:i];
        for (CCMenuItem *child in [tmpMenu children]) {
            [child setIsEnabled:NO];
        }
    }
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
    paper = [CCSprite spriteWithFile:@"favorpage_notice.png"];
    paper.position = ccp(160, 200);
    paperBackground = [CCSprite spriteWithFile:@"favorpage_gray.png"];
    paperBackground.position = ccp(160, 240);
    
    [self addChild:paperBackground z:4];
    //    [paper runAction:[CCEaseOut actionWithDuration:1.0f]];
    [self addChild:paper z:5];
    
    CCMenuItem *cha = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"favorpage_close.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"favorpage_close.png"] target:self selector:@selector(removePaper:)];
    CCMenu *chaMenu = [CCMenu menuWithItems:cha, nil];
    chaMenu.tag = 30;
    chaMenu.position = ccp(265, 346);
    [self addChild:chaMenu z:5];
    
}

@end
