//
//  HelpDetailViewController.m
//  GiftDIY
//
//  Created by sarun krishnalome on 12/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpDetailViewController.h"


@implementation HelpDetailViewController
@synthesize iPropertyCell,iDIYCell,iLayerCell,iSelectIndex,iTable,iDescCell;
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
	
	UIImage* image = [UIImage imageNamed:@"HelpTxt.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(-10, 5, 250, 35);
	[customView addSubview:imageView];
	
	self.navigationItem.titleView = customView;
	[imageView release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[iTable release];
	[iDIYCell release];
	[iLayerCell release];
	[iDescCell release];
	[iPropertyCell release];
    [super dealloc];
}

-(void) tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
	
}
/*
 - (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
 switch (iSelectIndex) {
	 case 0:
		 return iDescCell;
	 case 1:
		 return iDIYCell;
	 case 2:
		 return iLayerCell;
	 case 3:
		 return iPropertyCell;
	 default:
		 break;
 }
	return nil;
	
	
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	 switch (iSelectIndex) 
	{
		case 0:
			return 1450;
		case 1:
			return 1350;
		case 2:
			return 2800;
		case 3:
			return 2500;
		default:
			return 44;
	}
	return 44;
}
@end
