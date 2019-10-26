//
//  HelpViewController.m
//  GiftDIY
//
//  Created by Tong on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import "AddVASCustomCell.h"
#import "HelpDetailViewController.h"

@implementation HelpViewController
@synthesize listOfItems,iTable;
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
	
	self.navigationItem.title = @"Back";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
	
	UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeHelpView)];
	self.navigationItem.leftBarButtonItem = item;
	[item release];
	
	listOfItems = [[NSMutableArray alloc] init];
	iTable.backgroundColor = [UIColor clearColor];
	[listOfItems addObject:@"1.Introduce GiftDIY Menu and components"];
	[listOfItems addObject:@"2.GiftDIY Object description describe"];
	[listOfItems addObject:@"3.What is the Layering? how can I use the layer for GiftDIY"];
	[listOfItems addObject:@"3.GiftDIY property. Understanding all components in GiftDIY property"];
	
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


-(IBAction) closeHelpView
{
	[self dismissModalViewControllerAnimated:YES];
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
	[iTable release];
    [super dealloc];
}

-(void) tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
	HelpDetailViewController* view = [[HelpDetailViewController alloc]initWithNibName:@"HelpDetailViewController" bundle:nil];
	[view setISelectIndex:[indexPath row]];
	[[self navigationController] pushViewController:view animated:YES];
	[view release];
		
}
/*
 - (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [listOfItems count];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	static NSString *sampleIndentifier = @"My Identifier";
	AddVASCustomCell *cell = (AddVASCustomCell*)[tableView
												 dequeueReusableCellWithIdentifier:sampleIndentifier];
	if (cell == nil)
	{
		NSArray *topLevelObjects;
		topLevelObjects = [[NSBundle mainBundle]
						   loadNibNamed:@"AddVASCustomCell" owner:self options:nil];
		
		for(id currentObject in topLevelObjects)
		{
			if([currentObject isKindOfClass:[AddVASCustomCell class]])
			{
				cell = (AddVASCustomCell*)currentObject;
				break;
			}
		}
	}
	
	
	NSUInteger row = [indexPath row];
	
	UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	backView.backgroundColor = [UIColor clearColor];
	cell.backgroundView = backView;
	
	cell.iAddVASTxtView.backgroundColor = [UIColor clearColor];
	[cell.iAddVASTxtView setText:[listOfItems objectAtIndex:row]];
	cell.iAddVASImgView.hidden = YES;
	
	cell.iAddVASTxtView.textColor =[UIColor blackColor];

	
	
	return cell;
	
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
		static NSString *sampleIndentifier = @"My Identifier";
		AddVASCustomCell *cell = (AddVASCustomCell*)[tableView
													 dequeueReusableCellWithIdentifier:sampleIndentifier];
		if (cell == nil)
		{
			NSArray *topLevelObjects;
			topLevelObjects = [[NSBundle mainBundle]
							   loadNibNamed:@"AddVASCustomCell" owner:self options:nil];
			
			for(id currentObject in topLevelObjects)
			{
				if([currentObject isKindOfClass:[AddVASCustomCell class]])
				{
					cell = (AddVASCustomCell*)currentObject;
					break;
				}
			}
		}
		NSUInteger row = [indexPath row];
		[cell.iAddVASTxtView setText:[listOfItems objectAtIndex:row]];
		
		NSInteger height = [cell.iAddVASTxtView contentSize].height ;
		if(height> 37)
		{
			return height;
		}
		
		else {
			return 34;
		}
	
}
@end
