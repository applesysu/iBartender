//
//  WineStoreScrollLayer.m
//  iBartender
//
//  Created by again on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineStoreScrollLayer.h"
#import "CCScrollLayer.h"
#import "WineStoreScene.h"



@implementation WineStoreScrollLayer

@synthesize currentScreen;
@synthesize onPageMoved;

-(id) initWithLayers:(NSMutableArray *)layers widthOffset: (int) widthOffset
{
	
	if ( (self = [super init]) )
	{
		
		// Make sure the layer accepts touches
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
		// Set up the starting variables
		if(!widthOffset){
			widthOffset = 0;
		}	
		currentScreen = 1;
        
        freeLockNo = -1;
		
        isAlert = NO;
		// offset added to show preview of next/previous screens
		scrollWidth = [[CCDirector sharedDirector] winSize].width - widthOffset;
		scrollHeight = [[CCDirector sharedDirector] winSize].height;
		startWidth = scrollWidth;
		startHeight = scrollHeight;
		
		// Loop through the array and add the screens
		int i = 0;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *islock;
		for (CCLayer *l in layers)
		{
            l.contentSize = CGSizeMake(scrollWidth, 400);
			l.anchorPoint = ccp(0,0);
			l.position = ccp((i*scrollWidth),0);
            CCSprite *layerBackground = [CCSprite spriteWithSpriteFrameName:@"shoppage_color.png"];
//            layerBackground.anchorPoint = ccp(0, 0);
            layerBackground.position = ccp(160,220);
            [l addChild:layerBackground];
            
            CCSprite *wine1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",1+i*9]];
            
            
            wine1.position = ccp(65, 340);
            if (i == 2) {
                wine1.position = ccp(65, 333);
            }
            CCSprite *wine2 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",2+i*9]];
            wine2.position = ccp(160, 340);
            CCSprite *wine3 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",3+i*9]];
            wine3.position = ccp(255, 340);
            [l addChild:wine1];
            
            [l addChild:wine2];
            [l addChild:wine3];
            if(i < 2)
            {
                
                CCSprite *wine4 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",4+i*9]];
                wine4.position = ccp(65, 220);
                CCSprite *wine5 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",5+i*9]];
                wine5.position = ccp(160, 220);
                CCSprite *wine6 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",6+i*9]];
                wine6.position = ccp(255, 220);
                CCSprite *wine7 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",7+i*9]];
                wine7.position = ccp(65, 105);
                CCSprite *wine8 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",8+i*9]];
                wine8.position = ccp(160, 105);
                CCSprite *wine9 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",9+i*9]];
                wine9.position = ccp(255, 105);
                
                [l addChild:wine4];
                [l addChild:wine5];
                [l addChild:wine6];
                [l addChild:wine7];
                [l addChild:wine8];
                [l addChild:wine9];
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",4+i*9]];
                NSLog(@"%@",islock);
                NSLog(@"%d",[islock compare:@"YES"]);
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock4 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock4.position = ccp(64, 223);
                    lock4.tag = 104;
                    [l addChild:lock4];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",5+i*9]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock5 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock5.position = ccp(159, 223);
                    lock5.tag = 105;
                    [l addChild:lock5];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",6+i*9]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock6 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock6.position = ccp(254, 223);
                    lock6.tag = 106;
                    [l addChild:lock6];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",7+i*9]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock7 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock7.position = ccp(65, 110);
                    lock7.tag = 107;
                    [l addChild:lock7];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",8+i*9]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock8 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock8.position = ccp(160, 109);
                    lock8.tag = 108;
                    [l addChild:lock8];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",9+i*9]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock9 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                    lock9.position = ccp(255, 109);
                    lock9.tag = 109;
                    [l addChild:lock9];
                }
            }
            islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",1+i*9]];
            if([islock compare:@"YES"] == 0)
            {
                CCSprite *lock1 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                lock1.position = ccp(65, 338);
                lock1.tag = 101;
                [l addChild:lock1];
            }
            islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",2+i*9]];
            if([islock compare:@"YES"] == 0)
            {
                CCSprite *lock2 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                lock2.position = ccp(160, 338);
                lock2.tag = 102;
                [l addChild:lock2];
            }
            islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",3+i*9]];
            if([islock compare:@"YES"] == 0)
            {
                CCSprite *lock3 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
                lock3.position = ccp(255, 338);
                lock3.tag = 103;
                [l addChild:lock3];
            }
            l.tag = i+1;
			[self addChild:l];
			i=i+1;
			
		}
		
		// Setup a count of the available screens
		totalScreens = i;
//        [self moveToPage:2];
	}
	return self;
	
}

- (void)onPageMoved:(id)sender
{
	if (self.onPageMoved != nil)
	{
		[self.onPageMoved setArgument:&self atIndex:2];
		[self.onPageMoved invoke];
	}
}

