//
//  BasicColorChooserController.m
//  GiftDIY
//
//  Created by Tong on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BasicColorChooserController.h"
#import "MainData.h"
#import "DIYObject.h"

@implementation BasicColorChooserController
@synthesize iTable;
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
	imageView.frame = CGRectMake(-20, 5, 250, 35);
	[customView addSubview:imageView];
		
	
	self.tabBarController.navigationItem.titleView = customView;
	self.tabBarController.navigationItem.backBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Back"
									 style:UIBarButtonItemStyleBordered
									target:nil
									action:nil];
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
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:userData.iSelectIndex];
	
	
	switch ([indexPath row]) {
		case 0:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor blackColor];
			}
			break;
		case 1:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor whiteColor];
			}
			break;
		case 2:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor redColor];
			}
			break;
		case 3:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor greenColor];
			}
			break;
		case 4:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor blueColor];
			}
			break;
		case 5:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor yellowColor];
			}
			break;
		case 6:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor orangeColor];
			}
			break;
		case 7:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor purpleColor];
			}
			break;
		case 8:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor magentaColor];
			}
			break;
		case 9:
			if(obj.type == EText)
			{
				obj.textlab.textColor =	[UIColor grayColor];
			}
			break;
		default:
			break;
	}
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
	return 10;
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	switch ([indexPath row]) {
		case 0:
			cell.contentView.backgroundColor = [UIColor blackColor];
			break;
		case 1:
			cell.contentView.backgroundColor = [UIColor whiteColor];
			break;
		case 2:
			cell.contentView.backgroundColor = [UIColor redColor];
			break;
		case 3:
			cell.contentView.backgroundColor = [UIColor greenColor];
			break;
		case 4:
			cell.contentView.backgroundColor = [UIColor blueColor];
			break;
		case 5:
			cell.contentView.backgroundColor = [UIColor yellowColor];
			break;
		case 6:
			cell.contentView.backgroundColor = [UIColor orangeColor];
			break;
		case 7:
			cell.contentView.backgroundColor = [UIColor purpleColor];
			break;
		case 8:
			cell.contentView.backgroundColor = [UIColor magentaColor];
			break;
		case 9:
			cell.contentView.backgroundColor = [UIColor grayColor];
			break;
		default:
			break;
	}
	
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
    [super dealloc];
}


@end
