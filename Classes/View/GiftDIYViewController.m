//
//  GiftDIYViewController.m
//  GiftDIY
//
//  Created by Tong on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GiftDIYViewController.h"
#import "ObjectChooserView.h"
#import "ObjectLayerView.h"
#import "MainData.h"
#import "ObjPropertyView.h"
#import "HelpViewController.h"
#import "AboutViewController.h"
#import "FrameChooserView.h"
#import "EffectViewController.h"
#import "UIImage+effect.h"

#import "DIYObject.h"
@implementation GiftDIYViewController
@synthesize bgImage,iToolbar;


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[UIApplication sharedApplication].statusBarHidden = YES;
	IsDelSelect = NO;
    [super viewDidLoad];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
		bgImage.transform = CGAffineTransformMakeRotation(M_PI/2);
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        bgImage.transform = CGAffineTransformMakeRotation(M_PI/2);
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
		bgImage.transform = CGAffineTransformMakeRotation(0);
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		bgImage.transform = CGAffineTransformMakeRotation(0);
    }
	CGRect bgImageframe = bgImage.frame;
	bgImageframe.origin.x = 0;
	bgImageframe.origin.y = 0;
	bgImage.frame = bgImageframe;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark view open

-(void)pickPhoto:(UIImagePickerControllerSourceType)sourceType{
	
	UIImagePickerController *picker	= [[UIImagePickerController alloc]init];
	picker.delegate = self;
	picker.sourceType = sourceType;
	picker.wantsFullScreenLayout = YES;
	[self presentModalViewController:picker animated:YES];
	
	//[self.view addSubview:picker.view];
	
}
-(void) imagepick
{
	[self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void) iconpick
{
	ObjectChooserView* view = [[ObjectChooserView alloc]initWithNibName:@"ObjectChooserView" bundle:nil];
	view.delegate = self;
	[self presentModalViewController:view animated:YES];
	[view release];
}
-(void) framepick
{
	FrameChooserView* view = [[FrameChooserView alloc]initWithNibName:@"FrameChooserView" bundle:nil];
	view.delegate = self;
	[self presentModalViewController:view animated:YES];
	[view release];
}
-(IBAction) Orderingpage:(id)sender{
	ObjectLayerView* view = [[ObjectLayerView alloc]initWithNibName:@"ObjectLayerView" bundle:nil];
	view.delegate = self;
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:view];
	[self presentModalViewController:controller animated:YES];
	[view release];
	[controller release];
	
}
-(IBAction)propertyView 
{
	MainData * userData = (MainData*)[MainData sharedMainData];
	if([userData.iDataObjectList count] > 0)
	{
		ObjPropertyView* view = [[ObjPropertyView alloc] initWithNibName:@"ObjPropertyView" bundle:nil	];
		view.iSelectIndex =selectIndex;
		userData.iSelectIndex = selectIndex;
		UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:view];
		[self presentModalViewController:controller animated:YES];
		[view release];
		[controller release];
	}
}
-(void)aboutView
{
	AboutViewController* view = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	[self presentModalViewController:view animated:YES];
	[view release];
	
}
-(void)helpview
{
	HelpViewController* view = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:view];
	[self presentModalViewController:controller animated:YES];
	[view release];
	[controller release];
}
#pragma mark giftDIYCreator
-(void) ReAllocNewObject
{
	MainData * userData = (MainData*)[MainData sharedMainData];
	for(int i = 0 ; i< [userData.iDataObjectList count] ; i++)
	{
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
		UIView* imageview =obj.containView;
		[imageview removeFromSuperview];
	}
	
	for(int i = 0 ; i< [userData.iDataObjectList count] ; i++)
	{
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
		UIView* imageview = obj.containView;
		//[self.view	addSubview:imageview];
		[self.view  insertSubview:imageview atIndex:[[self.view subviews]count]-1];
		
	}
}
-(void) AddGiftDIYTextObject:(NSString*)text
{
	[self ClearAllSelection];
	MainData * userData = (MainData*)[MainData sharedMainData];
	//text = [text uppercaseString];
	DIYObject* obj = [[DIYObject alloc]init];
	
	int uppercount=0;
	int lowercount =0;
	for(int i = 0 ; i< [text length] ;i++)
	{
		if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[text characterAtIndex:i]])
		{
			uppercount++;
		}
		else {
			lowercount++;
		}
	}
	obj.DIYtext = text;
	obj.ImagecontainView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 50*uppercount+40*lowercount, 64)];
	 for(int i = 0 ; i< [text length] ;i++)
	 {
		if([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[text characterAtIndex:i]])
		{
		
			NSString* string = [NSString stringWithFormat:@"%@.png",[text substringWithRange:NSMakeRange(i, 1)]];
			UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:string]];
			imageview.contentMode = UIViewContentModeScaleAspectFit;
			 
			CGRect imageframe = imageview.frame;
			imageframe.origin.x = 50*i;
			imageview.frame = imageframe;
			 
			[obj.ImagecontainView addSubview:imageview];
			[imageview release];
		}
		else {
			
			NSString* string = [NSString stringWithFormat:@"%@s.png",[[text substringWithRange:NSMakeRange(i, 1)] uppercaseString]];
			UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:string]];
			imageview.contentMode = UIViewContentModeScaleAspectFit;
			
			CGRect imageframe = imageview.frame;
			imageframe.origin.x = 40*i;
			imageview.frame = imageframe;
			
			[obj.ImagecontainView addSubview:imageview];
			[imageview release];
		}

	 }
	obj.IsPinned = NO;
	obj.IsWhiteBg = NO;
	file://localhost/Users/Tong/Documents/iPhone/My%20Project/GiftDIY/Classes/DIYObject.hobj.type = EImage;
	obj.bgType = 2;
	
	obj.delImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete.png"]];
	CGRect delimageframe = obj.delImage.frame;
	delimageframe.origin.x = -48;
	delimageframe.origin.y = -48;
	obj.delImage.frame = delimageframe;
	
	CGRect imgconframe = obj.ImagecontainView.frame;
	obj.containView = [[UIView alloc] initWithFrame:CGRectMake(0,0, imgconframe.size.width, imgconframe.size.height)];
	
	CGRect viewframe = obj.containView.frame;
	obj.fixrotateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fixrotate.png"]];
	CGRect fixrotimageframe = obj.fixrotateImage.frame;
	fixrotimageframe.origin.x = viewframe.size.width ;
	fixrotimageframe.origin.y = -48;
	obj.fixrotateImage.frame = fixrotimageframe;
	
	obj.rotateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotate.png"]];
	CGRect rotimageframe = obj.rotateImage.frame;
	rotimageframe.origin.x = -48;
	rotimageframe.origin.y = viewframe.size.height;
	obj.rotateImage.frame = rotimageframe;
	
	
	[userData.iDataObjectList addObject:obj];
	obj.IsSelect = YES;
	selectIndex = [userData.iDataObjectList count]-1;
	[obj.containView addSubview:obj.ImagecontainView];
	[obj.containView addSubview:obj.delImage];
	[obj.containView addSubview:obj.rotateImage];
	[obj.containView addSubview:obj.fixrotateImage];
	[self.view  insertSubview:obj.containView atIndex:[[self.view subviews]count]-1];
	
	[obj release];
	
}
-(void) AddTextFrameObject:(NSString*)text
{
	[self ClearAllSelection];
	MainData * userData = (MainData*)[MainData sharedMainData];
	//text = [text uppercaseString];
	DIYObject* obj = [[DIYObject alloc]init];
	CGRect screenbound = [UIScreen mainScreen].bounds;
	obj.ImagecontainView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 30*[text length], 30)];
	
	/*
	 for(int i = 0 ; i< [text length] ;i++)
	 {
	 
	 NSString* string = [NSString stringWithFormat:@"%@.png",[text substringWithRange:NSMakeRange(i, 1)]];
	 UIImageView* imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:string]];
	 imageview.contentMode = UIViewContentModeScaleAspectFit;
	 
	 CGRect imageframe = imageview.frame;
	 imageframe.origin.x = 30*i;
	 imageview.frame = imageframe;
	 
	 [obj.ImagecontainView addSubview:imageview];
	 [imageview release];
	 }
	 */
	obj.IsPinned = NO;
	obj.IsWhiteBg = NO;
	obj.textlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30*[text length], 30)];
	obj.textlab.text = text;
	obj.textlab.font = [UIFont fontWithName:@"Arial" size:20.0];
	obj.textlab.textColor = [UIColor blackColor];
	obj.textlab.backgroundColor = [UIColor clearColor];
	
	obj.type = EText;
	obj.bgType = 1;
	CGRect imgconframe = obj.ImagecontainView.frame;
	obj.containView = [[UIView alloc] initWithFrame:CGRectMake(screenbound.size.width/2, screenbound.size.height/2-100, imgconframe.size.width, imgconframe.size.height)];
	
	obj.delImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete.png"]];
	CGRect delimageframe = obj.delImage.frame;
	delimageframe.origin.x = -48;
	delimageframe.origin.y = -48;
	obj.delImage.frame = delimageframe;
	
	CGRect viewframe = obj.containView.frame;
	obj.resizeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resize.png"]];
	CGRect rezimageframe = obj.resizeImage.frame;
	rezimageframe.origin.x = viewframe.size.width ;
	rezimageframe.origin.y = viewframe.size.height;
	obj.resizeImage.frame = rezimageframe;
	
	obj.rotateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotate.png"]];
	CGRect rotimageframe = obj.rotateImage.frame;
	rotimageframe.origin.x = -48;
	rotimageframe.origin.y = viewframe.size.height;
	obj.rotateImage.frame = rotimageframe;
	
	CGSize size = [obj.textlab.text sizeWithFont:obj.textlab.font];
	
	CGRect viewrect = obj.containView.frame;
	CGRect labrect = obj.textlab.frame;
	viewrect.size.width = size.width+20;
	viewrect.size.height = size.height;
	labrect.size.width = size.width;
	labrect.size.height = size.height;
	obj.textlab.frame =labrect; 
	obj.containView.frame =viewrect; 
	
	[userData.iDataObjectList addObject:obj];
	selectIndex = [userData.iDataObjectList count]-1;
	obj.IsSelect = YES;
	[obj.containView addSubview:obj.delImage];
	[obj.containView addSubview:obj.textlab];
	[obj.containView addSubview:obj.rotateImage];
	[self.view  insertSubview:obj.containView atIndex:[[self.view subviews]count]-1];
	[obj release];
}

