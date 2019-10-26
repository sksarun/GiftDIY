//
//  FontListViewController.h
//  GiftDIY
//
//  Created by Tong on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontListViewController : UIViewController {

	IBOutlet UITableView* iTable;
	NSInteger iSelectIndex;
	NSArray* familyNames;
}

@property (nonatomic,retain) IBOutlet UITableView* iTable;
@property NSInteger iSelectIndex;
@end