-(void) moveToPage:(int)page
{
	id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.3 position:ccp(-((page-1)*scrollWidth),0)]];
	id actions = [CCSequence actions:
				  changePage,
				  [CCCallFunc actionWithTarget:self selector:@selector(onPageMoved:)],
				  nil];
	
	[self runAction:actions];
	currentScreen = page;
}

-(void) moveToNextPage
{
	id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.3 position:ccp(-(((currentScreen+1)-1)*scrollWidth),0)]];
	id actions = [CCSequence actions:
				  changePage,
				  [CCCallFunc actionWithTarget:self selector:@selector(onPageMoved:)],
				  nil];
	
	[self runAction:actions];
	currentScreen = currentScreen+1;
}

-(void) moveToPreviousPage
{
	id changePage = [CCEaseBounce actionWithAction:[CCMoveTo actionWithDuration:0.3 position:ccp(-(((currentScreen-1)-1)*scrollWidth),0)]];
	id actions = [CCSequence actions:
				  changePage,
				  [CCCallFunc actionWithTarget:self selector:@selector(onPageMoved:)],
				  nil];
	
	[self runAction:actions];
	currentScreen = currentScreen-1;
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	startSwipe = touchPoint.x;
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	self.position = ccp((-(currentScreen-1)*scrollWidth)+(touchPoint.x-startSwipe),0);
	
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	int newX = touchPoint.x;
    NSLog(@"newx = %d;startx = %d",newX,startSwipe);
//	NSLog(@"curentScreen = %d",currentScreen);
	if (newX <= startSwipe + 25 && newX >= startSwipe - 25 && !isAlert) {
        CCLayer *tmpLayer = (CCLayer *)[self getChildByTag:currentScreen];
        for( CCSprite *sprite in [tmpLayer children] ){
            if( [sprite tag] <= 0 ) continue;
            
            if( CGRectContainsPoint([sprite boundingBox], touchPoint) ){
                
                //                [sprite setColor:ccGREEN];
                //                [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
                NSLog(@"tag = %d",[sprite tag]);
                [self requestForBuy:[sprite tag]];
//                switch ([sprite tag]) {
//                    case 101:
//                        NSLog(@"101");
//                        [self requestForBuy:101];
////                        [self wineFlow:101];
//                        break;
//                    case 102:
//                        NSLog(@"102");
//                        [self requestForBuy:102];
////                        [self wineFlow:102];
//                        break;
//                    case 103:
//                        NSLog(@"103");
//                        [self requestForBuy:103];
////                        [self wineFlow:103];
//                        break;
//                    case 104:
//                        NSLog(@"104");
//                        [self requestForBuy:104];
////                        [self wineFlow:104];
//                        break;
//                    case 105:
//                        NSLog(@"105");
//                        [self requestForBuy:105];
////                        [self wineFlow:105];
//                        break;
//                    default:
//                        break;
//                }
                return;
            }
        }
    }
	
	if ( (newX - startSwipe) < -100 && (currentScreen+1) <= totalScreens )
	{
		
		[self moveToNextPage];
		
	}
	else if ( (newX - startSwipe) > 100 && (currentScreen-1) > 0 )
	{
		
		[self moveToPreviousPage];
		
	}
	else
	{
		
		[self moveToPage:currentScreen];
		
	}
	
}

-(void)requestForBuy:(int)identifier
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"购买调酒用酒" message:@"请问你是要买这瓶酒吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定购买", nil]autorelease];
    freeLockNo = identifier-100+(currentScreen-1)*9;
    NSLog(@"%d",freeLockNo);
    int money = [[ud objectForKey:@"money"]intValue];
    int wineMoney = [[ud objectForKey:[NSString stringWithFormat:@"wine%.2dMoney",freeLockNo]]intValue];
    if (money < wineMoney) {
        UIAlertView *alert1 = [[[UIAlertView alloc]initWithTitle:@"购买调酒用酒" message:@"你不够钱哦，多调几次酒赚多点钱啦" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil]autorelease];
        [alert1 show];
        return;
    }
    [alert show];
//    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    switch (buttonIndex) {
        case 0:
            ;
            break;
        case 1:
            if (freeLockNo != -1) {
                [ud setValue:[NSString stringWithFormat:@"NO"] forKey:[NSString stringWithFormat:@"wine%.2d",freeLockNo]];
                
                CCLayer *tmpLayer = (CCLayer *)[self getChildByTag:currentScreen];
                int tmptag = freeLockNo+100-(currentScreen -1)*9;
                NSLog(@"%d",tmptag);
                [tmpLayer removeChildByTag:tmptag cleanup:YES];
                int money = [[ud objectForKey:@"money"]intValue];
               int wineMoney = [[ud objectForKey:[NSString stringWithFormat:@"wine%.2dMoney",freeLockNo]]intValue];
                NSNumber *tmpNo = [NSNumber numberWithInt:money-wineMoney];
                [ud setValue:tmpNo forKey:@"money"];
                [self.parent setMoney:money-wineMoney];
                freeLockNo = -1;
                break;
            }
            
        default:
            break;
    }
}

- (void) dealloc
{
	[super dealloc];
}



@end
