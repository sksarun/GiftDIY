//
//  ObjectLayerView.h
//  GiftDIY
//
//  Created by Tong on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ObjectLayerView : UIViewController {

	IBOutlet UITableView* iTable;
	IBOutlet UINavigationItem* iNavItem;
	id delegate;
}
@property(nonatomic,retain) IBOutlet UITableView* iTable;
@property(nonatomic,retain) IBOutlet UINavigationItem* iNavItem;
@property (assign) id delegate;
-(IBAction) saveOrder:(id)sender;
-(IBAction) switchEditingState:(id)sender;
-(IBAction) clearAllItem:(id)sender;
@end
