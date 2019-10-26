//
//  HelpDetailViewController.h
//  GiftDIY
//
//  Created by sarun krishnalome on 12/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpDetailViewController : UIViewController {

	IBOutlet UITableView* iTable;
	IBOutlet UITableViewCell* iDescCell;
	IBOutlet UITableViewCell* iDIYCell;
	IBOutlet UITableViewCell* iLayerCell;
	IBOutlet UITableViewCell* iPropertyCell;
	NSInteger iSelectIndex;
}

@property (nonatomic,retain) IBOutlet UITableView* iTable;
@property (nonatomic,retain) IBOutlet UITableViewCell* iDescCell;
@property (nonatomic,retain) IBOutlet UITableViewCell* iDIYCell;
@property (nonatomic,retain) IBOutlet UITableViewCell* iLayerCell;
@property (nonatomic,retain) IBOutlet UITableViewCell* iPropertyCell;
@property NSInteger iSelectIndex;
@end
