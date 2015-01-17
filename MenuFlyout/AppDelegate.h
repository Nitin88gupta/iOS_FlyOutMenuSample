//
//  AppDelegate.h
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NGMenuFlyOutViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) NGMenuFlyOutViewController *menuController;
@property (strong, nonatomic) UIWindow *window;


- (void)showMenuView;

@end

