//
//  AddVASCustomCell.m
//  Dtac-Service
//
//  Created by sarun krishnalome on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddVASCustomCell.h"


@implementation AddVASCustomCell
@synthesize iAddVASImgView,iAddVASTxtView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}
/*
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{
		
	}
	return self;
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
	[iAddVASTxtView release];
}


@end
