//
//  WineGameSellScene.m
//  iBartender
//
//  Created by again on 2/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WineGameSellScene.h"


@implementation WineGameSellScene

-(id)init
{
    if( (self = [super init]) ){
		[self addChild:[WineGameSellLayer node]];
	}
	return self;   
}

@end

@implementation WineGameSellLayer
@synthesize pickerValues;

-(id)init
{
    if ((self = [super init])) {
        
        pickerValues = [[NSArray alloc] initWithObjects:@" 0 ",@" 1 ",@" 2 ",@" 3 ",@" 4 ",@" 5 ",@" 6 ",@" 7 ",@" 8 ",@" 9 ",nil];
//        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(60.0f, 195.0f, 200.0f, 125.0f)]; 
         pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [pickerView setDelegate:self];
        [pickerView setDataSource:self];
        
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [[[CCDirector sharedDirector] openGLView] addSubview:pickerView];
//        _backgroundLayer = [CCSpriteBatchNode batchNodeWithFile:@"allCup.png"];
//        [[_backgroundLayer texture] setAliasTexParameters];
//		[self addChild:_backgroundLayer];
//        CCMenuItemSprite *back = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_back.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_back.png"] target:self selector:@selector(startBack:)];
//        
//        CCMenuItemSprite *go = [CCMenuItemSprite itemFromNormalSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] selectedSprite:[CCSprite  spriteWithSpriteFrameName:@"glasschoose_next.png"] target:self selector:@selector(startGo:)];
//        CCMenu *menuHead = [CCMenu menuWithItems:back, go, nil];
//        [menuHead alignItemsHorizontallyWithPadding:133];
//        menuHead.position = ccp(160,465);
//        [self addChild:menuHead z:3];
    }
    return self;
}


- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *numberSequence = [NSString stringWithFormat:@"Sequence: %@%@%@",
                                
                                [pickerValues objectAtIndex:[thePickerView selectedRowInComponent:0]],
                                
                                [pickerValues objectAtIndex:[thePickerView selectedRowInComponent:1]],
                                
                                [pickerValues objectAtIndex:[thePickerView selectedRowInComponent:2]]];
    
    
    
    NSLog(@"%@",numberSequence);
    
}




// Number of picker wheels in the picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
    
}



// Number of items in each picker wheel

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 3;
    }
    return [pickerValues count];
    
}





// Title for Row #

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickerValues objectAtIndex:row]; 
    
}

// Row height in pixels

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 20.0;
    
}



// Column width in pixels

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 50.0f;
    
}

@end


