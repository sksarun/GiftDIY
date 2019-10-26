//
//  MainData.m
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainData.h"

#import "SynthesizeSingleton.h"
#import "FBStreamDialog.h"
#import "FBRequest.h"
#import "FBPermissionDialog.h"

@implementation MainData
SYNTHESIZE_SINGLETON_FOR_CLASS(MainData);
@synthesize iSelectIndex,imageData,upLoadImg,facebookName,iDataObjectList;

-(id)init
{
	self = [super init];
	iDataObjectList = [[NSMutableArray alloc]init];
	iSelectIndex = 0;
	
	if(session == nil)
	{
		static NSString* kApiKey = @"7e7b0631364160dbd16921757271d77f";
		static NSString* kApiSecret = @"69af64c9bc9ffb57af7090f5ea25b155";
		session = [[FBSession sessionForApplication:kApiKey 
											 secret:kApiSecret 
										   delegate:self] retain];
	}
	return self;
}

-(void) dealloc
{
	[facebookName release];
	[upLoadImg release];
	[iDataObjectList release];
	[imageData release];
	[super dealloc];
}

#pragma mark Get Facebook Name Helper

-(void)PostFB:(id)sender
{
	/*
	if(session == nil)
	{
		static NSString* kApiKey = @"7e7b0631364160dbd16921757271d77f";
		static NSString* kApiSecret = @"69af64c9bc9ffb57af7090f5ea25b155";
		session = [[FBSession sessionForApplication:kApiKey 
											 secret:kApiSecret 
										   delegate:self] retain];
	}
	*/
	[session logout];
	FBLoginDialog* dialog = [[[FBLoginDialog alloc] init] autorelease];
	[dialog show];
}

- (void)getFacebookName {
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", session.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

#pragma mark FBRequestDelegate methods

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		if([result count] > 0)
		{
			NSDictionary* user = [users objectAtIndex:0];
			NSString* name = [user objectForKey:@"name"];
			self.facebookName =name;	
		}
		
		[self publishPhoto];
	}
}
- (void)askPermissionForPhotoUpload {
    FBPermissionDialog* dialog = [[[FBPermissionDialog alloc] init] autorelease];
    dialog.delegate = self;
    dialog.permission = @"photo_upload";
    [dialog show];
}
- (void)publishPhoto{
	
	UIImage *img = [UIImage imageNamed:@"DIYBg.jpg"];
	NSData *dataObj = UIImageJPEGRepresentation(self.upLoadImg, 1.0);
	
	NSArray *obj = [NSArray arrayWithObjects:@"bla bla",nil];
	NSArray *keys = [NSArray arrayWithObjects:@"message",nil];
	NSDictionary *params = [NSDictionary dictionaryWithObjects:obj forKeys:keys];
	
    NSMutableDictionary *args = [[[NSMutableDictionary alloc] init] autorelease];
    [args setObject:img forKey:@"image"];  
    FBRequest *uploadPhotoRequest = [FBRequest requestWithDelegate:self];
    [uploadPhotoRequest call:@"photos.upload" params:params dataParam:dataObj];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Your facebook image has been sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
}
#pragma mark Post to Wall Helper

- (void)postToWall {
	
	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.userMessagePrompt = @"Enter your message:";
	//dialog.attachment = fbShareURL;
	//dialog.actionLinks = @"[{\"text\":\"ลิงค์ข่าว!\",\"href\":\"http://www.thairath.com/\"}]";
	[dialog show];
	
}
- (void)session:(FBSession*)sessions didLogin:(FBUID)uid {
	NSLog(@"User with id %lld logged in.", uid);
	[self getFacebookName];
	
}
-(void)SentEmailWithImage:(UIImage*)image withTitle:(NSString*)title
{
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:title];
	NSData *imageData = UIImageJPEGRepresentation(image, 1);
	[controller addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"none.jpg"];
	[controller setMessageBody:@"GiftDIY" isHTML:YES]; 
	[(UIViewController*)iCallback  presentModalViewController:controller animated:YES];
	[controller release];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		NSLog(@"It's away!");
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Your email has been sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	[(UIViewController*)iCallback dismissModalViewControllerAnimated:YES];
}
- (id)delegate
{
	return iCallback;
}
- (void)setDelegate:(id)new_delegate
{
	iCallback = new_delegate;
}
@end
