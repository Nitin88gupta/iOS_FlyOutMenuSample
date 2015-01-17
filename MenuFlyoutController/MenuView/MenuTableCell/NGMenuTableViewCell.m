//
//  NGMenuTableViewCell.m
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/15/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import "NGMenuTableViewCell.h"

@implementation NGMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!selected) {
        self.backgroundColor = _menuCellBackgroundColorHighlighted ? _menuCellBackgroundColorHighlighted : [UIColor clearColor];
    } else {
        self.backgroundColor = _menuCellBackgroundColorNormal ? _menuCellBackgroundColorNormal : [UIColor clearColor];
    }
    // Configure the view for the selected state
}

@end
