//
//  FontListViewController.m
//  GiftDIY
//
//  Created by Tong on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FontListViewController.h"
#import "MainData.h"
#import "DIYObject.h"

@implementation FontListViewController
@synthesize iSelectIndex,iTable;

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
	
	UIImage* image = [UIImage imageNamed:@"FontTxt.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(-30, 5, 250, 35);
	[customView addSubview:imageView];
	
	//self.iNavItem.titleView = customView;
	self.navigationItem.titleView = customView;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
	familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
	/*
	NSArray *fontNames;
	NSInteger indFamily, indFont;
	for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
	{
		NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
		fontNames = [[NSArray alloc] initWithArray:
					 [UIFont fontNamesForFamilyName:
					  [familyNames objectAtIndex:indFamily]]];
		for (indFont=0; indFont<[fontNames count]; ++indFont)
		{
			NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
		}
		[fontNames release];
	}
	[familyNames release];
	 */
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void) tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	obj.textlab.font = [UIFont fontWithName:[familyNames objectAtIndex:[indexPath row]] size:20];
	[[self navigationController] popViewControllerAnimated:YES];
	
}
/*
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [familyNames count];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{

	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.font = [UIFont fontWithName:[familyNames objectAtIndex:[indexPath row]]size:20];
	cell.textLabel.text = @"ABCDEFGHIJKLMNOPQRRSTUV";
	return cell;
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
	[familyNames release];
    [super dealloc];
}


@end
