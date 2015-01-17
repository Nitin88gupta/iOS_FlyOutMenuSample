//
//  NGMenuTableViewCell.h
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/15/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGMenuTableViewCell : UITableViewCell {

}
@property (nonatomic, assign) BOOL animatingCell;
@property (nonatomic, strong) UIColor *menuCellBackgroundColorNormal;
@property (nonatomic, strong) UIColor *menuCellBackgroundColorHighlighted;

@end
