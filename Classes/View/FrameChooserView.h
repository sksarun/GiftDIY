//
//  FrameChooserView.h
//  GiftDIY
//
//  Created by Tong on 12/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"

typedef enum  {
	EPlain = 0,
	EDIY,
	EBg,
	EArtBg
}FrameType;

@interface FrameChooserView : UIViewController<UIScrollViewDelegate> {
	IBOutlet MyScrollView* iScrollView;
	IBOutlet UINavigationItem* iNavBar;
	NSInteger iSelectIndex;
	
	NSMutableArray* iPlainFramePictureList;
	NSMutableArray* iDIYFramePictureList;
	NSMutableArray* iBgFramePictureList;
	NSMutableArray* iDIYBgPictureList;
	FrameType frameType;
	id delegate;
}
@property (nonatomic,retain) IBOutlet UIScrollView* iScrollView;
@property (nonatomic,retain) IBOutlet UINavigationItem* iNavBar;
@property (nonatomic,retain) NSMutableArray* iPlainFramePictureList;
@property (nonatomic,retain) NSMutableArray* iDIYFramePictureList;
@property (nonatomic,retain) NSMutableArray* iBgFramePictureList;
@property (nonatomic,retain) NSMutableArray* iDIYBgPictureList;
@property NSInteger iSelectIndex;
@property (assign) id delegate;

-(void) AddPhoto:(UIImage*)image atIndex:(NSInteger)index withOffset:(NSInteger)offset;
-(void) UpdateMode;
-(IBAction) NextIconType:(id)sender;
-(IBAction) CloseView;
@end
