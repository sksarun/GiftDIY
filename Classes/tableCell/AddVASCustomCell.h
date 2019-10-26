//
//  AddVASCustomCell.h
//  Dtac-Service
//
//  Created by sarun krishnalome on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddVASCustomCell : UITableViewCell {
	IBOutlet UITextView* iAddVASTxtView;
	IBOutlet UIImageView* iAddVASImgView;
}
@property (nonatomic,retain)IBOutlet UITextView* iAddVASTxtView;
@property (nonatomic,retain)IBOutlet UIImageView* iAddVASImgView;
@end
