//
//  NGMenuItemModel.m
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import "NGMenuItemModel.h"

@implementation NGMenuItemModel

-(id)initWithTitle:(NSString*)title iconName:(NSString*)iconName {
    self = [super init];
    if(self) {
        _title = title;
        _iconName = iconName;
    }
    return self;
}

@end
