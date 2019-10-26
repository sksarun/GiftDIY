//
//  DIYObject.m
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DIYObject.h"


@implementation DIYObject
@synthesize IsSupportShadow,filterType,IsShadow,originalImage,DIYtext,IsWhiteBg,fixRotateValue,fixrotateImage,textlab,bgType,ImagecontainView,mainAngle,RotateSel,rotateImage,IsPinned,IsSelect,ResizeSel,delImage,resizeImage,containView,type,image,ObjRect;

-(id) init
{
	self = [super init];
	if(self)
	{
		IsSupportShadow = NO;
	}
	return self;
	
}


-(void) dealloc
{
	[self.originalImage release];
	[self.DIYtext release];
	[self.textlab release];
	[self.delImage release];
	[self.resizeImage release];
	[self.rotateImage release];
	[self.fixrotateImage release];
	[self.image release];
	[self.containView release];
	[self.ImagecontainView release];
	[super dealloc];
}
@end
