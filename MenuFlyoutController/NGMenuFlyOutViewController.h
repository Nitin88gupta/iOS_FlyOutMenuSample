//
//  NGMenuFlyOutViewController.h
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGMenuConstant.h"

@interface NGMenuFlyOutViewController : UIViewController

@property (nonatomic, assign) BOOL swipeToSlideEnabled;

- (instancetype)initWithChildController:(NSArray *)childControllers andMenuItems:(NSArray *)items;

- (void)showMenuViewWithCompletion:(void (^)(void))completion;

@end
