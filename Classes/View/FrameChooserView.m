//
//  FrameChooserView.m
//  GiftDIY
//
//  Created by Tong on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FrameChooserView.h"
#import "GiftDIYViewController.h"
#import "MainData.h"

@implementation FrameChooserView
@synthesize iDIYBgPictureList,iBgFramePictureList,iDIYFramePictureList,iNavBar,iScrollView,iPlainFramePictureList,iSelectIndex,delegate;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}
 */
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	iScrollView.delegate = self;
	
	frameType = EPlain;
	iNavBar.title = @"Plain Frame";
	[self.iScrollView setBackgroundColor:[UIColor clearColor]];
	[iScrollView setCanCancelContentTouches:NO];
	iScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	iScrollView.clipsToBounds = YES;
	iScrollView.scrollEnabled = YES;
	iScrollView.pagingEnabled = YES;
	
	[iScrollView setContentSize:CGSizeMake(320*4,430 )];
	
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
	
	NSArray* framename = [userData.imageData objectForKey:@"frame"];
	iPlainFramePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[framename count] ; i++)
	{
		[iPlainFramePictureList addObject:[NSString stringWithString:[framename objectAtIndex:i]]];
	}
	for(int i = 0 ; i< [iPlainFramePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iPlainFramePictureList objectAtIndex:i]] atIndex:i withOffset:0];
	}
	
	NSArray* DIYframename = [userData.imageData objectForKey:@"DIYFrame"];
	iDIYFramePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[DIYframename count] ; i++)
	{
		[iDIYFramePictureList addObject:[NSString stringWithString:[DIYframename objectAtIndex:i]]];
	}
	for(int i = 0 ; i< [iDIYFramePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iDIYFramePictureList objectAtIndex:i]] atIndex:i withOffset:1];
	}
	
	NSArray* Bgframename = [userData.imageData objectForKey:@"backgroundframe"];
	iBgFramePictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[Bgframename count] ; i++)
	{
		[iBgFramePictureList addObject:[NSString stringWithString:[Bgframename objectAtIndex:i]]];
	}
	for(int i = 0 ; i< [iBgFramePictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iBgFramePictureList objectAtIndex:i]] atIndex:i withOffset:2];
	}
	
	NSArray* DIYBgframename = [userData.imageData objectForKey:@"DIYBg"];
	iDIYBgPictureList = [[NSMutableArray alloc]init];
	for(int i = 0 ; i<[DIYBgframename count] ; i++)
	{
		[iDIYBgPictureList addObject:[NSString stringWithString:[DIYBgframename objectAtIndex:i]]];
	}
	for(int i = 0 ; i< [iDIYBgPictureList count] ; i++)
	{
		[self AddPhoto:[UIImage imageNamed:[iDIYBgPictureList objectAtIndex:i]] atIndex:i withOffset:3];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction) NextIconType:(id)sender
{
	
	UISegmentedControl* con = (UISegmentedControl*) sender;
	if(con.selectedSegmentIndex == 0)
	{
		if(frameType == 0)
		{
			frameType = 3;
		}
		else {
			frameType--;
		}
	}
	else {
		if(frameType == 3)
		{
			frameType = 0;
		}
		else {
			frameType++;
		}
	}
	
	[self UpdateMode];
	
}
-(void) UpdateMode
{
	if(frameType == EPlain){
		frameType = EPlain ;
		[iScrollView setContentOffset:CGPointMake(0,0)];
		iNavBar.title = @"Plain Frame";
	}
	else if(frameType == EDIY){
		frameType = EDIY ;
		[iScrollView setContentOffset:CGPointMake(320*1,0)];
		iNavBar.title = @"DIY Frame";
	}
	else if(frameType == EBg){
		frameType = EBg ;
		[iScrollView setContentOffset:CGPointMake(320*2,0)];
		iNavBar.title = @"Bg Frame";
	}
	else if(frameType == EArtBg)
	{
		frameType = EArtBg ;
		[iScrollView setContentOffset:CGPointMake(320*3,0)];
		iNavBar.title = @"Art Frame";
	}
		
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{	
	if([iScrollView contentOffset].x == 0)
	{
		frameType = EPlain;	
		iNavBar.title = @"Plain Frame";
	}
	else if([iScrollView contentOffset].x == 320)
	{
		frameType = EDIY;	
		iNavBar.title = @"DIY Frame";
	}
	else if([iScrollView contentOffset].x == 320*2)
	{
		frameType = EBg;	
		iNavBar.title = @"Bg Frame";
	}
	else if([iScrollView contentOffset].x == 320*3)
	{
		frameType = EArtBg;	
		iNavBar.title = @"Art Frame";
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
				rect.origin.y = 4+i*4+i*75;//((iScrollView.frame.size.height - 285) / 2)+50;
				
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
				rect.origin.y = 53+4+i*4+i*75;//((iScrollView.frame.size.height - 285) / 2)+50;
				
				
				
				if(frameType == EPlain)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iPlainFramePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iPlainFramePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iPlainFramePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iPlainFramePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(frameType == EDIY)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iDIYFramePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iDIYFramePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDIYFramePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDIYFramePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(frameType == EBg)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iBgFramePictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iBgFramePictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iBgFramePictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iBgFramePictureList objectAtIndex:count]]];
						}
						
						[self dismissModalViewControllerAnimated:YES];
						return;
					}
				}
				else if(frameType == EArtBg)
				{
					if(CGRectContainsPoint(rect,touchLocation)&& count<[[self iDIYBgPictureList] count])
					{
						if(iScrollView.contentOffset.y > 100)
						{
							if(count+20 >= [[self iDIYBgPictureList] count])return;
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDIYBgPictureList objectAtIndex:count+20]]];
						}
						else {
							[(GiftDIYViewController*) delegate AddFrameObject:[UIImage imageNamed:[iDIYBgPictureList objectAtIndex:count]]];
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
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[iBgFramePictureList release];
	[iDIYFramePictureList release];
	[iPlainFramePictureList release];
	[iNavBar release];
	[iScrollView release];
    [super dealloc];
}


@end
