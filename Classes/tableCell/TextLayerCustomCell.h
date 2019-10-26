//
//  TextLayerCustomCell.h
//  GiftDIY
//
//  Created by sarun krishnalome on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface TextLayerCustomCell : BaseTableViewCell {
	IBOutlet UIImageView* iTextImg;
	IBOutlet UIImageView* iVisibleImg;
	IBOutlet UIImageView* iPinImg;
	IBOutlet UILabel* iTxtLabel;
	IBOutlet UILabel* iXLabel;
	IBOutlet UILabel* iYLabel;
	IBOutlet UILabel* iFontLabel;
}
@property (nonatomic,retain) IBOutlet UIImageView* iTextImg;
@property (nonatomic,retain) IBOutlet UIImageView* iVisibleImg;
@property (nonatomic,retain) IBOutlet UIImageView* iPinImg;
@property (nonatomic,retain) IBOutlet UILabel* iTxtLabel;
@property (nonatomic,retain) IBOutlet UILabel* iXLabel;
@property (nonatomic,retain) IBOutlet UILabel* iYLabel;
@property (nonatomic,retain) IBOutlet UILabel* iFontLabel;
@end
