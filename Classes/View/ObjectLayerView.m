//
//  ObjectLayerView.m
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjectLayerView.h"
#import "MainData.h"
#import "DIYObject.h"
#import "GiftDIYViewController.h"
#import "ObjPropertyView.h"
#import "TextLayerCustomCell.h"
#import "LayerCustomCell.h"

@implementation ObjectLayerView
@synthesize iNavItem,delegate,iTable;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
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
	
	
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	self.navigationItem.title = @"Back";
	UIImage* image = [UIImage imageNamed:@"LayerTxt.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(-30, 5, 250, 35);
	[customView addSubview:imageView];
	
	//self.iNavItem.titleView = customView;
	self.navigationItem.titleView = customView; 
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
	//self.navigationItem.rightBarButtonItem = self.iNavItem.rightBarButtonItem;
	self.navigationItem.leftBarButtonItem = self.iNavItem.leftBarButtonItem;
	[imageView release];
	
	[super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	[iTable release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	MainData *userSetting = (MainData *)[MainData sharedMainData];
	return	 [[userSetting iDataObjectList] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	static NSString *sampleIndentifier = @"My Identifier";
	MainData *userSetting = (MainData *)[MainData sharedMainData];
	DIYObject* obj = [userSetting.iDataObjectList objectAtIndex:[indexPath row]];
	UIView* contView = obj.containView;
	if(obj.type == EImage)
	{
		if(obj.bgType ==2)
		{
			TextLayerCustomCell *cell = (TextLayerCustomCell*)[tableView
															   dequeueReusableCellWithIdentifier:sampleIndentifier];
			if (cell == nil)
			{
				NSArray *topLevelObjects;
				topLevelObjects = [[NSBundle mainBundle]
								   loadNibNamed:@"TextLayerCustomCell" owner:self options:nil];
				
				for(id currentObject in topLevelObjects)
				{
					if([currentObject isKindOfClass:[TextLayerCustomCell class]])
					{
						cell = (TextLayerCustomCell*)currentObject;
						break;
					}
				}
			}
			cell.backgroundView = [[[UACellBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.iTextImg.image =[UIImage imageNamed:@"GiftDIYText.png"];
			cell.iTxtLabel.text = obj.DIYtext;
			cell.iFontLabel.text = @"Fix";
			
			CGRect conrect = contView.frame;
			NSInteger xtxt = conrect.origin.x + 0.5f;
			NSInteger ytxt = conrect.origin.y + 0.5f;
			
			
			cell.iXLabel.text = [NSString stringWithFormat:@"%d",xtxt];
			cell.iYLabel.text = [NSString stringWithFormat:@"%d",ytxt];
			
			
			if(obj.IsPinned)
			{
				cell.iPinImg.hidden = NO;
			}
			else {
				cell.iPinImg.hidden = YES;
			}
			
			if(obj.containView.hidden){
				cell.iVisibleImg.hidden = YES;
			}
			else {
				cell.iVisibleImg.hidden = NO;
			}
			
			return cell;
		}
		else
		{
			LayerCustomCell *cell = (LayerCustomCell*)[tableView
													   dequeueReusableCellWithIdentifier:sampleIndentifier];
			if (cell == nil)
			{
				NSArray *topLevelObjects;
				topLevelObjects = [[NSBundle mainBundle]
								   loadNibNamed:@"LayerCustomCell" owner:self options:nil];
				
				for(id currentObject in topLevelObjects)
				{
					if([currentObject isKindOfClass:[LayerCustomCell class]])
					{
						cell = (LayerCustomCell*)currentObject;
						break;
					}
				}
			}
			cell.backgroundView = [[[UACellBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
			UIImageView* imgView  = obj.image;
			CGRect imgrect = imgView.frame;
			NSInteger wtxt = imgrect.size.width + 0.5f;
			NSInteger htxt = imgrect.size.height + 0.5f;
			cell.iImagePreview.image  = imgView.image;
			
			if(obj.image.contentMode == UIViewContentModeScaleAspectFit)
			{
				cell.iScaleImage.hidden = NO;
			}
			else {
				cell.iScaleImage.hidden = YES;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.iWidthLabel.text = [NSString stringWithFormat:@"%d",wtxt];
			cell.iHeightLabel.text = [NSString stringWithFormat:@"%d",htxt];
			
			CGRect conrect = contView.frame;
			NSInteger xtxt = conrect.origin.x + 0.5f;
			NSInteger ytxt = conrect.origin.y + 0.5f;
			
			
			cell.iXLabel.text = [NSString stringWithFormat:@"%d",xtxt];
			cell.iYLabel.text = [NSString stringWithFormat:@"%d",ytxt];
			
			
			if(obj.IsPinned)
			{
				cell.iPinImage.hidden = NO;
			}
			else {
				cell.iPinImage.hidden = YES;
			}
			
			if(obj.containView.hidden){
				cell.iVisibleImage.hidden = YES;
			}
			else {
				cell.iVisibleImage.hidden = NO;
			}
			
			return cell;
		}
	}
	else {
		TextLayerCustomCell *cell = (TextLayerCustomCell*)[tableView
														   dequeueReusableCellWithIdentifier:sampleIndentifier];
		if (cell == nil)
		{
			NSArray *topLevelObjects;
			topLevelObjects = [[NSBundle mainBundle]
							   loadNibNamed:@"TextLayerCustomCell" owner:self options:nil];
			
			for(id currentObject in topLevelObjects)
			{
				if([currentObject isKindOfClass:[TextLayerCustomCell class]])
				{
					cell = (TextLayerCustomCell*)currentObject;
					break;
				}
			}
		}
		cell.backgroundView = [[[UACellBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		CGRect conrect = contView.frame;
		
		NSInteger xtxt = conrect.origin.x + 0.5f;
		NSInteger ytxt = conrect.origin.y + 0.5f;
		NSInteger fonttxt = obj.textlab.font.pointSize +0.5f;
		
		cell.iTextImg.image =[UIImage imageNamed:@"GiftDIYText.png"];
		cell.iTxtLabel.text = obj.textlab.text;
		cell.iXLabel.text = [NSString stringWithFormat:@"%d",xtxt];
		cell.iYLabel.text = [NSString stringWithFormat:@"%d",ytxt];
		cell.iFontLabel.text = [NSString stringWithFormat:@"%d",fonttxt];
		
		if(obj.IsPinned)
		{
			cell.iPinImg.hidden = NO;
		}
		else {
			cell.iPinImg.hidden = YES;
		}
		
		if(obj.containView.hidden){
			cell.iVisibleImg.hidden = YES;
		}
		else {
			cell.iVisibleImg.hidden = NO;
		}
		return cell;
	}
	
	return nil;
}
-(IBAction) switchEditingState:(id)sender
{
	if([iTable isEditing])
	{
		[iTable setEditing:NO];
	}
	else {
		[iTable setEditing:YES];
	}
	
	
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 74;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MainData *userData = (MainData *)[MainData sharedMainData];
	ObjPropertyView* view = [[ObjPropertyView alloc] initWithNibName:@"ObjPropertyView" bundle:nil	];
	view.iSelectIndex = [indexPath row];
	userData.iSelectIndex = [indexPath row];
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}
-(IBAction) clearAllItem:(id)sender
{
	MainData *userData = (MainData *)[MainData sharedMainData];
	
	for(NSInteger i = 0 ; i < [userData.iDataObjectList count];i++)
	{
		DIYObject* obj = [userData.iDataObjectList objectAtIndex:i];
		UIView* imgView = obj.containView;
		[imgView removeFromSuperview];
		
		
	}
	[userData.iDataObjectList removeAllObjects];
	[iTable reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	MainData *userSetting = (MainData *)[MainData sharedMainData];
	if(editingStyle == UITableViewCellEditingStyleDelete)
	{
		DIYObject* obj = [userSetting.iDataObjectList objectAtIndex:[indexPath row]];
		if(obj.type == EImage)
		{
			UIView* imgView = obj.containView;
			[imgView removeFromSuperview];
			
		}
		else {
			UIView* View = obj.containView;
			[View removeFromSuperview];
		}
		[userSetting.iDataObjectList removeObjectAtIndex:[indexPath row]];
		[iTable reloadData];
	}
	
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	
	MainData *userSetting = (MainData *)[MainData sharedMainData];
	DIYObject* obj = [[userSetting.iDataObjectList objectAtIndex:[sourceIndexPath row]] retain];
	[userSetting.iDataObjectList removeObjectAtIndex:[sourceIndexPath row]];
	[userSetting.iDataObjectList insertObject:obj atIndex:[destinationIndexPath row]];
	[obj release];
}
-(IBAction) saveOrder:(id)sender
{
	[(GiftDIYViewController*) delegate ReAllocNewObject];
	[self dismissModalViewControllerAnimated:YES];
	return;
}
/*
 - (NSIndexPath *)tableView:(UITableView *)tableView
 targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
 toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
 // NSDictionary *section = [data objectAtIndex:sourceIndexPath.section];
 //NSUInteger sectionCount = [[section valueForKey:@"content"] count];
 
 if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
 NSUInteger rowInSourceSection =
 (sourceIndexPath.section > proposedDestinationIndexPath.section) ?
 0 : 1 - 1;
 return [NSIndexPath indexPathForRow:rowInSourceSection inSection:sourceIndexPath.section];
 } else if (proposedDestinationIndexPath.row >= 1) {
 return [NSIndexPath indexPathForRow:1 - 1 inSection:sourceIndexPath.section];
 }
 // Allow the proposed destination.
 return proposedDestinationIndexPath;
 }
 */

@end
