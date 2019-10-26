//
//  GiftDIYViewController.h
//  GiftDIY
//
//  Created by Tong on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiftDIYViewController : UIViewController  <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate> {

	NSInteger selectIndex;
	BOOL IsDelSelect;
	BOOL IsFixrotSelect;
	
	UIImage *newImage;
	
	IBOutlet UIToolbar* iToolbar;
	IBOutlet UIImageView* bgImage;
	CGPoint lastLoc;
	
	CGPoint lastLoc1;
	CGPoint lastLoc2;
}
@property (nonatomic,retain)IBOutlet UIToolbar* iToolbar;
@property (nonatomic,retain)IBOutlet UIImageView* bgImage;
-(void) imagepick;
-(void) iconpick;
-(void) framepick;
-(IBAction) Orderingpage:(id)sender;
-(void)popupActionSheet ;
-(IBAction)popupImageActionSheet ;
-(IBAction)popupOtherActionSheet ;
-(IBAction)propertyView ;
-(void)aboutView;
-(void)helpview;
//-(void)effectView;
-(IBAction)hideTab;

-(void) SharetoFB;
-(void) SharetoEmail;
-(void) SaveImageToGallery;
-(CGFloat) distanceBetween: (CGPoint) point1 withPoint:(CGPoint)point2;

-(void) AddFrameObject:(UIImage*)image;
-(void) ClearAllSelection;
-(void)AddTextFrameObject:(NSString*)text;
-(void) AddGiftDIYTextObject:(NSString*)text;
-(void) AddText:(NSInteger)type;
-(void) CreateDIYObject:(UIImage*)image withType:(NSInteger)type;

-(void) ReAllocNewObject;



CGAffineTransform CGAffineTransformWithTouches(CGAffineTransform oldTransform, 
											   UITouch *firstTouch, 
											   UITouch *secondTouch,NSInteger index);
@end

