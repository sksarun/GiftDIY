//
//  ObjPropertyView.m
//  GiftDIY
//
//  Created by Tong on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjPropertyView.h"
#import "MainData.h"
#import "DIYObject.h"
#import "FontListViewController.h"
#import "BasicColorChooserController.h"
#import "CustomColorChooserViewController.h"
#import "UIImage+effect.h"


@implementation ObjPropertyView
@synthesize iFilterSegment,iFilterCell,iOpacitySlider,iOpacityCell,iOpacityLabel,iShadowSwitch,iShadowCell,bgImage,iTextfield,iTextCell,iVisibleSwitch,iVisibleCell,iPinnedCell,iPinnedSwitch,iColorTabbar,iColorIndicateView,iColorCell,iFontFamilylabel,iFontSizeCell,iFontFamilyCell,iFontsizeTextfield,iScaleSwitch,iBgSwitch,iBgCell,iDoneCell,iScaleCell,iHeightCell,iWidthCell,iYCell,iXCell,iAvaCell,iTable,iSelectIndex,imageSample,iXTextfield,iYTextfield,iWidthTextfield,iHeightTextfield;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//[self rotateBg:interfaceOrientation];
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	CGRect bgImageframe = bgImage.frame;
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
		bgImageframe.size.width = 480;
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		bgImageframe.size.width = 480;
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		bgImageframe.size.width = 320;
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		bgImageframe.size.width = 320;
    }
	
	bgImage.frame = bgImageframe;
}
-(void) rotateBg:(UIInterfaceOrientation) orientation
{
	CGRect bgImageframe = bgImage.frame;
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		bgImageframe.size.width = 480;
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
		bgImageframe.size.width = 480;
    } else if (orientation == UIInterfaceOrientationPortrait) {
		bgImageframe.size.width = 320;
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		bgImageframe.size.width = 320;
    }
	
	bgImage.frame = bgImageframe;
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	[self rotateBg:orientation];
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	UIView* contView = obj.containView;
	
	self.navigationItem.title = @"Back";
	self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
	if(obj.IsPinned)
	{
		iPinnedSwitch.on = YES;
	}
	else {
		iPinnedSwitch.on = NO;
	}
	
	if(obj.containView.hidden)
	{
		iVisibleSwitch.on = NO;
	}
	else {
		iVisibleSwitch.on = YES;
	}
	
	
	if(obj.type == EImage)
	{
		
		CGRect conrect = contView.frame;
		if(obj.bgType != 2)
		{
			UIImageView* imgView = obj.image;
			CGRect imgrect = imgView.frame;
			self.imageSample.image = imgView.image;
			iBaseWidth =  imgrect.size.width;
			iBaseHeight = imgrect.size.height;
			
			NSInteger wtxt = imgrect.size.width + 0.5f;
			NSInteger htxt = imgrect.size.height + 0.5f;
			[self.iWidthTextfield setText:[NSString stringWithFormat:@"%d",wtxt]];
			[self.iHeightTextfield setText:[NSString stringWithFormat:@"%d",htxt]];
		}
		else {
			[self.iTextfield setText:obj.DIYtext];
			//[imageSample addSubview:obj.ImagecontainView];
		}
		
		NSInteger xtxt = conrect.origin.x + 0.5f;
		NSInteger ytxt = conrect.origin.y + 0.5f;
		
		[self.iXTextfield setText:[NSString stringWithFormat:@"%d",xtxt]];
		[self.iYTextfield setText:[NSString stringWithFormat:@"%d",ytxt]];
		
		self.iFilterSegment.selectedSegmentIndex = obj.filterType;
		
		if(obj.IsSupportShadow)
		{
			if(obj.IsShadow)
			{
				self.iShadowSwitch.on = YES;
			}
			else {
				self.iShadowSwitch.on = NO;
			}
		}
		else {
			self.iShadowSwitch.enabled = NO;
		}

		
		self.iOpacityLabel.text = [NSString stringWithFormat:@"%.2f",obj.ImagecontainView.alpha];
		self.iOpacitySlider.value = obj.ImagecontainView.alpha;
		
		if(obj.bgType == 0)
		{
			if(obj.IsWhiteBg)
			{
				self.iBgSwitch.on = YES;
			}
			else {
				self.iBgSwitch.on = NO;
			}
		}
		
		if(obj.image.contentMode == UIViewContentModeScaleAspectFit)
		{
			self.iScaleSwitch.on = YES;
			
		}
		else {
			self.iScaleSwitch.on = NO;
		}
	}
	else {
		CGRect conrect = contView.frame;
		[self.iTextfield setText:obj.textlab.text];
		NSInteger xtxt = conrect.origin.x + 0.5f;
		NSInteger ytxt = conrect.origin.y + 0.5f;
		NSInteger fonttxt = obj.textlab.font.pointSize +0.5f;
		[self.iXTextfield setText:[NSString stringWithFormat:@"%d",xtxt]];
		[self.iYTextfield setText:[NSString stringWithFormat:@"%d",ytxt]];
		[self.iFontsizeTextfield setText:[NSString stringWithFormat:@"%d",fonttxt]];
	}
	
	
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	
	UIImage* image = [UIImage imageNamed:@"PropertyTxt.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	if([[self.navigationController viewControllers]count]>1)
	{
		imageView.frame = CGRectMake(0, 3, 250, 35);
	}
	else {
		imageView.frame = CGRectMake(25,3, 250, 35);
	}
	
	[customView addSubview:imageView];
	
	self.navigationItem.titleView = customView;
	[imageView release];
	
}
-(void) viewWillAppear:(BOOL)animated
{
	if(iTable)
	{
		[iTable reloadData];
	}
}
-(IBAction) opacityChange:(id)sender
{
	UISlider* slider = (UISlider*) sender;
	
	self.iOpacityLabel.text = [NSString stringWithFormat:@"%.2f",slider.value];
}
-(IBAction) DoneButton:(id)sender
{
	[self UpdateValue];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
	if(textField == iTextfield)
	{
		if ([textField.text length] > 20)
		{
			if([string length] ==1)
			{
				return NO;
			}
			else 
			{
				return YES;
			}
			
		}
		else
		{
			return YES; 
		}
	}
	else
	{
		if ([textField.text length] > 2)
		{
			if([string length] ==1)
			{
				return NO;
			}
			else 
			{
				return YES;
			}
			
		}
		else
		{
			return YES; 
		}
	}
}
-(IBAction) CancelButton:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
-(BOOL) IsAcceptValue
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	
	if(obj.type == EImage)
	{
		if(obj.bgType ==2)
		{
			NSString* textget = [iTextfield text];
			BOOL result;
			result = YES;
			for(int i = 0 ; i< [textget length] ;i++)
			{
				char c = [textget characterAtIndex:i];
				if ((c >= 65 && c <=90) || ( c >= 97 && c <=122)) // alphabet
				{
					
				}
				else 
				{
					result = NO;
				}
				
			}
			if(!result)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Art Text must be alphabet only." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
				return NO;
			}
			
		}
		else {
			NSInteger value  = [iWidthTextfield.text intValue];
			if(value >500||value<20)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"width value must not greater than 500 and not lower than 20" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
				return NO;
			}
			NSInteger hvalue  = [iHeightTextfield.text intValue];
			if(hvalue >500||hvalue<20)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"height value must not greater than 500 and not lower than 20" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
				return NO;
			}
		}
		
		
		NSInteger xvalue  = [iXTextfield.text intValue];
		NSInteger xlength  = [iXTextfield.text length];
		if(xvalue >319 && xlength >0)
		{
			UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"x value must not greater than 319" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
			return NO;
		}
		NSInteger yvalue  = [iYTextfield.text intValue];
		NSInteger ylength  = [iYTextfield.text length];
		if(yvalue >434 && ylength >0)
		{
			UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"y value must not greater than 434" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
			return NO;
		}
	}
	else {
		NSInteger xvalue  = [iXTextfield.text intValue];
		NSInteger xlength  = [iXTextfield.text length];
		if(xvalue >319 && xlength >0)
		{
			UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"x value must not greater than 319" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
			return NO;
		}
		NSInteger yvalue  = [iYTextfield.text intValue];
		NSInteger ylength  = [iYTextfield.text length];
		if(yvalue >434 && ylength >0)
		{
			UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"y value must not greater than 434" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
			return NO;
		}
		
		NSInteger value  = [iFontsizeTextfield.text intValue];
		if(value >200)
		{
			UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"fontsize value must not greater than 200" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alertview show];
			[alertview release];
			return NO;
		}
	}
	return YES;
}
-(void) UpdateValue
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	
	
	if([self IsAcceptValue]== NO)return;
	if(iPinnedSwitch.on == YES)
	{
		obj.IsPinned = YES;
	} 
	else {
		obj.IsPinned = NO;
	}
	
	if(obj.type == EImage)
	{
		
		if(iVisibleSwitch.on == YES)
		{
			obj.containView.hidden = NO;
			obj.ImagecontainView.hidden = NO;
		} 
		else {
			obj.containView.hidden = YES;
			obj.ImagecontainView.hidden = YES;
		}
		
		obj.image.image = obj.originalImage;
		
		if(self.iFilterSegment.selectedSegmentIndex == 1) // None
		{
			obj.image.image = [obj.image.image greyscaleImage];
			obj.filterType = EGray;
		}
		else if(self.iFilterSegment.selectedSegmentIndex == 2)
		{
			obj.image.image = [obj.image.image sepiaImage];
			obj.filterType = ESepia;
		}
		else {
			obj.filterType = ENone;
		}

		
		if(iShadowSwitch.on == YES)
		{
			obj.IsShadow = YES;
			obj.image.image = [obj.image.image imageWithShadow];
		}
		else 
		{
			obj.IsShadow = NO;
		}

		obj.ImagecontainView.alpha = self.iOpacitySlider.value;
		
		CGRect viewrect = obj.containView.frame;
		CGRect Imgviewrect = obj.ImagecontainView.frame;
		CGRect imgrect = obj.image.frame;
		if(obj.bgType != 2 )
		{
			if(viewrect.size.width != [[iWidthTextfield text] intValue] || viewrect.size.height !=[[iHeightTextfield text] intValue])
			{
				obj.ImagecontainView.transform = CGAffineTransformMakeRotation(0);
				obj.fixRotateValue = 0;
				viewrect.origin.x= [[iXTextfield text] intValue];
				viewrect.origin.y = [[iYTextfield text] intValue];
				viewrect.size.width = [[iWidthTextfield text] intValue];
				viewrect.size.height = [[iHeightTextfield text] intValue];
				imgrect.size.width = [[iWidthTextfield text] intValue];
				imgrect.size.height = [[iHeightTextfield text] intValue];
				Imgviewrect.size.width = [[iWidthTextfield text] intValue]+10;
				Imgviewrect.size.height = [[iHeightTextfield text] intValue]+10;
				obj.image.frame= imgrect;
				obj.ImagecontainView.frame= Imgviewrect;
				obj.containView.frame =viewrect; 
			}
			else 
			{
				viewrect.origin.x= [[iXTextfield text] intValue];
				viewrect.origin.y = [[iYTextfield text] intValue];
				obj.containView.frame =viewrect; 
			}

		}
		else 
		{
			if(obj.DIYtext != [iTextfield text])
			{
				[obj.ImagecontainView removeFromSuperview];
				[obj.ImagecontainView release];
				obj.ImagecontainView = nil;
				int uppercount=0;
				int lowercount =0;
				for(int i = 0 ; i< [[iTextfield text] length] ;i++)
				{
					if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[[iTextfield text] characterAtIndex:i]])
					{
						uppercount++;
					}
					else {
						lowercount++;
					}
				}
				obj.DIYtext = [iTextfield text];
				obj.ImagecontainView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 50*uppercount+40*lowercount, 64)];
				for(int i = 0 ; i< [[iTextfield text] length] ;i++)
				{
					if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[[iTextfield text] characterAtIndex:i]])
					{
						
						NSString* string = [NSString stringWithFormat:@"%@.png",[[iTextfield text] substringWithRange:NSMakeRange(i, 1)]];
						UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:string]];
						imageview.contentMode = UIViewContentModeScaleAspectFit;
						
						CGRect imageframe = imageview.frame;
						imageframe.origin.x = 50*i;
						imageview.frame = imageframe;
						
						[obj.ImagecontainView addSubview:imageview];
						[imageview release];
					}
					else {
						NSString* string = [NSString stringWithFormat:@"%@s.png",[[[iTextfield text] substringWithRange:NSMakeRange(i, 1)] uppercaseString]];
						UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:string]];
						imageview.contentMode = UIViewContentModeScaleAspectFit;
						
						CGRect imageframe = imageview.frame;
						imageframe.origin.x = 40*i;
						imageview.frame = imageframe;
						
						[obj.ImagecontainView addSubview:imageview];
						[imageview release];
					}
					
				}
				CGRect imgconframe = obj.ImagecontainView.frame;
				viewrect.size.width= imgconframe.size.width;
				viewrect.size.height = imgconframe.size.height;
			}
			viewrect.origin.x= [[iXTextfield text] intValue];
			viewrect.origin.y = [[iYTextfield text] intValue];
			obj.containView.frame =viewrect; 
			[obj.containView addSubview:obj.ImagecontainView];
		}
		
		CGRect rezimageframe = obj.resizeImage.frame;
		rezimageframe.origin.x = viewrect.size.width;
		rezimageframe.origin.y = viewrect.size.height;
		obj.resizeImage.frame = rezimageframe;
		
		CGRect rotmageframe = obj.rotateImage.frame;
		rotmageframe.origin.x = -48;
		rotmageframe.origin.y = viewrect.size.height;
		obj.rotateImage.frame = rotmageframe;
		
		CGRect fixrotimageframe = obj.fixrotateImage.frame;
		fixrotimageframe.origin.x =  viewrect.size.width;
		fixrotimageframe.origin.y =  -48;
		obj.fixrotateImage.frame = fixrotimageframe;
		
		if(iScaleSwitch.on == YES)
		{
			obj.image.contentMode = UIViewContentModeScaleAspectFit;
		}
		else {
			obj.image.contentMode = UIViewContentModeScaleToFill;
		}
		
		if(obj.bgType == 0)
		{
			if(iBgSwitch.on == YES)
			{
				obj.ImagecontainView.backgroundColor = [UIColor whiteColor];
				obj.IsWhiteBg = YES;
				
			}
			else {
				obj.ImagecontainView.backgroundColor = [UIColor clearColor];
				obj.IsWhiteBg = NO;
			}
		}
	}
	else {
		
		if(iVisibleSwitch.on == YES)
		{
			obj.containView.hidden = NO;
			obj.textlab.hidden = NO;
		} 
		else {
			obj.containView.hidden = YES;
			obj.textlab.hidden = YES;
		}
		NSInteger fonttxt = obj.textlab.font.pointSize +0.5f;
		NSInteger fontcheck = [[iFontsizeTextfield text] intValue];
		if(obj.textlab.text != [iTextfield text] ||  fontcheck != fonttxt)
		{
			obj.textlab.transform = CGAffineTransformMakeRotation(0);
			obj.textlab.text = [iTextfield text];
			
			obj.textlab.font = [obj.textlab.font fontWithSize:[[iFontsizeTextfield text] intValue]];
			CGSize size = [obj.textlab.text sizeWithFont:obj.textlab.font];
			
			CGRect viewrect = obj.containView.frame;
			CGRect labrect = obj.textlab.frame;
			viewrect.origin.x= [[iXTextfield text] intValue];
			viewrect.origin.y = [[iYTextfield text] intValue];
			viewrect.size.width = size.width+20;
			viewrect.size.height = size.height;
			labrect.size.width = size.width;
			labrect.size.height = size.height;
			obj.textlab.frame =labrect; 
			obj.containView.frame =viewrect; 
			
			CGRect rotmageframe = obj.rotateImage.frame;
			rotmageframe.origin.x = -48;
			rotmageframe.origin.y = viewrect.size.height;
			obj.rotateImage.frame = rotmageframe;
		}
		
		
	}
	[self dismissModalViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if([iTextfield isFirstResponder])
	{
		[iTextfield resignFirstResponder];
	}
	return YES;
}
#pragma mark memory management
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
	[self.iFilterSegment release];
	[self.iOpacityCell release];
	[self.iOpacityLabel release];
	[self.iOpacitySlider release];
	[self.iFilterCell release];
	[iShadowSwitch release];
	[iShadowCell release];
	[bgImage release];
	[iTextCell release];
	[iTextfield release];
	[iFontSizeCell release];
	[iFontFamilyCell release];
	[iFontsizeTextfield release];
	[imageSample release];
	[iXTextfield release];
	[iYTextfield release];
	[iWidthTextfield release];
	[iHeightTextfield release];
	[iAvaCell release];
	[iXCell release];
	[iYCell release];
	[iWidthCell release];
	[iHeightCell release];
	[iScaleCell release];
	[iBgCell release];
	[iDoneCell release];
	[iFontFamilylabel release];
	[iColorCell release];
	[iColorIndicateView release];
	[iPinnedCell release];
	[iPinnedSwitch release];
    [super dealloc];
}
#pragma mark tableView delegate
-(void) tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	if(obj.type == EImage)
	{
		if([iTextfield isFirstResponder])
		{
			NSString* textget = [iTextfield text];
			BOOL result;
			result = YES;
			for(int i = 0 ; i< [textget length] ;i++)
			{
				char c = [textget characterAtIndex:i];
				if ((c >= 65 && c <=90) || ( c >= 97 && c <=122)) // alphabet
				{
					
				}
				else 
				{
					result = NO;
				}
				
			}
			if(result)
			{
				[iTextfield resignFirstResponder];
			}
			else {
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Art Text must be alphabet only." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			
		}
		else if([iXTextfield isFirstResponder])
		{	
			NSInteger value  = [iXTextfield.text intValue];
			NSInteger length  = [iXTextfield.text length];
			if(value >319 && length >0)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"x value must not greater than 319" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else {
				[iXTextfield resignFirstResponder];
			}
			
			
		}
		else if([iYTextfield isFirstResponder])
		{
			NSInteger value  = [iYTextfield.text intValue];
			NSInteger length  = [iYTextfield.text length];
			if(value >434&&  length>0)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"y value must not greater than 434" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else {
				[iYTextfield resignFirstResponder];
			}
		}
		else if([iWidthTextfield isFirstResponder])
		{
			NSInteger value  = [iWidthTextfield.text intValue];
			if(value >500||value<20)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"width value must not greater than 500 and not lower than 20" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else
			{
				[iWidthTextfield resignFirstResponder];
			}
			
		}
		else if([iHeightTextfield isFirstResponder])
		{
			NSInteger value  = [iHeightTextfield.text intValue];
			if(value >500||value<20)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"height value must not greater than 500 and not lower than 20" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else
			{
				[iHeightTextfield resignFirstResponder];
			}
		}
		
	}
	else {
		if([iTextfield isFirstResponder])
		{
			[iTextfield resignFirstResponder];
		}
		else if([iXTextfield isFirstResponder])
		{
			NSInteger value  = [iXTextfield.text intValue];
			NSInteger length  = [iXTextfield.text length];
			if(value >319 && length>0)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"x value must not greater than 319" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else {
				[iXTextfield resignFirstResponder];
			}
		}
		else if([iYTextfield isFirstResponder])
		{
			NSInteger value  = [iYTextfield.text intValue];
			NSInteger length  = [iYTextfield.text length];
			if(value >434 && length > 0)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"y value must not greater than 434" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else {
				[iYTextfield resignFirstResponder];
			}
		}
		else  if([iFontsizeTextfield isFirstResponder]){
			
			NSInteger value  = [iFontsizeTextfield.text intValue];
			if(value >200)
			{
				UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"fontsize value must not greater than 200" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertview show];
				[alertview release];
			}
			else
			{
				[iFontsizeTextfield resignFirstResponder];
			}
		}
		else {
			if([indexPath section] == 1 &&[indexPath row] == 3)
			{
				FontListViewController* view = [[FontListViewController alloc]initWithNibName:@"FontListViewController" bundle:nil];
			    view.iSelectIndex = iSelectIndex;
				[self.navigationController pushViewController:view animated:YES];
				[view release];
			}
			else if([indexPath section] == 1 && [indexPath row] == 4)
			{
				[self.navigationController pushViewController:iColorTabbar animated:YES];
				
			}
		}
		
		
	}
	
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	if(obj.type == EText)
	{
		return 44;
	}
	else {
		if([indexPath row] == 0&& [indexPath section] == 0)
		{
			if(obj.bgType == 2)return 44;
			return 100;
		}
		else 
		{
			return 44;
		}
		
	}
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	if(obj.type == EText)
	{
		switch (section) {
			case 0:
				return 1;
			case 1:
				return 5;
			case 2:
				return 3;
			default:
				break;
		}
		//return 9;
	}
	else {
		if(obj.bgType == 0)
		{
			switch (section) {
				case 0:
					return 1;
				case 1:
					return 4;
				case 2:
					return 8;
				default:
					break;
			}
		}
		else if(obj.bgType == 1)
		{
			switch (section) {
				case 0:
					return 1;
				case 1:
					return 4;
				case 2:
					return 7;
				default:
					break;
			}
		}
		else {
			switch (section) {
				case 0:
					return 1;
				case 1:
					return 2;
				case 2:
					return 4;
				default:
					break;
			}
		}
		
	}
	return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	MainData* userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [userData.iDataObjectList objectAtIndex:iSelectIndex];
	if(obj.type == EImage)
	{
		if(obj.bgType == 0)
		{	
			switch ([indexPath section]) 
			{
				case 0:
					iAvaCell.backgroundColor = [UIColor clearColor];
					return iAvaCell;
				case 1:
					switch ([indexPath row]) 
					{
						case 0:
							[self.iXCell setPosition:UACellBackgroundViewPositionTop ] ;
							return iXCell;
						case 1:
							[self.iYCell setPosition:UACellBackgroundViewPositionMiddle ] ;
							return iYCell;
						case 2:
							[self.iWidthCell setPosition:UACellBackgroundViewPositionMiddle ] ;
							return iWidthCell;
						case 3:
							[self.iHeightCell setPosition:UACellBackgroundViewPositionBottom ] ;
							return iHeightCell;
						default:
							return nil;
					}
				case 2:
					switch ([indexPath row]) 
					{
					case 0:
						[self.iScaleCell setPosition:UACellBackgroundViewPositionTop ] ;
						return iScaleCell;
					case 1:
						[self.iShadowCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iShadowCell;
					case 2:
						[self.iPinnedCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iPinnedCell;
					case 3:
						[self.iOpacityCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iOpacityCell;
					case 4:
						[self.iFilterCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iFilterCell;
					case 5:
						[self.iVisibleCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iVisibleCell;
					case 6:
						[self.iBgCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iBgCell;
					case 7:
						[self.iDoneCell setPosition:UACellBackgroundViewPositionBottom ] ;
						return iDoneCell;
					default:
						return nil;
					}	
				default:
					break;
			}
		}
		else  if(obj.bgType == 1) {
			switch ([indexPath section]) 
			{
				case 0:
					iAvaCell.backgroundColor = [UIColor clearColor];
					return iAvaCell;
				case 1:
					switch ([indexPath row]) 
				{
					case 0:
						[self.iXCell setPosition:UACellBackgroundViewPositionTop ] ;
						return iXCell;
					case 1:
						[self.iYCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iYCell;
					case 2:
						[self.iWidthCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iWidthCell;
					case 3:
						[self.iHeightCell setPosition:UACellBackgroundViewPositionBottom ] ;
						return iHeightCell;
					default:
						return nil;
				}
				case 2:
					switch ([indexPath row]) 
				{
					case 0:
						[self.iScaleCell setPosition:UACellBackgroundViewPositionTop ] ;
						return iScaleCell;
					case 1:
						[self.iShadowCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iShadowCell;
					case 2:
						[self.iPinnedCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iPinnedCell;
					case 3:
						[self.iOpacityCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iOpacityCell;
					case 4:
						[self.iFilterCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iFilterCell;
					case 5:
						[self.iVisibleCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iVisibleCell;
					case 6:
						[self.iDoneCell setPosition:UACellBackgroundViewPositionBottom ] ;
						return iDoneCell;
					default:
						return nil;
				}	
				default:
					break;
			}
		}
		else {
			switch ([indexPath section]) 
			{
				case 0:
					[self.iTextCell setPosition:UACellBackgroundViewPositionSingle] ;
					return iTextCell;
				case 1:
					switch ([indexPath row]) 
				{
					case 0:
						[self.iXCell setPosition:UACellBackgroundViewPositionTop ] ;
						return iXCell;
					case 1:
						[self.iYCell setPosition:UACellBackgroundViewPositionBottom ] ;
						return iYCell;
					default:
						return nil;
				}
				case 2:
					switch ([indexPath row]) 
				{
					case 0:
						[self.iScaleCell setPosition:UACellBackgroundViewPositionTop ] ;
						return iScaleCell;
					case 1:
						[self.iPinnedCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iPinnedCell;
					case 2:
						[self.iVisibleCell setPosition:UACellBackgroundViewPositionMiddle ] ;
						return iVisibleCell;
					case 3:
						[self.iDoneCell setPosition:UACellBackgroundViewPositionBottom ] ;
						return iDoneCell;
					default:
						return nil;
				}	
				default:
					break;
			}
		}
	}
	else {
		
		switch ([indexPath section]) 
		{
			case 0:
				[self.iTextCell setPosition:UACellBackgroundViewPositionSingle] ;
				return iTextCell;
			case 1:
				switch ([indexPath row]) 
			{
				case 0:
					[self.iXCell setPosition:UACellBackgroundViewPositionTop ] ;
					return iXCell;
				case 1:
					[self.iYCell setPosition:UACellBackgroundViewPositionMiddle ] ;
					return iYCell;
				case 2:
					[self.iFontSizeCell setPosition:UACellBackgroundViewPositionMiddle ] ;
					return iFontSizeCell;
				case 3:
					[self.iFontFamilyCell setPosition:UACellBackgroundViewPositionMiddle ] ;
					iFontFamilylabel.text = [obj.textlab.font familyName];
					return iFontFamilyCell;
				case 4:
					[self.iColorCell setPosition:UACellBackgroundViewPositionBottom ] ;
					iColorIndicateView.backgroundColor = obj.textlab.textColor;
					return iColorCell;
				default:
					return nil;
			}
			case 2:
				switch ([indexPath row]) 
			{
				case 0:
					[self.iPinnedCell setPosition:UACellBackgroundViewPositionTop ] ;
					return iPinnedCell;
				case 1:
					[self.iVisibleCell setPosition:UACellBackgroundViewPositionMiddle ] ;
					return iVisibleCell;
				case 2:
					[self.iDoneCell setPosition:UACellBackgroundViewPositionBottom ] ;
					return iDoneCell;
				default:
					return nil;
			}	
			default:
				break;
		}
	}
	
	return nil;
}
#pragma mark view adjust
-(IBAction)setViewMovedUp:(id)sender
{	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5]; // if you want to slide up the view
	CGRect rect = self.view.frame;
	rect.origin.y -= 100;
	rect.size.height += 100;
	self.view.frame = rect;
	
	[UIView commitAnimations];
	
}
-(IBAction)setViewBackUp:(id)sender
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
	rect.origin.y += 100;
	rect.size.height -= 100;
	
    self.view.frame = rect;
    [UIView commitAnimations];
}
@end
