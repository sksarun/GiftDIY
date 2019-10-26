//
//  CustomColorChooserViewController.h
//  GiftDIY
//
//  Created by Tong on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomColorChooserViewController : UIViewController {

	IBOutlet UISlider* iRedSlider;
	IBOutlet UISlider* iGreenSlider;
	IBOutlet UISlider* iBlueSlider;
	
	IBOutlet UILabel* iRedLab;
	IBOutlet UILabel* iGreenLab;
	IBOutlet UILabel* iBlueLab;
	
	IBOutlet UIView* iResultView;
}

@property (nonatomic,retain) IBOutlet UISlider* iRedSlider;
@property (nonatomic,retain) IBOutlet UISlider* iGreenSlider;
@property (nonatomic,retain) IBOutlet UISlider* iBlueSlider;
@property (nonatomic,retain) IBOutlet UILabel* iRedLab;
@property (nonatomic,retain) IBOutlet UILabel* iGreenLab;
@property (nonatomic,retain) IBOutlet UILabel* iBlueLab;
@property (nonatomic,retain) IBOutlet UIView* iResultView;

-(IBAction) updateValue:(id)sender;
-(IBAction) saveColor:(id)sender;

@end
