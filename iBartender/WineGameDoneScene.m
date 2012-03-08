//
//  WineGameDoneScene.m
//  iBartender
//
//  Created by again on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineGameDoneScene.h"
#import "WineGameSellScene.h"
#import "WineMenuScene.h"
#import "SimpleAudioEngine.h"

@implementation WineGameDoneScene
-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineGameDoneLayer node]];
	}
	return self;   
}

@end

@implementation WineGameDoneLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSNumber *num = [ud objectForKey:@"sales"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:@"water.wav"];

        sales = [num intValue];
        isBackToMenu = NO;
        randomTimes = arc4random()%3;
        NSLog(@"%d",randomTimes);
        
        NSNumber* count = [ud objectForKey:@"selectedIndex"]; 
        bottleKind = [count intValue];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pourPage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"pourPage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"pourpage_background.png"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background z:1];
        
        CCSprite *decoration = [CCSprite spriteWithFile:@"pourpage_decoration.png"];
        decoration.position = ccp(160, 440);
        [self addChild:decoration z:2];
        
        CCSprite *desk = [CCSprite spriteWithSpriteFrameName:@"pourpage_desk.png"];
        desk.position = ccp(160, 50);
        [self addChild:desk z:2];
        
        CCSprite *cover = [CCSprite spriteWithSpriteFrameName:@"pourpage_cover.png"];
        cover.position = ccp(80, 80);
        cover.tag = 11;
        [self addChild:cover z:3];
        
        CCMenuItem *one = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_back.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_back.png"] target:self selector:@selector(backToMain:)];
//        CCMenuItem *two = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_favor.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_favor.png"] target:self selector:@selector(backToMain:)];
        CCMenuItem *three = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_sell.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"pourpage_sell.png"] target:self selector:@selector(sellWine:)];
        
        menuBar = [CCMenu menuWithItems:one, three, nil];
        [menuBar alignItemsHorizontallyWithPadding:60];
        
        menuBar.position = ccp(160, -18);
        [self addChild:menuBar z:3];
        

        [self actionPourWine:bottleKind];
        
    }
    return self;
}

-(void)actionPourWine:(int)tag
{

    CCAnimation *Pour = [[[CCAnimation alloc]init]autorelease];
    for (int i = 1; i <= 9; i++)
	{
		[Pour addFrameWithFilename:[NSString stringWithFormat:@"glass%dpour_%.2d.png", tag,i]];
	}
    Pour.delay = 0.4f;
    wine_pour = [CCSprite spriteWithFile:[NSString stringWithFormat:@"glass%dpour_01.png",tag]];
    switch (bottleKind) {
        case 1:
            wine_pour.position = ccp(160, 210);
            break;
        case 2:
            wine_pour.position = ccp(160, 210);
            break;
        case 3:
            wine_pour.position = ccp(160, 195);
            break;
        case 4:
            wine_pour.position = ccp(160, 210);
            break;
        case 5:
            wine_pour.position = ccp(160, 210);
            break;
            
            
        default:
            break;
    }
//    wine_pour.position = ccp(160, 210);
    id flowAction = [CCAnimate actionWithAnimation:Pour restoreOriginalFrame:NO];
    CCSequence *all = [CCSequence actionOne:flowAction two:[CCHide action]];
    [wine_pour runAction:all];
//    [wine_pour runAction:flowAction];
    [self addChild:wine_pour z:3];
    
    CCSprite *bottleAll = [CCSprite spriteWithFile:@"pourpage_bottlefly.png"];
    switch (bottleKind) {
        case 1:
            bottleAll.position = ccp(125, 329);
            break;
        case 2:
            bottleAll.position = ccp(135, 329);
            break;
        case 3:
            bottleAll.position = ccp(138, 270);
            break;
        case 4:
            bottleAll.position = ccp(138, 329);
            break;
        case 5:
            bottleAll.position = ccp(138, 329);
            break;
            
        default:
            break;
    }
    
    //        bottleAll.position = ccp(100, 215);
    bottleAll.tag = 13;
    [bottleAll runAction:[CCHide action]];
    [self addChild:bottleAll z:9];
    [[SimpleAudioEngine sharedEngine]playEffect:@"water.wav"];
    [self schedule:@selector(removeWine:)];
    
}

-(void)wineFly
{
//    [self removeChildByTag:11 cleanup:YES];
    
    CCSprite *bottle = (CCSprite *)[self getChildByTag:13];
    CCSprite *cover = (CCSprite *)[self getChildByTag:11];
    [bottle runAction:[CCShow action]];
    [bottle runAction:[CCMoveTo actionWithDuration:0.5f position:ccp(-90, bottle.position.y)]];
    [cover runAction:[CCMoveTo actionWithDuration:0.5f position:ccp(-90, cover.position.y)]];
    CCSprite *wineEX = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"pourpage_glass%d.png",bottleKind]];
    wineEX.position = ccp(219, 136);
    [self addChild:wineEX z:9];
    CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
    [sfc removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [wineEX runAction:[CCMoveTo actionWithDuration:1.0f position:ccp(160, 230)]];
}

-(void)removeWine:(id)sender
{
    if (!wine_pour.visible) {
        [wine_pour removeFromParentAndCleanup:YES];
        [self unschedule:@selector(removeWine:)];
        [[SimpleAudioEngine sharedEngine]stopEffect:2];
        [self menuBarMove];
    }
    
}

-(void)menuBarMove
{
    [menuBar runAction:[CCMoveTo actionWithDuration:1.0f position:ccp(160, 43)]];
    [self wineFly];
}

//-(void)startBack:(id)sender
//{
//	[[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0f scene:[WineMenuScene node]]];
//}

-(void)backToMain:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineMenuScene node]]];
}

-(void)sellWine:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"你希望以$%d出售你挑出来的酒吗?",sales] message:@"出售 tips:你可以加价的，觉得价钱不合适，加价有风险哦" delegate:self cancelButtonTitle:@"再想想" otherButtonTitles:@"成交", @"加价", nil];
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            if (isBackToMenu) {
                [self performSelector:@selector(backToMain:)];
            }
            break;
        case 1:
            [self dealForSales];
//            [self performSelector:@selector(backToMain:)];
            break;
        case 2:
            [self askForMore];
            break;            
        default:
            break;
    }
}

-(void)dealForSales
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int money = [[ud objectForKey:@"money"] intValue];
    money += sales;
    NSNumber *tmpNo = [NSNumber numberWithInt:money];
    [ud setValue:tmpNo forKey:@"money"];
    UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:@"成交" message:[NSString stringWithFormat:@"你以$%d出售了你调的酒", sales]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    isBackToMenu = YES;
    [alert3 show];
    [alert3 release];
}

-(void)askForMore
{
    if (randomTimes == 0) {
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"加价失败" message:[NSString stringWithFormat:@"你只能以$%d出售你调出来的酒了，下次见好就收了哦",sales/2] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        int money = [[ud objectForKey:@"money"] intValue];
        money += sales/2;
        NSNumber *tmpNo = [NSNumber numberWithInt:money];
        [ud setValue:tmpNo forKey:@"money"];
        isBackToMenu = YES;
        [alert1 show];
        [alert1 release];
        return;
        
    }
    randomTimes--;
    int random = arc4random()%50+1;
    sales += random;
    UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"你希望以$%d出售你挑出来的酒吗?",sales] message:@"出售 tips:你可以加价的，觉得价钱不合适，加价有风险哦" delegate:self cancelButtonTitle:@"再想想" otherButtonTitles:@"成交", @"加价", nil];
    [alert2 show];
    [alert2 release];
}

-(void)startGo:(id)sender
{
    
}
@end
