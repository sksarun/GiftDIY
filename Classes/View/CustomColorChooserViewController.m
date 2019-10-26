//
//  CustomColorChooserViewController.m
//  GiftDIY
//
//  Created by Tong on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomColorChooserViewController.h"
#import "MainData.h"
#import "DIYObject.h"

@implementation CustomColorChooserViewController
@synthesize iRedSlider,iGreenSlider,iBlueSlider,iRedLab,iGreenLab,iBlueLab,iResultView;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	
	UIImage* image = [UIImage imageNamed:@"ColorTxt.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(-30, 5, 250, 35);
	[customView addSubview:imageView];
	
	//self.iNavItem.titleView = customView;
	self.navigationItem.titleView = customView;
	
	self.navigationItem.backBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Back"
									 style:UIBarButtonItemStyleBordered
									target:nil
									action:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:userData.iSelectIndex];
	if(iResultView)
	{
		iResultView.backgroundColor = obj.textlab.textColor;
		const float* colors = CGColorGetComponents(  obj.textlab.textColor.CGColor );		
		if(obj.textlab.textColor == [UIColor blackColor])
		{
			iRedLab.text = @"0";
			iGreenLab.text = @"0";
			iBlueLab.text = @"0";
			
			iRedSlider.value = 0.0;
			iGreenSlider.value = 0.0;
			iBlueSlider.value = 0.0;
		}
		else if(obj.textlab.textColor == [UIColor whiteColor]){
			iRedLab.text = @"255";
			iGreenLab.text = @"255";
			iBlueLab.text = @"255";
			
			iRedSlider.value = 255.0;
			iGreenSlider.value = 255.0;
			iBlueSlider.value = 255.0;
		}
		
		else {
			NSInteger Redval = colors[0]*255 + 0.5f;
			NSInteger Greenval = colors[1]*255+ 0.5f;
			NSInteger Blueval = colors[2]*255+ 0.5f;
			iRedLab.text = [NSString stringWithFormat:@"%d",Redval];
			iGreenLab.text = [NSString stringWithFormat:@"%d",Greenval];
			iBlueLab.text = [NSString stringWithFormat:@"%d",Blueval];
			
			iRedSlider.value = colors[0]*255 + 0.5f;
			iGreenSlider.value = colors[1]*255 + 0.5f;
			iBlueSlider.value = colors[2]*255 + 0.5f;
		}
	}
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction) updateValue:(id)sender
{
	NSInteger Redvalue = iRedSlider.value ;
	NSInteger Greenvalue = iGreenSlider.value ;
	NSInteger Bluevalue = iBlueSlider.value ;
	
	iRedLab.text = [NSString stringWithFormat:@"%d",Redvalue];
	iBlueLab.text = [NSString stringWithFormat:@"%d",Bluevalue];
	iGreenLab.text = [NSString stringWithFormat:@"%d",Greenvalue];
	
	iResultView.backgroundColor = [UIColor colorWithRed:Redvalue/255.0 green:Greenvalue/255.0 blue:Bluevalue/255.0 alpha:1.0];
}
-(IBAction) saveColor:(id)sender
{
	
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:userData.iSelectIndex];
	
	if(obj.type == EText)
	{
		NSInteger Redvalue = iRedSlider.value ;
		NSInteger Greenvalue = iGreenSlider.value ;
		NSInteger Bluevalue = iBlueSlider.value ;
		obj.textlab.textColor = [UIColor colorWithRed:Redvalue/255.0 green:Greenvalue/255.0 blue:Bluevalue/255.0 alpha:1.0];
	}
	
	[[self navigationController] popViewControllerAnimated:YES];
	
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
	[iRedSlider release];
	[iGreenSlider release];
	[iBlueSlider release];
	[iRedLab release];
	[iGreenLab release];
	[iBlueLab release];
	[iResultView release];

    [super dealloc];
}


@end