-(void) CreateDIYObject:(UIImage*)image withType:(NSInteger)type
{
	[self ClearAllSelection];
	MainData * userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj = [[DIYObject alloc]init];
	obj.image = [[UIImageView alloc] initWithImage:image];
	obj.image.contentMode = UIViewContentModeScaleToFill;
	//obj.image.image = [self BurnImage:obj.image.image];
	//make an original image
	obj.originalImage = image;
	obj.image.image = [obj.image.image imageWithShadow];
	if(obj.image.image == nil)
	{
		obj.image.image = obj.originalImage;
		obj.IsSupportShadow = NO;
		obj.IsShadow = NO;
	}
	else {
		obj.IsSupportShadow = YES;
		obj.IsShadow = YES;
	}

	obj.fixRotateValue = 0;
	obj.type = EImage;
	obj.IsPinned = NO;
	
	obj.filterType = ENone;
	obj.IsWhiteBg = NO;
	obj.delImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete.png"]];
	CGRect delimageframe = obj.delImage.frame;
	delimageframe.origin.x = -48;
	delimageframe.origin.y = -48;
	obj.delImage.frame = delimageframe;
	
	CGRect imageframe = obj.image.frame;
	if(type == 0)
	{
		imageframe.size = CGSizeMake(150, 150);
		imageframe.origin.x = 5;
		imageframe.origin.y = 5;
		obj.image.frame = imageframe;
		obj.ImagecontainView =  [[UIView alloc] initWithFrame:CGRectMake(0,0, imageframe.size.width+10, imageframe.size.height+10)];
	}
	else {
		imageframe.origin.x = 0;
		imageframe.origin.y = 0;
		obj.image.frame = imageframe;
		obj.ImagecontainView =  [[UIView alloc] initWithFrame:CGRectMake(0,0, imageframe.size.width, imageframe.size.height)];
	}
	
	CGRect imgconframe = obj.ImagecontainView.frame;
	obj.containView = [[UIView alloc] initWithFrame:CGRectMake(0,0, imgconframe.size.width, imgconframe.size.height)];
	if(type == 0)
	{
		obj.ImagecontainView.backgroundColor = [UIColor clearColor];
		obj.bgType = 0;
	}
	else {
		obj.bgType = 1; 
	}
	
	CGRect viewframe = obj.containView.frame;
	obj.fixrotateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fixrotate.png"]];
	CGRect fixrotimageframe = obj.fixrotateImage.frame;
	fixrotimageframe.origin.x = viewframe.size.width ;
	fixrotimageframe.origin.y = -48;
	obj.fixrotateImage.frame = fixrotimageframe;
	
	obj.resizeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resize.png"]];
	CGRect rezimageframe = obj.resizeImage.frame;
	rezimageframe.origin.x = viewframe.size.width ;
	rezimageframe.origin.y = viewframe.size.height;
	obj.resizeImage.frame = rezimageframe;
	
	obj.rotateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotate.png"]];
	CGRect rotimageframe = obj.rotateImage.frame;
	rotimageframe.origin.x = -48;
	rotimageframe.origin.y = viewframe.size.height;
	obj.rotateImage.frame = rotimageframe;
	
	
	[userData.iDataObjectList addObject:obj];
	obj.IsSelect = YES;
	selectIndex = [userData.iDataObjectList count]-1;
	[obj.ImagecontainView addSubview:obj.image];
	[obj.containView addSubview:obj.ImagecontainView];
	[obj.containView addSubview:obj.delImage];
	[obj.containView addSubview:obj.resizeImage];
	[obj.containView addSubview:obj.rotateImage];
	[obj.containView addSubview:obj.fixrotateImage];
	[self.view  insertSubview:obj.containView atIndex:[[self.view subviews]count]-1];
	
	[obj release];
}
-(void) AddFrameObject:(UIImage*)image
{
	[self CreateDIYObject:image withType:1];	
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	newImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	[picker dismissModalViewControllerAnimated:YES];
	[picker.view removeFromSuperview];
	[picker	release];
	[self CreateDIYObject:newImage withType:0];
	
}
#pragma mark touchHandle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	MainData * userData = (MainData*)[MainData sharedMainData];
	NSSet *allTouches = [event allTouches];
	if([allTouches count]==1)
	{
		UITouch *myTouch = [allTouches anyObject];
		CGPoint location = [myTouch locationInView:[self view]];
		if([userData.iDataObjectList count] <= 0 )return;
		for (int i =[userData.iDataObjectList count]-1 ; i >=0; i--) {
			DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
			if(obj.type == EImage || obj.type == EText )
			{
				CGRect target = obj.containView.frame;
				CGRect rottarget = obj.rotateImage.frame;
				CGRect reztarget = obj.resizeImage.frame;
				CGRect deltarget = obj.delImage.frame;
				CGRect fixrottarget = obj.fixrotateImage.frame;
				CGRect resizepos = CGRectMake(target.origin.x+reztarget.origin.x, target.origin.y+reztarget.origin.y, reztarget.size.width,reztarget.size.height);
				CGRect rotatepos = CGRectMake(target.origin.x+rottarget.origin.x, target.origin.y+rottarget.origin.y, rottarget.size.width,rottarget.size.height);
				CGRect deletepos = CGRectMake(target.origin.x+deltarget.origin.x, target.origin.y+deltarget.origin.y, deltarget.size.width,deltarget.size.height);
				CGRect fixrotatepos = CGRectMake(target.origin.x+fixrottarget.origin.x, target.origin.y+fixrottarget.origin.y, fixrottarget.size.width,fixrottarget.size.height);
				if(CGRectContainsPoint(resizepos, location))
				{
					[self ClearAllSelection];
					obj.ResizeSel = YES;
					obj.IsSelect = YES;
					obj.resizeImage.hidden = NO;
					obj.delImage.hidden = NO;
					obj.rotateImage.hidden = NO;
					obj.fixrotateImage.hidden = NO;
					selectIndex = i;
					lastLoc = location;
					obj.ImagecontainView.transform = CGAffineTransformMakeRotation(0);
					obj.mainAngle = 0;
					obj.fixRotateValue = 0;
					return;
				}
				if(CGRectContainsPoint(rotatepos, location))
				{
					[self ClearAllSelection];
					obj.RotateSel = YES;
					obj.IsSelect = YES;
					obj.resizeImage.hidden = NO;
					obj.delImage.hidden = NO;
					obj.rotateImage.hidden = NO;
					obj.fixrotateImage.hidden = NO;
					obj.fixRotateValue = 0;
					selectIndex = i;
					lastLoc = location;
					return;
				}
				if(CGRectContainsPoint(target, location))
				{
					[self ClearAllSelection];
					obj.IsSelect = YES;
					obj.resizeImage.hidden = NO;
					obj.delImage.hidden = NO;
					obj.rotateImage.hidden = NO;
					obj.fixrotateImage.hidden = NO;
					selectIndex = i;
					lastLoc = CGPointMake(obj.containView.center.x - location.x,obj.containView.center.y - location.y );
					return;
				}
				if(CGRectContainsPoint(deletepos, location))
				{
					obj.IsSelect = YES;
					IsDelSelect = YES;
					return;
				}
				if(CGRectContainsPoint(fixrotatepos, location))
				{
					obj.IsSelect = YES;
					IsFixrotSelect = YES;
					return;
				}
				
			}
			else {
				CGRect target = obj.containView.frame;
				if(CGRectContainsPoint(target, location))
				{
					selectIndex = i;
					return;
				}
			}
		}
		
		[self ClearAllSelection];
	}
	else if([allTouches count]==2)
	{
		
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch *touch2= [[allTouches allObjects] objectAtIndex:1];
		CGPoint location1 = [touch1 locationInView:[self view]];
		CGPoint location2 = [touch2 locationInView:[self view]];
		
		if([userData.iDataObjectList count] <= 0 )return;
		for (int i =[userData.iDataObjectList count]-1 ; i >=0; i--) 
		{
			DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
			CGRect target = obj.containView.frame;
			if(CGRectContainsPoint(target, location1) || CGRectContainsPoint(target, location2))
			{
				DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
				[self ClearAllSelection];
				obj.ResizeSel = YES;
				obj.IsSelect = YES;
				obj.resizeImage.hidden = NO;
				obj.delImage.hidden = NO;
				obj.rotateImage.hidden = NO;
				obj.fixrotateImage.hidden = NO;
				selectIndex = i;
				lastLoc1 = location1;
				lastLoc2 = location2;
				obj.ImagecontainView.transform = CGAffineTransformMakeRotation(0);
				obj.mainAngle = 0;
				return;
			}
		}
		
		
	}
	
}
-(void) ClearAllSelection
{
	MainData * userData = (MainData*)[MainData sharedMainData];
	for (int i =[userData.iDataObjectList count]-1 ; i >=0; i--) {
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
		obj.IsSelect = NO;
		obj.resizeImage.hidden = YES;
		obj.delImage.hidden = YES;
		obj.rotateImage.hidden = YES;
		obj.fixrotateImage.hidden = YES;
	}
	
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	MainData * userData = (MainData*)[MainData sharedMainData];
	if([userData.iDataObjectList count] <= 0 )return;
	
	NSSet *allTouches = [event allTouches];
	if([allTouches count]==1)
	{
		UITouch *myTouch = [touches anyObject];
		CGPoint location = [myTouch locationInView:[self view]];
		if(selectIndex >= [userData.iDataObjectList count])return;
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:selectIndex];
		if(!obj.IsSelect)return; 
		if(obj.type == EImage || obj.type == EText  && obj.IsSelect)
		{
			iToolbar.hidden = YES;
			if(obj.ResizeSel)
			{
				
				CGRect viewrect = obj.containView.frame;
				CGRect Imgviewrect = obj.ImagecontainView.frame;
				CGRect imgrect = obj.image.frame;
				
				NSInteger difcalx = Imgviewrect.size.width +(location.x - lastLoc.x);
				NSInteger difcaly = Imgviewrect.size.height +(location.y - lastLoc.y);
				if(difcalx >20 &&difcaly > 20)
				{
					viewrect.size.width += location.x - lastLoc.x;
					viewrect.size.height += location.y - lastLoc.y;
					obj.containView.frame = viewrect;
					Imgviewrect.size.width += location.x - lastLoc.x;
					Imgviewrect.size.height += location.y - lastLoc.y;
					obj.ImagecontainView.frame = Imgviewrect;
					imgrect.size.width += location.x - lastLoc.x;
					imgrect.size.height += location.y - lastLoc.y;
					obj.image.frame = imgrect;
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
				}
				lastLoc = location;
				
			}
			else if(obj.RotateSel)
			{
				CGRect viewrect = obj.containView.frame;
				CGPoint actualCen = CGPointMake(0,0);
				if(obj.type == EText)
				{
					actualCen = CGPointMake(viewrect.origin.x+obj.textlab.center.x, viewrect.origin.y+obj.textlab.center.y);
				}
				else {
					actualCen = CGPointMake(viewrect.origin.x+obj.image.center.x, viewrect.origin.y+obj.image.center.y);
				}

				double b = sqrt(pow(actualCen.x-location.x,2.0)+pow(actualCen.y-location.y,2.0));
				//double a = sqrt(pow(touchLocation.x-markPoint.x,2.0)+pow(markPoint.y-touchLocation.y,2.0));
				double a = sqrt(pow(location.x-lastLoc.x,2.0)+pow(location.y-lastLoc.y,2.0));
				double adivb = (a/b);
				double sinb = 1.0;
				if(actualCen.x > location.x)
				{
					if(location.y<lastLoc.y)
					{
						sinb = 1.0;
					}
					else {
						sinb = -1.0;
					}
					
				}
				else if(actualCen.x == location.x)
				{
					if(lastLoc.x < location.x)
					{
						if(location.y<lastLoc.y)
						{
							sinb = 1.0;
						}
						else {
							sinb = -1.0;
						}
					}
					else {
						if(location.y<lastLoc.y)
						{
							sinb = -1.0;
						}
						else {
							sinb = 1.0;
						}
					}
					
				}
				else {
					if(location.y<lastLoc.y)
					{
						sinb = -1.0;
					}
					else {
						sinb = 1.0;
					}
				}
				
				
				double angle = asin(adivb*sinb);
				
				obj.mainAngle += angle;
				if(obj.mainAngle !=  obj.mainAngle) // NaN protection
				{
					obj.mainAngle = 0;
				}
				if(obj.type == EText)
				{
					obj.textlab.transform = CGAffineTransformMakeRotation(obj.mainAngle);
				}
				else {
					obj.ImagecontainView.transform = CGAffineTransformMakeRotation(obj.mainAngle);
				}
				
				lastLoc = location;
				
			}
			else 
			{
				if(obj.IsPinned) return;
				[obj.containView setCenter:CGPointMake(location.x+lastLoc.x,location.y+lastLoc.y)];
			}
			
			
		}
		else {
			[obj.containView setCenter:location];
		}
	}
	else if([allTouches count]==2)
	{
		if(selectIndex >= [userData.iDataObjectList count])return;
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:selectIndex];
		if(!obj.ResizeSel)return;
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
		CGPoint location1 = [touch1 locationInView:[self view]];
		CGPoint location2 = [touch2 locationInView:[self view]];
		/*
		 [UIView beginAnimations:@"aw" context:nil];
		 obj.containView.transform =  CGAffineTransformWithTouches(obj.containView.transform, touch1, touch2,selectIndex);
		 obj.ImagecontainView.transform =  CGAffineTransformWithTouches(obj.ImagecontainView.transform, touch1, touch2,selectIndex);
		 obj.image.transform =  CGAffineTransformWithTouches(obj.image.transform, touch1, touch2,selectIndex);
		 [UIView	 commitAnimations];
		 */
		
		CGFloat PrevDistance = [self distanceBetween:lastLoc1 withPoint:lastLoc2];
		CGFloat CurDistance = [self distanceBetween:location1 withPoint:location2];
		CGFloat Distance = [self distanceBetween:lastLoc1 withPoint:location1];
		//NSLog([NSString stringWithFormat:@"Prev:%f Cur:%f Dis:%f",PrevDistance,CurDistance,Distance]);
		iToolbar.hidden = YES;
		
		CGRect viewrect = obj.containView.frame;
		CGRect Imgviewrect = obj.ImagecontainView.frame;
		CGRect imgrect = obj.image.frame;
		
		if(PrevDistance > CurDistance) //Zoom out
		{	
			
			//viewrect.origin.x += Distance/2;
			//viewrect.origin.y += Distance/2;
			viewrect.size.width -= Distance;
			viewrect.size.height -= Distance;
			
			//Imgviewrect.origin.x += Distance/2;
			//Imgviewrect.origin.y += Distance/2;
			Imgviewrect.size.width -= Distance;
			Imgviewrect.size.height -= Distance;
			
			//imgrect.origin.x += Distance/2;
			//imgrect.origin.y += Distance/2;
			imgrect.size.height -= Distance;
			imgrect.size.width -= Distance;
		}
		else //Zoom in 
		{
			//viewrect.origin.x -= Distance/2;
			//viewrect.origin.y -= Distance/2;
			viewrect.size.width += Distance;
			viewrect.size.height += Distance;
			
			
			//Imgviewrect.origin.x -= Distance/2;
			//Imgviewrect.origin.y -= Distance/2;
			Imgviewrect.size.width += Distance;
			Imgviewrect.size.height += Distance;
			
			
			//imgrect.origin.x -= Distance/2;
			//imgrect.origin.y -= Distance/2;
			imgrect.size.height += Distance;
			imgrect.size.width += Distance;
		}
		
		
		if(Imgviewrect.size.width >20 &&Imgviewrect.size.height > 20)
		{
			//[UIView beginAnimations:@"aw" context:nil];
			obj.ImagecontainView.frame = Imgviewrect;
			obj.containView.frame = viewrect;
			obj.image.frame = imgrect;
			
			//[UIView	 commitAnimations];
			CGRect rezimageframe = obj.resizeImage.frame;
			rezimageframe.origin.x = viewrect.size.width;
			rezimageframe.origin.y = viewrect.size.height;
			obj.resizeImage.frame = rezimageframe;
			
			
			CGRect deimgframe = obj.delImage.frame;
			deimgframe.origin.x = -48;
			deimgframe.origin.y = -48;
			obj.delImage.frame = deimgframe;
			
			CGRect rotmageframe = obj.rotateImage.frame;
			rotmageframe.origin.x = -48;
			rotmageframe.origin.y = viewrect.size.height;
			obj.rotateImage.frame = rotmageframe;
			
			CGRect fixrotimageframe = obj.fixrotateImage.frame;
			fixrotimageframe.origin.x =  viewrect.size.width;
			fixrotimageframe.origin.y =  -48;
			obj.fixrotateImage.frame = fixrotimageframe;
			
			lastLoc1 = location1;
			lastLoc2 = location2;		
		}
		
	}
	
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *myTouch = [touches anyObject];
	if(iToolbar.hidden)
	{
		iToolbar.hidden = NO;
	}
	MainData * userData = (MainData*)[MainData sharedMainData];
	if([userData.iDataObjectList count] <= 0 )return;
	for (int i =[userData.iDataObjectList count]-1 ; i >=0; i--) {
		DIYObject* obj =[userData.iDataObjectList objectAtIndex:i];
		if(obj.type == EImage || obj.type == EText  )
		{
			if(obj.IsSelect && IsDelSelect)
			{
				CGPoint location = [myTouch locationInView:obj.containView];
				CGRect target = obj.delImage.frame;
				if(CGRectContainsPoint(target, location))
				{
					[obj.containView removeFromSuperview];
					obj.IsSelect = NO;
					IsDelSelect = NO;
					[userData.iDataObjectList removeObjectAtIndex:i];
					
					return;
				}
			}
			
			if(obj.IsSelect && IsFixrotSelect)
			{
				CGPoint location = [myTouch locationInView:obj.containView];
				CGRect target = obj.fixrotateImage.frame;
				if(CGRectContainsPoint(target, location))
				{
					if(obj.fixRotateValue < 3)
					{
						obj.fixRotateValue++;
					}
					else {
						obj.fixRotateValue = 0;
					}

					obj.ImagecontainView.transform = CGAffineTransformMakeRotation(M_PI*obj.fixRotateValue/2);
					IsFixrotSelect = NO;
					return;
				}
			}
		}
	}
	if(selectIndex >= [userData.iDataObjectList count])return;
	DIYObject* curobj =[userData.iDataObjectList objectAtIndex:selectIndex];
	curobj.ResizeSel = NO;
	curobj.RotateSel = NO;
	IsDelSelect = NO;
	IsFixrotSelect = NO;
}
-(void) AddText:(NSInteger)type
{
	UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"AddText"] message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
	CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 20.0);
	[myAlertView setTransform:myTransform];
	myAlertView.tag = type;
	[myTextField setBackgroundColor:[UIColor whiteColor]];
	[myAlertView addSubview:myTextField];
	[myAlertView setDelegate:self];
	[myAlertView show];
	[myAlertView release];
	[myTextField release];
}
#pragma mark alert and actionsheet
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{ 
		NSInteger count = [[alertView subviews]count];
		if(alertView.tag == 1)
		{
			[self AddTextFrameObject:[(UITextField*)[[alertView subviews] objectAtIndex:count-1] text]];
		}
		else {
			NSString* checktext = [(UITextField*)[[alertView subviews] objectAtIndex:count-1] text];
			BOOL result;
			result = YES;
			for(int i = 0 ; i< [checktext length] ;i++)
			{
				char c = [checktext characterAtIndex:i];
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
				[self AddGiftDIYTextObject:[(UITextField*)[[alertView subviews] objectAtIndex:count-1] text]];
			}
			else {
				UIAlertView* alertviews = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Only english alphabet allow.Please try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alertviews show];
				[alertviews release];
			}

		}

	}
	else
	{
		[self dismissModalViewControllerAnimated:YES];
	}
}

