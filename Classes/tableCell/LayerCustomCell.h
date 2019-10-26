//
//  LayerCustomCell.h
//  GiftDIY
//
//  Created by sarun krishnalome on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface LayerCustomCell : BaseTableViewCell {
	IBOutlet UIImageView* iImagePreview;
	IBOutlet UILabel* iXLabel;
	IBOutlet UILabel* iYLabel;
	IBOutlet UILabel* iWidthLabel;
	IBOutlet UILabel* iHeightLabel;
	IBOutlet UIImageView* iScaleImage;
	IBOutlet UIImageView* iPinImage;
	IBOutlet UIImageView* iVisibleImage;
	
}
@property (nonatomic,retain) IBOutlet UIImageView* iImagePreview;
@property (nonatomic,retain) IBOutlet UIImageView* iScaleImage;
@property (nonatomic,retain) IBOutlet UIImageView* iPinImage;
@property (nonatomic,retain) IBOutlet UIImageView* iVisibleImage;
@property (nonatomic,retain) IBOutlet UILabel* iXLabel;
@property (nonatomic,retain) IBOutlet UILabel* iYLabel;
@property (nonatomic,retain) IBOutlet UILabel* iWidthLabel;
@property (nonatomic,retain) IBOutlet UILabel* iHeightLabel;
@end
