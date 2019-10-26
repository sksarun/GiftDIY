//
//  ObjPropertyView.h
//  GiftDIY
//
//  Created by Tong on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


@interface ObjPropertyView : UIViewController 
{
	IBOutlet UIImageView* imageSample;
	IBOutlet UISegmentedControl* iFilterSegment;
	IBOutlet UITextField* iTextfield;
	IBOutlet UITextField* iXTextfield;
	IBOutlet UITextField* iYTextfield;
	IBOutlet UITextField* iWidthTextfield;
	IBOutlet UITextField* iHeightTextfield;
	IBOutlet UITextField* iFontsizeTextfield;
	IBOutlet UIImageView* bgImage;
	
	IBOutlet UITableView* iTable;
	IBOutlet UITableViewCell* iAvaCell;
	IBOutlet BaseTableViewCell* iTextCell;
	IBOutlet BaseTableViewCell* iXCell;
	IBOutlet BaseTableViewCell* iYCell;
	IBOutlet BaseTableViewCell* iWidthCell;
	IBOutlet BaseTableViewCell* iHeightCell;
	IBOutlet BaseTableViewCell* iScaleCell;
	IBOutlet BaseTableViewCell* iBgCell;
	IBOutlet BaseTableViewCell* iFontSizeCell;
	IBOutlet BaseTableViewCell* iFontFamilyCell;
	IBOutlet BaseTableViewCell* iColorCell;
	IBOutlet BaseTableViewCell* iPinnedCell;
	IBOutlet BaseTableViewCell* iVisibleCell;
	IBOutlet BaseTableViewCell* iShadowCell;
	IBOutlet BaseTableViewCell* iOpacityCell;
	IBOutlet BaseTableViewCell* iFilterCell;
	IBOutlet BaseTableViewCell* iDoneCell;
	
	
	IBOutlet UISwitch* iScaleSwitch;
	IBOutlet UISwitch* iBgSwitch;
	IBOutlet UISwitch* iPinnedSwitch;
	IBOutlet UISwitch* iVisibleSwitch;
	IBOutlet UISwitch* iShadowSwitch;
	IBOutlet UISlider* iOpacitySlider;
	
	IBOutlet UITabBarController* iColorTabbar;
	
	IBOutlet UILabel* iFontFamilylabel;
	IBOutlet UILabel* iOpacityLabel;
	
	IBOutlet UIView* iColorIndicateView;
	
	NSInteger iSelectIndex;
	
	NSInteger iBaseWidth;
	NSInteger iBaseHeight;
}


@property (nonatomic,retain) IBOutlet UIImageView* imageSample;
@property (nonatomic,retain) IBOutlet UIImageView* bgImage;
@property (nonatomic,retain) IBOutlet UITextField* iTextfield;
@property (nonatomic,retain) IBOutlet UITextField* iXTextfield;
@property (nonatomic,retain) IBOutlet UITextField* iYTextfield;
@property (nonatomic,retain) IBOutlet UITextField* iWidthTextfield;
@property (nonatomic,retain) IBOutlet UITextField* iHeightTextfield;
@property (nonatomic,retain) IBOutlet UITextField* iFontsizeTextfield;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iTextCell;
@property (nonatomic,retain) IBOutlet UITableViewCell* iAvaCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iXCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iYCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iWidthCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iHeightCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iScaleCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iBgCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iDoneCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iFontSizeCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iFontFamilyCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iColorCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iPinnedCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iVisibleCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iShadowCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iFilterCell;
@property (nonatomic,retain) IBOutlet BaseTableViewCell* iOpacityCell;
@property (nonatomic,retain) IBOutlet UIView* iColorIndicateView;
@property (nonatomic,retain) IBOutlet UITableView* iTable;
@property (nonatomic,retain) IBOutlet UISwitch* iScaleSwitch;
@property (nonatomic,retain) IBOutlet UISwitch* iBgSwitch;
@property (nonatomic,retain) IBOutlet UISwitch* iPinnedSwitch;
@property (nonatomic,retain) IBOutlet UISwitch* iVisibleSwitch;
@property (nonatomic,retain) IBOutlet UISwitch* iShadowSwitch;
@property (nonatomic,retain) IBOutlet UISlider* iOpacitySlider;
@property (nonatomic,retain) IBOutlet UISegmentedControl* iFilterSegment;
@property (nonatomic,retain) IBOutlet UILabel* iFontFamilylabel;
@property (nonatomic,retain) IBOutlet UILabel* iOpacityLabel;
@property (nonatomic,retain) IBOutlet UITabBarController* iColorTabbar; 
@property NSInteger iSelectIndex;

-(IBAction) opacityChange:(id)sender;
-(IBAction) DoneButton:(id)sender;
-(IBAction) CancelButton:(id)sender;
-(IBAction)setViewMovedUp:(id)sender;
-(IBAction)setViewBackUp:(id)sender;

-(void) UpdateValue;
-(BOOL) IsAcceptValue;
-(void) rotateBg:(UIInterfaceOrientation) orientation;


@end
