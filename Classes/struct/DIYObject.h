//
//  DIYObject.h
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
	EImage = 0,
	EText
}ObjType;

typedef enum  {
	ENone = 0,
	EGray,
	ESepia
}FilterType;

@interface DIYObject : NSObject {

	UIView* containView;
	UIView* ImagecontainView;
	//image without any effect;
	UIImage* originalImage;
	//imageview display
	UIImageView* image;
	UIImageView* delImage;
	UIImageView* resizeImage;
	UIImageView* rotateImage;
	UIImageView* fixrotateImage;
	UILabel* textlab;
	NSString* DIYtext;
	CGRect ObjRect;
	ObjType type;
	FilterType filterType;
	
	BOOL ResizeSel;
	BOOL RotateSel;
	BOOL IsSelect;
	BOOL IsWhiteBg;
	BOOL IsPinned;
	BOOL IsShadow;
	BOOL IsSupportShadow;
	NSInteger bgType;
	NSInteger fixRotateValue;
	double mainAngle;
}
@property CGRect ObjRect;
@property ObjType type;
@property FilterType filterType;
@property BOOL ResizeSel;
@property BOOL IsSelect;
@property BOOL RotateSel;
@property BOOL IsPinned;
@property BOOL IsWhiteBg;
@property BOOL IsShadow;
@property BOOL IsSupportShadow;
@property double mainAngle;
@property NSInteger bgType;
@property NSInteger fixRotateValue;
@property (nonatomic,copy) NSString* DIYtext;
@property (nonatomic,retain) UIImage* originalImage;
@property (nonatomic,retain) UIImageView* fixrotateImage;
@property (nonatomic,retain) UIImageView* resizeImage;
@property (nonatomic,retain) UIImageView* delImage;
@property (nonatomic,retain) UIImageView* image;
@property (nonatomic,retain) UIImageView* rotateImage;
@property (nonatomic,retain) UIView* containView;
@property (nonatomic,retain) UIView* ImagecontainView;
@property (nonatomic,retain) UILabel* textlab;


@end
