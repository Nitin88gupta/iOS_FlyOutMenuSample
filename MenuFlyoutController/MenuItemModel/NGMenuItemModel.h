//
//  NGMenuItemModel.h
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGMenuItemModel : NSObject

-(id)initWithTitle:(NSString*)title iconName:(NSString*)iconName;

@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *iconName;

@end
