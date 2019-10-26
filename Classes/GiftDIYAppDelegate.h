//
//  GiftDIYAppDelegate.h
//  GiftDIY
//
//  Created by Tong on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftDIYViewController;

@interface GiftDIYAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GiftDIYViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GiftDIYViewController *viewController;

@end

