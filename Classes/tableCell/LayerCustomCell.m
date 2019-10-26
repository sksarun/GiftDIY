//
//  LayerCustomCell.m
//  GiftDIY
//
//  Created by sarun krishnalome on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LayerCustomCell.h"


@implementation LayerCustomCell
@synthesize iImagePreview,iXLabel,iYLabel,iWidthLabel,iHeightLabel,iScaleImage,iPinImage,iVisibleImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}




- (void)dealloc {
	[iImagePreview release];
	[iXLabel release];
	[iYLabel release];
	[iWidthLabel release];
	[iHeightLabel release];
	[iScaleImage release];
	[iPinImage release];
	[iVisibleImage release];
    [super dealloc];
}


@end
