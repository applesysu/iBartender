//
//  HelloWorldLayer.m
//  iBartender
//
//  Created by again on 2/19/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "WineGameGlassLayer.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer implementation

@implementation WineGameGlassLayer

@synthesize currentScreen;
@synthesize onPageMoved;

-(id) initWithLayers:(NSMutableArray *)layers widthOffset: (int) widthOffset WithScene:(WineMainGameLayer *)theGame;
{
	
	if ( (self = [super init]) )
	{
		wineFlow = NO;
		// Make sure the layer accepts touches
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
		// Set up the starting variables
		if(!widthOffset){
			widthOffset = 0;
		}	
		currentScreen = 1;

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
            CCSprite *layerBackground = [CCSprite spriteWithSpriteFrameName:@"winechoose_shelf.png"];
            //            layerBackground.anchorPoint = ccp(0, 0);
            layerBackground.position = ccp(160,400);
            [l addChild:layerBackground];
            
            
            CCSprite *wine1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_wine%.2d.png",1+i*5]];
            
            
            
            switch (i) {
                case 0:
                    wine1.position = ccp(30, 401);
                    break;
                case 1:
                    wine1.position = ccp(30, 391);
                    break;
                case 2:
                    wine1.position = ccp(30, 397);
                    break;
                case 3:
                    wine1.position = ccp(30, 398);
                    break;
                case 4:
                    wine1.position = ccp(30, 398);
                    break;
                    
                default:
                    break;
            }
            wine1.tag = 1;
            
            [l addChild:wine1];
            
            
            if(i < 4)
            {
                CCSprite *wine2 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_wine%.2d.png",2+i*5]];
//                wine2.position = ccp(160, 340);
                wine2.tag = 2;
                switch (i) {
                    case 0:
                        wine2.position = ccp(95, 394);
                        break;
                    case 1:
                        wine2.position = ccp(95, 400);
                        break;
                    case 2:
                        wine2.position = ccp(95, 401);
                        break;
                    case 3:
                        wine2.position = ccp(95, 399);
                        break;
                        
                    default:
                        break;
                }
                CCSprite *wine3 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_wine%.2d.png",3+i*5]];
                wine3.tag = 3;
//                wine3.position = ccp(255, 340);
                switch (i) {
                    case 0:
                        wine3.position = ccp(160, 400);
                        break;
                    case 1:
                        wine3.position = ccp(160, 400);
                        break;
                    case 2:
                        wine3.position = ccp(160, 395);
                        break;
                    case 3:
                        wine3.position = ccp(160, 397);
                        break;
                        
                    default:
                        break;
                }

                CCSprite *wine4 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_wine%.2d.png",4+i*5]];
                wine4.tag = 4;
//                wine4.position = ccp(65, 220);
                switch (i) {
                    case 0:
                        wine4.position = ccp(225, 399);
                        break;
                    case 1:
                        wine4.position = ccp(225, 393);
                        break;
                    case 2:
                        wine4.position = ccp(225, 396);
                        break;
                    case 3:
                        wine4.position = ccp(225, 395);
                        break;
                        
                    default:
                        break;
                }

                CCSprite *wine5 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"winechoose_wine%.2d.png",5+i*5]];
                wine5.tag = 5;
//                wine5.position = ccp(160, 220);
                switch (i) {
                    case 0:
                        wine5.position = ccp(285, 400);
                        break;
                    case 1:
                        wine5.position = ccp(285, 400);
                        break;
                    case 2:
                        wine5.position = ccp(285, 401);
                        break;
                    case 3:
                        wine5.position = ccp(285, 397);
                        break;
                        
                    default:
                        break;
                }

//                CCSprite *wine6 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",6+i*9]];
//                wine6.position = ccp(255, 220);
//                CCSprite *wine7 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",7+i*9]];
//                wine7.position = ccp(65, 105);
//                CCSprite *wine8 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",8+i*9]];
//                wine8.position = ccp(160, 105);
//                CCSprite *wine9 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"shoppage_wine%.2d.png",9+i*9]];
//                wine9.position = ccp(255, 105);
                [l addChild:wine2];
                [l addChild:wine3];
                [l addChild:wine4];
                [l addChild:wine5];
//                [l addChild:wine6];
//                [l addChild:wine7];
//                [l addChild:wine8];
//                [l addChild:wine9];
//                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",4+i*5]];
//                NSLog(@"%@",islock);
//                NSLog(@"%d",[islock compare:@"YES"]);
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",2+i*5]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock2 = [CCSprite spriteWithSpriteFrameName:@"winechoose_lock.png"];
//                    lock2.position = ccp(160, 338);
                    switch (i) {
                        case 0:
                            lock2.position = ccp(wine2.position.x+4,371);
                            break;
                        case 1:
                            lock2.position = ccp(wine2.position.x+3,371);
                            break;
                        case 2:
                            lock2.position = ccp(wine2.position.x+2,371);
                            break;
                        case 3:
                            lock2.position = ccp(wine2.position.x+1,371);
                            break;
                            
                        default:
                            break;
                    }
                    lock2.tag = 102;
                    [l addChild:lock2];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",3+i*5]];
                if([islock compare:@"YES"] == 0)
                {                
                    CCSprite *lock3 = [CCSprite spriteWithSpriteFrameName:@"winechoose_lock.png"];
//                    lock3.position = ccp(255, 338);
                    switch (i) {
                        case 0:
                            lock3.position = ccp(wine3.position.x+3,371);
                            break;
                        case 1:
                            lock3.position = ccp(wine3.position.x+4,371);
                            break;
                        case 2:
                            lock3.position = ccp(wine3.position.x+5,371);
                            break;
                        case 3:
                            lock3.position = ccp(wine3.position.x+4,371);
                            break;
                            
                        default:
                            break;
                    }
                    lock3.tag = 103;
                    [l addChild:lock3];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",4+i*5]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock4 = [CCSprite spriteWithSpriteFrameName:@"winechoose_lock.png"];
//                    lock4.position = ccp(64, 223);
                    switch (i) {
                        case 0:
                            lock4.position = ccp(wine4.position.x+3,371);
                            break;
                        case 1:
                            lock4.position = ccp(wine4.position.x+5,371);
                            break;
                        case 2:
                            lock4.position = ccp(wine4.position.x+6,371);
                            break;
                        case 3:
                            lock4.position = ccp(wine4.position.x+8,371);
                            break;
                            
                        default:
                            break;
                    }
                    lock4.tag = 104;
                    [l addChild:lock4];
                }
                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",5+i*5]];
                if([islock compare:@"YES"] == 0)
                {
                    CCSprite *lock5 = [CCSprite spriteWithSpriteFrameName:@"winechoose_lock.png"];
//                    lock5.position = ccp(159, 223);
                    switch (i) {
                        case 0:
                            lock5.position = ccp(wine5.position.x+2,371);
                            break;
                        case 1:
                            lock5.position = ccp(wine5.position.x+2,371);
                            break;
                        case 2:
                            lock5.position = ccp(wine5.position.x+3,371);
                            break;
                        case 3:
                            lock5.position = ccp(wine5.position.x,371);
                            break;
                            
                        default:
                            break;
                    }
                    lock5.tag = 105;
                    [l addChild:lock5];
                }
//                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",6+i*9]];
//                if([islock compare:@"YES"] == 0)
//                {
//                    CCSprite *lock6 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
//                    lock6.position = ccp(254, 223);
//                    lock6.tag = 106;
//                    [l addChild:lock6];
//                }
//                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",7+i*9]];
//                if([islock compare:@"YES"] == 0)
//                {
//                    CCSprite *lock7 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
//                    lock7.position = ccp(65, 110);
//                    lock7.tag = 107;
//                    [l addChild:lock7];
//                }
//                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",8+i*9]];
//                if([islock compare:@"YES"] == 0)
//                {
//                    CCSprite *lock8 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
//                    lock8.position = ccp(160, 109);
//                    lock8.tag = 108;
//                    [l addChild:lock8];
//                }
//                islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",9+i*9]];
//                if([islock compare:@"YES"] == 0)
//                {
//                    CCSprite *lock9 = [CCSprite spriteWithSpriteFrameName:@"shoppage_lock.png"];
//                    lock9.position = ccp(255, 109);
//                    lock9.tag = 109;
//                    [l addChild:lock9];
//                }
            }
            islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",1+i*5]];
            if([islock compare:@"YES"] == 0)
            {
                CCSprite *lock1 = [CCSprite spriteWithSpriteFrameName:@"winechoose_lock.png"];
//                lock1.position = ccp(65, 338);
                switch (i) {
                    case 0:
                        lock1.position = ccp(wine1.position.x+5,371);
                        NSLog(@"%f",wine1.position.y-30);
                        break;
                    case 1:
                        lock1.position = ccp(wine1.position.x+3,371);
                        break;
                    case 2:
                        lock1.position = ccp(wine1.position.x+4,371);
                        break;
                    case 3:
                        lock1.position = ccp(wine1.position.x+3,371);
                        break;
                    case 4:
                        lock1.position = ccp(wine1.position.x+1,371);
                        break;
                        
                    default:
                        break;
                }
                lock1.tag = 101;
                [l addChild:lock1];
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
    if ((touchPoint.y < 372 || touchPoint.y > 448) || wineFlow) {
        return NO;
    }
    
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
	if (newX <= startSwipe+6 && newX >= startSwipe-6 && !wineFlow) {
        CCLayer *tmpLayer = (CCLayer *)[self getChildByTag:currentScreen];
        for( CCSprite *sprite in [tmpLayer children] ){
            if( [sprite tag] <= 0 ) continue;
            
            if( CGRectContainsPoint([sprite boundingBox], touchPoint) ){
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *islock = [ud objectForKey:[NSString stringWithFormat:@"wine%.2d",[sprite tag]+5*(currentScreen-1)]];
                if([islock compare:@"YES"] == 0)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"这种酒还没解锁哦" message:@"你可以到商店去浏览一下哦" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    return;
                }
                NSLog(@"tag = %d",[sprite tag]);
                sales += [sprite tag]*10+20*(currentScreen-1);
                NSNumber *num = [NSNumber numberWithInt:sales];
                [ud setValue:num forKey:@"sales"];
                CCSprite *select = [CCSprite spriteWithFile:@"winechoose_select.png"];
                select.position = ccp(sprite.position.x+5,sprite.position.y-18);
                [tmpLayer addChild:select];
                wineFlow = YES;
                [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
                [self.parent setUseWine];
                [self wineFlow:[sprite tag]];
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

-(void)wineFlow:(int)tag
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"wine_%d.plist",tag+(currentScreen-1)*5]];
     _wineFlow = [CCSpriteBatchNode 
                   batchNodeWithFile:[NSString stringWithFormat:@"wine_%d.png",tag+(currentScreen-1)*5]];
    [self addChild:_wineFlow];
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i =1; i <=21; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"wine%d_%.2d.png",tag+(currentScreen-1)*5, i]]];
    }
    CCAnimation *walkAnim = [CCAnimation 
                             animationWithFrames:walkAnimFrames delay:0.08f];
    id action = [CCAnimate actionWithAnimation: walkAnim];
    wine_flow = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"wine%d_01.png",tag+(currentScreen-1)*5]];
    if (currentScreen == 1) {
        switch (tag) {
            case 1:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 270);
                break;
            case 2:
                wine_flow.position = ccp(190+(currentScreen-1)*320, 270);
                break;
            case 3:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 270);
                break;
            case 4:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
            case 5:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
                
            default:
                break;
        }

    }
    else if (currentScreen == 2)
    {
        switch (tag) {
            case 1:
                wine_flow.position = ccp(198+(currentScreen-1)*320, 280);
                break;
            case 2:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
            case 3:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
            case 4:
                wine_flow.position = ccp(194+(currentScreen-1)*320, 278);
                break;
            case 5:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 270);
                break;
                
            default:
                break;
        }
    }
    else if (currentScreen == 3)
    {
        switch (tag) {
            case 1:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
            case 2:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 277);
                break;
            case 3:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 280);
                break;
            case 4:
                wine_flow.position = ccp(195+(currentScreen-1)*320, 282);
                break;
            case 5:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 273);
                break;
                
            default:
                break;
        }
    }
    else if (currentScreen == 4)
    {
        switch (tag) {
            case 1:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 275);
                break;
            case 2:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 270);
                break;
            case 3:
                wine_flow.position = ccp(195+(currentScreen-1)*320, 280);
                break;
            case 4:
                wine_flow.position = ccp(190+(currentScreen-1)*320, 280);
                break;
            case 5:
                wine_flow.position = ccp(200+(currentScreen-1)*320, 278);
                break;
                
            default:
                break;
        }
    }
    else if (currentScreen == 5)
    {
        wine_flow.position = ccp(200+(currentScreen-1)*320, 278);
    }
    
    [wine_flow runAction:[CCSequence actions:action, [CCHide action], nil]];
    [_wineFlow addChild:wine_flow];
//    [[SimpleAudioEngine sharedEngine]playEffect:@"water.wav"];
    [self schedule:@selector(removeWine)];
}

-(void)removeWine
{
    if (!wine_flow.visible) {
        [wine_flow removeFromParentAndCleanup:YES];
        [_wineFlow removeFromParentAndCleanup:YES];
        wineFlow = NO;
        [self unschedule:@selector(removeWine)];
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