-(void)popupActionSheet {
    UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"Share via facebook",@"Share via Email",@"Save to Gallery",nil];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	popupQuery.tag = 2;
    [popupQuery showInView:self.view];
    [popupQuery release];
}
-(IBAction)popupImageActionSheet 
{
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:@"AddImageType"
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"Photo Album",@"GiftDIYImage",@"GiftDIYFrame",@"GiftDIYText",@"ArtText",nil];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	popupQuery.tag = 1;
    [popupQuery showInView:self.view];
    [popupQuery release];
}
-(IBAction)popupOtherActionSheet 
{
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:@"Choose Options"
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"Save GiftDIY",@"About GiftDIY",@"Help",nil];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	popupQuery.tag = 3;
    [popupQuery showInView:self.view];
    [popupQuery release];
}
- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(actionSheet.tag == 1)
	{

		if(buttonIndex == 0)
		{
			[self imagepick];
		}
		else if(buttonIndex == 1)
		{
			[self iconpick];
		}
		else if(buttonIndex == 2)
		{
			[self framepick];
		}
		else if(buttonIndex == 3)
		{
			[self AddText:1];
		}
		else if(buttonIndex == 4)
		{
			[self AddText:2];
		}
	}
	else if(actionSheet.tag == 2) {
		if(buttonIndex == 0)
		{
			[self SharetoFB];
		}
		else if(buttonIndex == 1)
		{
			[self SharetoEmail];
		}
		else if(buttonIndex == 2)
		{
			[self SaveImageToGallery];
		}
		else{
				iToolbar.hidden = YES;
		}
	}
	else {
		if(buttonIndex == 0)
		{
			[self popupActionSheet];
		}
		else if(buttonIndex == 1)
		{
			[self aboutView];
		}
		else if(buttonIndex == 2){
			[self helpview];
		}

	}

}
#pragma mark event handler
-(void) SharetoFB
{
	iToolbar.hidden = YES;
	[self ClearAllSelection];
	
	UIGraphicsBeginImageContext(self.view.window.frame.size);
	[self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	MainData * userData = (MainData*)[MainData sharedMainData];
	[userData setUpLoadImg:anImage];
	[userData PostFB:nil];
}
-(IBAction)hideTab
{
	
	[UIView beginAnimations:nil context:nil];
	[self ClearAllSelection];
	iToolbar.hidden = YES;
	[UIView commitAnimations];
}
-(void) SharetoEmail
{
	iToolbar.hidden = YES;
	[self ClearAllSelection];
	
	UIGraphicsBeginImageContext(self.view.window.frame.size);
	[self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	MainData * userData = (MainData*)[MainData sharedMainData];
	[userData setDelegate:self];
	[userData SentEmailWithImage:anImage withTitle:@"GiftDIY"];
}
-(void) SaveImageToGallery
{
	//save image
	iToolbar.hidden = YES;
	[self ClearAllSelection];
	
	UIGraphicsBeginImageContext(self.view.window.frame.size);
	[self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	UIImageWriteToSavedPhotosAlbum(anImage, nil, nil, nil);
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Your image has been save in photo gallery" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}
/*
-(UIImage*)imageWithBlurAroundPoint:(CGPoint)point {
	CGRect             bnds = CGRectZero;
	UIImage*           copy = nil;
	CGContextRef       ctxt = nil;
	CGImageRef         imag = self.CGImage;
	CGRect             rect = CGRectZero;
	CGAffineTransform  tran = CGAffineTransformIdentity;
	int                indx = 0;
	
	rect.size.width  = CGImageGetWidth(imag);
	rect.size.height = CGImageGetHeight(imag);
	
	bnds = rect;
	
	UIGraphicsBeginImageContext(bnds.size);
	ctxt = UIGraphicsGetCurrentContext();
	
	// Cut out a sample out the image
	CGRect fillRect = CGRectMake(point.x - 10, point.y - 10, 20, 20);
	CGImageRef sampleImageRef = CGImageCreateWithImageInRect(self.CGImage, fillRect);
	
	// Flip the image right side up & draw
	CGContextSaveGState(ctxt);
	
	CGContextScaleCTM(ctxt, 1.0, -1.0);
	CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
	CGContextConcatCTM(ctxt, tran);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
	
	// Restore the context so that the coordinate system is restored
	CGContextRestoreGState(ctxt);
	
	// Cut out a sample image and redraw it over the source rect
	// several times, shifting the opacity and the positioning slightly
	// to produce a blurred effect
	for (indx = 0; indx < 5; indx++) {
		CGRect myRect = CGRectOffset(fillRect, 0.5 * indx, 0.5 * indx);
		CGContextSetAlpha(ctxt, 0.2 * indx);
		CGContextScaleCTM(ctxt, 1.0, -1.0);
		CGContextDrawImage(ctxt, myRect, sampleImageRef);
	}
	
	copy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return copy;
}
 */
#pragma mark math
-(CGFloat) distanceBetween: (CGPoint) point1 withPoint: (CGPoint)point2
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}

CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
	CGFloat distance;
	
	//Square difference in x
	CGFloat xDifferenceSquared = pow(firstPoint.x - secondPoint.x, 2);
	// NSLog(@"xDifferenceSquared: %f", xDifferenceSquared);
	
	// Square difference in y
	CGFloat yDifferenceSquared = pow(firstPoint.y - secondPoint.y, 2);
	// NSLog(@"yDifferenceSquared: %f", yDifferenceSquared);
	
	// Add and take Square root
	distance = sqrt(xDifferenceSquared + yDifferenceSquared);
	// NSLog(@"Distance: %f", distance);
	return distance;
	
}

CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
	// NSLog(@"Point One: %f, %f", firstPoint.x, firstPoint.y);
	// NSLog(@"Point Two: %f, %f", secondPoint.x, secondPoint.y);
	
	CGFloat xDifference = firstPoint.x - secondPoint.x;
	CGFloat yDifference = firstPoint.y - secondPoint.y;
	
	CGPoint result = CGPointMake(xDifference, yDifference);
	
	return result;
}

CGAffineTransform CGAffineTransformWithTouches(CGAffineTransform oldTransform, 
											   UITouch *firstTouch, 
											   UITouch *secondTouch,NSInteger index) {
	
	CGPoint firstTouchLocation = [firstTouch locationInView:nil];
	CGPoint firstTouchPreviousLocaion = [firstTouch previousLocationInView:nil];
	CGPoint secondTouchLocation = [secondTouch locationInView:nil];
	CGPoint secondTouchPreviousLocaion = [secondTouch previousLocationInView:nil];
	
	CGAffineTransform newTransform;
	
	// Calculate new scale and rotation
	
	// Get distance between points
	CGFloat currentDistance = distanceBetweenPoints(firstTouchLocation,
													secondTouchLocation);
	
	CGFloat previousDistance = distanceBetweenPoints(firstTouchPreviousLocaion,
													 secondTouchPreviousLocaion);
	
	// Figure new scale
	
	CGFloat distanceRatio = currentDistance / previousDistance;
	// NSLog(@"DifferenceRatio: %f, %f", distanceRatio.x, distanceRatio.y);
	MainData * userData = (MainData*)[MainData sharedMainData];
	DIYObject* obj =[userData.iDataObjectList objectAtIndex:index];
	if(distanceRatio >1)
	{
		if(obj.ImagecontainView.frame.size.width >= 350)
		{
			distanceRatio = 1;
		}
	}
	else {
		if(obj.ImagecontainView.frame.size.width <= 20)
		{
			distanceRatio = 1;
		}
	}
	
	// Combine with current transform
	newTransform = CGAffineTransformScale(oldTransform, distanceRatio, distanceRatio);
	
	
	// Now figure new rotation
	
	// Get previous angle
	/*
	 CGPoint previousDifference = vectorBetweenPoints(firstTouchPreviousLocaion, secondTouchPreviousLocaion);
	 CGFloat xDifferencePrevious = previousDifference.x;
	 
	 // Use acos to get angle to avoid issue with the denominator being 0
	 CGFloat previousRotation = acos(xDifferencePrevious / previousDistance); // adjacent over hypotenuse
	 if (previousDifference.y < 0) {
	 // account for acos of angles in quadrants III and IV
	 previousRotation *= -1;
	 }
	 // NSLog(@"previousRotation: %f", previousRotation);
	 
	 // Get current angle
	 CGPoint currentDifference = vectorBetweenPoints(firstTouchLocation, secondTouchLocation);
	 CGFloat xDifferenceCurrent = currentDifference.x;
	 
	 // Use acos to get angle to avoid issue with the denominator being 0
	 CGFloat currentRotation = acos(xDifferenceCurrent / currentDistance); // adjacent over hypotenuse 
	 if (currentDifference.y < 0) {
	 // account for acos of angles in quadrants III and IV
	 currentRotation *= -1;
	 }
	 // NSLog(@"currentRotation: %f", currentRotation);
	 
	 CGFloat newAngle = currentRotation - previousRotation;
	 
	 // Combine with current transform
	 newTransform = CGAffineTransformRotate(newTransform, newAngle);
	 */
	// Return result
	return newTransform;
}


@end
