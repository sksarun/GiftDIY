//
//  MainData.h
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBSession.h"
#import "FBLoginDialog.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MainData : NSObject <MFMailComposeViewControllerDelegate,FBRequestDelegate,FBSessionDelegate, FBDialogDelegate>{

	NSMutableArray* iDataObjectList;
	FBSession* session;
	NSString* facebookName;
	UIImage* upLoadImg;
	NSInteger iSelectIndex;
	id iCallback;
	NSDictionary* imageData;
}

@property (nonatomic,retain) NSMutableArray* iDataObjectList;
@property (nonatomic,copy) NSString* facebookName;
@property (nonatomic,retain) UIImage* upLoadImg;
@property (nonatomic,retain) NSDictionary* imageData;
@property  NSInteger iSelectIndex;
+ (MainData *) sharedMainData;
-(void)PostFB:(id)sender;
- (void)postToWall ;
- (void)getFacebookName;
- (void)askPermissionForPhotoUpload;
- (void)publishPhoto;

-(void)SentEmailWithImage:(UIImage*)image withTitle:(NSString*)title;
- (id)delegate;
- (void)setDelegate:(id)new_delegate;
@end
