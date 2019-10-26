//
//  HelpViewController.h
//  GiftDIY
//
//  Created by Tong on 12/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpViewController : UIViewController {

	IBOutlet UITableView* iTable;
	NSMutableArray *listOfItems;
	NSInteger iSelectIndex;
}

@property (nonatomic,retain) IBOutlet UITableView* iTable;
@property (nonatomic,retain) NSMutableArray *listOfItems;
-(IBAction) closeHelpView;
@end
