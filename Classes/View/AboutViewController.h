//
//  AboutViewController.h
//  GiftDIY
//
//  Created by Tong on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {

	IBOutlet UINavigationItem* iNavItem;
}

@property (nonatomic,retain) IBOutlet UINavigationItem* iNavItem;
-(IBAction) closeAboutView;
@end
