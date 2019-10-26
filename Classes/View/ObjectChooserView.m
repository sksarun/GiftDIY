//
//  ObjectChooserView.m
//  GiftDIY
//
//  Created by Tong on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjectChooserView.h"
#import "GiftDIYViewController.h"
#import "MainData.h"

@implementation ObjectChooserView
@synthesize iNavBar,iScrollView,iSportPictureList,iWeatherPictureList,iEtcPictureList,iGiftPictureList,iNaturePictureList,iSpacePictureList,iEmotionPictureList,iCreaturePictureList,iAnimalPictureList,iZodiacPictureList,iDecorationPictureList,iSelectIndex,delegate;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
 */	

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	iScrollView.delegate = self;

	iconType = EDeco;
	[self.iScrollView setBackgroundColor:[UIColor clearColor]];
	[iScrollView setCanCancelContentTouches:NO];
	iScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	iScrollView.clipsToBounds = YES;
	iScrollView.scrollEnabled = YES;
	iScrollView.pagingEnabled = YES;
	
	[iScrollView setContentSize:CGSizeMake(320*11,1000 )];
	
	MainData * userData = (MainData*)[MainData sharedMainData];
    if (userData.imageData == nil) {
        // read the filenames/sizes out of a plist in the app bundle
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageData" ofType:@"plist"];
        NSData *plistData = [NSData dataWithContentsOfFile:path];
        NSString *error; NSPropertyListFormat format;
        userData.imageData = [[NSPropertyListSerialization propertyListFromData:plistData
															   mutabilityOption:NSPropertyListImmutable
																		 format:&format
															   errorDescription:&error]
							  retain];
		
		
        if (!userData.imageData) {
            NSLog(@"Failed to read image names. Error: %@", error);
            [error release];
        }
    }
	NSArray* decname = [userData.imageData objectForKey:@"decorate"];
	iDecorationPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[decname count] ; i++)
	{
		[iDecorationPictureList addObject:[NSString stringWithString:[decname objectAtIndex:i]]];
	}
	
	NSArray* zodiacname = [userData.imageData objectForKey:@"zodiac"];
	iZodiacPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[zodiacname count] ; i++)
	{
		[iZodiacPictureList addObject:[NSString stringWithString:[zodiacname objectAtIndex:i]]];
	}
	NSArray* animalname = [userData.imageData objectForKey:@"animal"];
	iAnimalPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[animalname count] ; i++)
	{
		[iAnimalPictureList addObject:[NSString stringWithString:[animalname objectAtIndex:i]]];
	}
	
	NSArray* creaturename = [userData.imageData objectForKey:@"creature"];
	iCreaturePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[creaturename count] ; i++)
	{
		[iCreaturePictureList addObject:[NSString stringWithString:[creaturename objectAtIndex:i]]];
	}
	
	NSArray* emotionname = [userData.imageData objectForKey:@"emotion"];
	iEmotionPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[emotionname count] ; i++)
	{
		[iEmotionPictureList addObject:[NSString stringWithString:[emotionname objectAtIndex:i]]];
	}
	
	NSArray* spacename = [userData.imageData objectForKey:@"space"];
	iSpacePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[spacename count] ; i++)
	{
		[iSpacePictureList addObject:[NSString stringWithString:[spacename objectAtIndex:i]]];
	}
	
	NSArray* naturename = [userData.imageData objectForKey:@"nature"];
	iNaturePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[naturename count] ; i++)
	{
		[iNaturePictureList addObject:[NSString stringWithString:[naturename objectAtIndex:i]]];
	}
	
	NSArray* giftname = [userData.imageData objectForKey:@"gift"];
	iGiftPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[giftname count] ; i++)
	{
		[iGiftPictureList addObject:[NSString stringWithString:[giftname objectAtIndex:i]]];
	}
	
	NSArray* etcname = [userData.imageData objectForKey:@"etc"];
	iEtcPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[etcname count] ; i++)
	{
		[iEtcPictureList addObject:[NSString stringWithString:[etcname objectAtIndex:i]]];
	}
	
	NSArray* weathername = [userData.imageData objectForKey:@"weather"];
	iWeatherPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[weathername count] ; i++)
	{
		[iWeatherPictureList addObject:[NSString stringWithString:[weathername objectAtIndex:i]]];
	}
	
	NSArray* sportname = [userData.imageData objectForKey:@"sport"];
	iSportPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[sportname count] ; i++)
	{
		[iSportPictureList addObject:[NSString stringWithString:[sportname objectAtIndex:i]]];
	}
	
	
	for(int i = 0 ; i< [iDecorationPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iDecorationPictureList objectAtIndex:i]] atIndex:i withOffset:0];
	}
	
	for(int i = 0 ; i< [iZodiacPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iZodiacPictureList objectAtIndex:i]] atIndex:i withOffset:1];
	}
	
	for(int i = 0 ; i< [iAnimalPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iAnimalPictureList objectAtIndex:i]] atIndex:i withOffset:2];
	}
	
	for(int i = 0 ; i< [iCreaturePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iCreaturePictureList objectAtIndex:i]] atIndex:i withOffset:3];
	}
	
	for(int i = 0 ; i< [iEmotionPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iEmotionPictureList objectAtIndex:i]] atIndex:i withOffset:4];
	}
	
	for(int i = 0 ; i< [iSpacePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iSpacePictureList objectAtIndex:i]] atIndex:i withOffset:5];
	}
	
	for(int i = 0 ; i< [iNaturePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iNaturePictureList objectAtIndex:i]] atIndex:i withOffset:6];
	}
	
	for(int i = 0 ; i< [iGiftPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iGiftPictureList objectAtIndex:i]] atIndex:i withOffset:7];
	}
	
	for(int i = 0 ; i< [iEtcPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iEtcPictureList objectAtIndex:i]] atIndex:i withOffset:8];
	}
	
	
	for(int i = 0 ; i< [iWeatherPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iWeatherPictureList objectAtIndex:i]] atIndex:i withOffset:9];
	}
	
	
	for(int i = 0 ; i< [iSportPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iSportPictureList objectAtIndex:i]] atIndex:i withOffset:10];
	}
	
}
-(IBAction) NextIconType:(id)sender
{
	
	UISegmentedControl* con = (UISegmentedControl*) sender;
	if(con.selectedSegmentIndex == 0)
	{
		if(iconType == 0)
		{
			iconType = 10;
		}
		else {
			iconType--;
		}
	}
	else {
		if(iconType == 10)
		{
			iconType = 0;
		}
		else {
			iconType++;
		}
	}

	[self UpdateMode];
	
}
-(void) UpdateMode
{
	
	if(iconType == EZodiac){
		iconType = EZodiac ;
		[iScrollView setContentOffset:CGPointMake(320,0)];
		iNavBar.title = @"Zodiac";
	}
	else if(iconType == EAnimal){
		iconType = EAnimal ;
		[iScrollView setContentOffset:CGPointMake(320*2,0)];
		iNavBar.title = @"Animal";
	}
	else if(iconType == ECreature){
		iconType = ECreature ;
		[iScrollView setContentOffset:CGPointMake(320*3,0)];
		iNavBar.title = @"Creature";
	}
	else if(iconType == EEmotion){
		iconType = EEmotion ;
		[iScrollView setContentOffset:CGPointMake(320*4,0)];
		iNavBar.title = @"Emotion";
	}
	else if(iconType == ESpace){
		iconType = ESpace ;
		[iScrollView setContentOffset:CGPointMake(320*5,0)];
		iNavBar.title = @"Space";
	}
	else if(iconType == ENature){
		iconType = ENature ;
		[iScrollView setContentOffset:CGPointMake(320*6,0)];
		iNavBar.title = @"Nature";
	}
	else if(iconType == EGift){
		iconType = EGift ;
		[iScrollView setContentOffset:CGPointMake(320*7,0)];
		iNavBar.title = @"Gift";
	}
	else if(iconType == EEtc){
		iconType = EEtc ;
		[iScrollView setContentOffset:CGPointMake(320*8,0)];
		iNavBar.title = @"Etc";
	}
	else if(iconType == EWeather){
		iconType = EWeather ;
		[iScrollView setContentOffset:CGPointMake(320*9,0)];
		iNavBar.title = @"Weather";
	}
	
	else if(iconType == ESport){
		iconType = ESport ;
		[iScrollView setContentOffset:CGPointMake(320*10,0)];
		iNavBar.title = @"Sport";
	}
	else {
		iconType = EDeco ;
		[iScrollView setContentOffset:CGPointMake(0,0)];
		iNavBar.title = @"Decoration";
	}
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{	
	if([iScrollView contentOffset].x == 0)
	{
		iconType = EDeco;	
		iNavBar.title = @"Decoration";
	}
	else if([iScrollView contentOffset].x == 320)
	{
		iconType = EZodiac;	
		iNavBar.title = @"Zodiac";
	}
	else if([iScrollView contentOffset].x == 320*2)
	{
		iconType = EAnimal;	
		iNavBar.title = @"Animal";
	}
	else if([iScrollView contentOffset].x == 320*3)
	{
		iconType = ECreature;	
		iNavBar.title = @"Creature";
	}
	else if([iScrollView contentOffset].x == 320*4)
	{
		iconType = EEmotion;	
		iNavBar.title = @"Emotion";
	}
	else if([iScrollView contentOffset].x == 320*5)
	{
		iconType = ESpace;	
		iNavBar.title = @"Space";
	}
	else if([iScrollView contentOffset].x == 320*6)
	{
		iconType = ENature;	
		iNavBar.title = @"Nature";
	}
	else if([iScrollView contentOffset].x == 320*7)
	{
		iconType = EGift;	
		iNavBar.title = @"Gift";
	}
	else if([iScrollView contentOffset].x == 320*8)
	{
		iconType = EEtc;
		iNavBar.title = @"Etc";
	}
	else if([iScrollView contentOffset].x == 320*9)
	{
		iconType = EWeather;
		iNavBar.title = @"Weather";
	}
	else if([iScrollView contentOffset].x == 320*10)
	{
		iconType = ESport;
		iNavBar.title = @"Sport";
	}

}
-(void) AddPhoto:(UIImage*)image atIndex:(NSInteger)index withOffset:(NSInteger)offset
{
	NSInteger counter = 0;
	for (int i =0 ; i < 10; i++) {
		for(int j = 0 ; j<4;j++)
		{
			if(counter == index)
			{
				UIImageView* imagev = [[UIImageView alloc] init];
				imagev.image = image;
				CGRect rect = imagev.frame;
				rect.size.height = 75;
				rect.size.width = 75;
				rect.origin.x = 320*offset+4+j*4+75*j;
				rect.origin.y = 12+i*12+i*75;//((iScrollView.frame.size.height - 285) / 2)+50;
				
				//iView.frame = rect;
				imagev.frame = rect;
				[iScrollView addSubview:imagev];
				[imagev release];
			}
			counter++;
		}
	}
}
-(IBAction) CloseView
{
	[self dismissModalViewControllerAnimated:YES];
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	for (UITouch *myTouch in touches)
	{
		if (myTouch.phase == UITouchPhaseBegan) {
			// new touch handler
		}
		if (myTouch.phase == UITouchPhaseMoved) {
			// touch moved handler
		}
		if (myTouch.phase == UITouchPhaseEnded) {
			// touch end handler
		}
		//[myTouch locationInView]
		CGPoint touchLocation = [myTouch locationInView:self.view];
		
		NSInteger count = 0;
		for (int i =0 ; i < 10; i++) {
			for(int j = 0 ; j<4;j++)
			{
				CGRect rect ;
				rect.size.height = 75;
				rect.size.width = 75;
				rect.origin.x = 4+j*4+75*j;
				rect.origin.y = 53+12+i*12+i*75;//((iScrollView.frame.size.height - 285) / 2)+50;
				
				
				
				if(iconType == EDeco)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iDecorationPictureList] count])
					{
					if(iScrollView.contentOffset.y > 100)
					{
						if(count+20 >= [[self iDecorationPictureList] count])return;
						[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDecorationPictureList objectAtIndex:count+20]]];
					}
					else {
						[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDecorationPictureList objectAtIndex:count]]];
					}

					[self dismissModalViewControllerAnimated:YES];
					return;
					}
				}
				else if(iconType == EZodiac)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iZodiacPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iZodiacPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iZodiacPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iZodiacPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == EAnimal)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iAnimalPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iAnimalPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iAnimalPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iAnimalPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == ECreature)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iCreaturePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iCreaturePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iCreaturePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iCreaturePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == EEmotion)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iEmotionPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iEmotionPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iEmotionPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iEmotionPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == ESpace)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iSpacePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iSpacePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iSpacePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iSpacePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == ENature)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iNaturePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iNaturePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iNaturePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iNaturePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == EGift)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iGiftPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iGiftPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iGiftPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iGiftPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == EEtc)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iEtcPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iEtcPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iEtcPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iEtcPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == EWeather)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iWeatherPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iWeatherPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iWeatherPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iWeatherPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(iconType == ESport)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iSportPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iEtcPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iSportPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iSportPictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}

				count++;
			}
		}
		
	}
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}
*/
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[iAnimalPictureList release];
	[iZodiacPictureList release];
	[iDecorationPictureList release];
	[iSpacePictureList release];
	[iEmotionPictureList release];
	[iCreaturePictureList release];
	[iEtcPictureList release];
	[iNaturePictureList release];
	[iWeatherPictureList release];
	[iSportPictureList release];
	[iGiftPictureList release];
	[iScrollView release];
	[iNavBar release];
    [super dealloc];
}


@end
