//
//  ObjectChooserView.h
//  GiftDIY
//
//  Created by Tong on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"

typedef enum  {
	EDeco = 0,
	EZodiac,
	EAnimal,
	ECreature,
	EEmotion,
	ESpace,
	ENature,
	EGift,
	EEtc,
	EWeather,
	ESport
}IconType;
@interface ObjectChooserView : UIViewController <UIScrollViewDelegate>{

	IBOutlet MyScrollView* iScrollView;
	IBOutlet UINavigationItem* iNavBar;
	NSInteger iSelectIndex;
	NSMutableArray* iDecorationPictureList;
	NSMutableArray* iZodiacPictureList;
	NSMutableArray* iAnimalPictureList;
	NSMutableArray* iCreaturePictureList;
	NSMutableArray* iEmotionPictureList;
	NSMutableArray* iSpacePictureList;
	NSMutableArray* iNaturePictureList;
	NSMutableArray* iGiftPictureList;
	NSMutableArray* iEtcPictureList;
	NSMutableArray* iWeatherPictureList;
	NSMutableArray* iSportPictureList;
	IconType iconType;
	
	id delegate;

}
@property (nonatomic,retain) IBOutlet UIScrollView* iScrollView;
@property (nonatomic,retain) IBOutlet UINavigationItem* iNavBar;
@property (nonatomic,retain) NSMutableArray* iDecorationPictureList;
@property (nonatomic,retain) NSMutableArray* iZodiacPictureList;
@property (nonatomic,retain) NSMutableArray* iAnimalPictureList;
@property (nonatomic,retain) NSMutableArray* iCreaturePictureList;
@property (nonatomic,retain) NSMutableArray* iEmotionPictureList;
@property (nonatomic,retain) NSMutableArray* iSpacePictureList;
@property (nonatomic,retain) NSMutableArray* iNaturePictureList;
@property (nonatomic,retain) NSMutableArray* iGiftPictureList;
@property (nonatomic,retain) NSMutableArray* iEtcPictureList;
@property (nonatomic,retain) NSMutableArray* iWeatherPictureList;
@property (nonatomic,retain) NSMutableArray* iSportPictureList;
@property NSInteger iSelectIndex;
@property (assign) id delegate;

-(void) AddPhoto:(UIImage*)image atIndex:(NSInteger)index withOffset:(NSInteger)offset;
-(void) UpdateMode;
-(IBAction) NextIconType:(id)sender;
-(IBAction) CloseView;
@end
