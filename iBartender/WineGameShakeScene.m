//
//  WineGameShakeScene.m
//  iBartender
//
//  Created by again on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineGameShakeScene.h"
#import "WineGameDoneScene.h"
#import "WineGameSellScene.h"
#import "SimpleAudioEngine.h"




@implementation WineGameShakeScene

-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineGameShakeLayer node]];
	}
	return self;   
}

@end

@implementation WineGameShakeLayer

-(id)init
{
    if ((self = [super init])) {
        CCSpriteFrameCache* sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        [sfc removeUnusedSpriteFrames];
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        isShake = NO;
        isAlert = NO;
        self.isAccelerometerEnabled = YES;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"shakePage.plist"];
        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"shakePage.png"];
        [[_backgroundLayer texture] setAliasTexParameters];
		[self addChild:_backgroundLayer];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"shakepage_background.png"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background z:1];
        
        CCSprite *bottle = [CCSprite spriteWithSpriteFrameName:@"shakepage_bottle.png"];
        bottle.position = ccp(160, 205);
        [self addChild:bottle z:2];
        bottle.tag = 10;
        
        CCSprite *text = [CCSprite spriteWithFile:@"shakepage_text.png"];
        text.position = ccp(160, 400);
        [self addChild:text z:2];
        CCRotateBy* rotate1 = [CCRotateBy actionWithDuration:0.15f angle:30];
        CCRotateBy* rotate2 = [CCRotateBy actionWithDuration:0.15f angle:-30];
        CCRotateBy* rotate3 = [CCRotateBy actionWithDuration:0.15f angle:-30];
        CCRotateBy* rotate4 = [CCRotateBy actionWithDuration:0.15f angle:30];
        CCSequence *actions = [CCSequence actions:rotate1, rotate2, rotate3, rotate4, nil];
        [text runAction:[CCRepeat actionWithAction:actions times:4]];
        
//        [self clearActions];
    }
    return self;
}

//-(void)startBack:(id)sender
//{
////	[[CCDirector sharedDirector] replaceScene:[CCTransitionSplitRows transitionWithDuration:1.0f scene:[WineMenuScene node]]];
//}

-(void)startGo:(id)sender
{
    
}

-(void)actionBottle:(id)sender
{
    if (isShake) {
        return;
    }
    CCSprite *tBottle = (CCSprite *)[self getChildByTag:10];
    CCRotateBy* rotate1 = [CCRotateBy actionWithDuration:0.05f angle:30];
    CCRotateBy* rotate2 = [CCRotateBy actionWithDuration:0.05f angle:-30];
    CCRotateBy* rotate3 = [CCRotateBy actionWithDuration:0.05f angle:-30];
    CCRotateBy* rotate4 = [CCRotateBy actionWithDuration:0.05f angle:30];
    CCSequence *actions = [CCSequence actions:rotate1, rotate2, rotate3, rotate4, nil];
    isShake = YES;
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"ice.mp3"];
    [tBottle runAction:[CCRepeat actionWithAction:actions times:20]];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    static NSInteger shakeCount = 0;
    static NSDate *shakeStart;
    if (isShake) {
        return;
    }
    
    NSDate *now = [[NSDate alloc]init];
    
    NSDate *checkDate = [[NSDate alloc]initWithTimeInterval:2.0f sinceDate:shakeStart];
    
    if ([now compare:checkDate]==NSOrderedDescending||shakeStart==nil){
        shakeCount = 0;
        [shakeStart release];
        shakeStart = [[NSDate alloc]init];
    }
    [now release];
    [checkDate release];
    if (fabsf(acceleration.x)>2.0 || fabsf(acceleration.y)>2.0|| fabsf(acceleration.z)>2.0){
        shakeCount++;
        if (shakeCount > 1) {
            shakeCount = 0;
            [shakeStart release];
            shakeStart = [[NSDate alloc]init];
//            [(CCLabelTTF *)[self getChildByTag:1001] setString:@"Shake the World"];
            
            [self performSelector:@selector(actionBottle:)];
            [NSTimer scheduledTimerWithTimeInterval:4.3f target:self selector:@selector(clearActions) userInfo:nil repeats:NO];
        }
    }
//    CCSprite *tBottle = (CCSprite *)[self getChildByTag:10];
//    CGPoint sPoint = tBottle.position;
//    if(sPoint.y >= 250)
//        sPoint.y -= acceleration.y*10;
//    else if(sPoint.y <250 && sPoint.y >= 150)
//        sPoint.y += acceleration.y*10;
//    if (sPoint.x >= 200) {
//        sPoint.x -= acceleration.x*10;
//    }
//    else
//        sPoint.x += acceleration.x*10;
//    
//    tBottle.position =sPoint;
}

-(void)clearActions
{
    isShake = NO;
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    if(!isAlert)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"摇酒过程已经结束" message:@"你觉得摇动均匀了吗?" delegate:self cancelButtonTitle:@"再摇一次" otherButtonTitles:@"可以了", nil];
        [alert show];
        [alert release];
        isAlert = YES;
    }
}

#pragma UIAlertViewDelegate
-(void)alertViewCancel:(UIAlertView *)alertView
{
  isAlert = NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            isAlert = NO;
            break;
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[WineGameDoneScene node]]];
            break;
            
            
        default:
            break;
    }
}

-(void)dealloc
{
    [super dealloc];
}


@end
