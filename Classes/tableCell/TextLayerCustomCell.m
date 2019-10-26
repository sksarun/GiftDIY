//
//  TextLayerCustomCell.m
//  GiftDIY
//
//  Created by sarun krishnalome on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextLayerCustomCell.h"


@implementation TextLayerCustomCell
@synthesize iTextImg,iVisibleImg,iPinImg,iTxtLabel,iXLabel,iYLabel,iFontLabel;

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


- (void)dealloc
{
	[iTextImg release];
	[iVisibleImg release];
	[iPinImg release];
	[iTxtLabel release];
	[iXLabel release];
	[iYLabel release];
	[iFontLabel release];
    [super dealloc];
}


@end
