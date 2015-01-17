//
//  NGMenuView.h
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate;

@interface NGMenuView : UIView <UITableViewDataSource,UITableViewDelegate>{
    UITableView *_menuTableView;
    NSMutableArray *_menuItemsArray;
}

@property (nonatomic, strong) UIColor *menuItemTitleTextColorNormal;
@property (nonatomic, strong) UIColor *menuItemTitleTextColorHighlighted;
@property (nonatomic, strong) UIColor *menuItemBackgroundColorNormal;
@property (nonatomic, strong) UIColor *menuItemBackgroundColorHighlighted;
@property (nonatomic, assign) BOOL rippleAnimationEnabled;
@property (nonatomic, strong) id <MenuViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)itemsList;
- (void)setSelectedMenuItem:(NSInteger)index;
@end

@protocol MenuViewDelegate <NSObject>
@required
- (void)menuSelectedIndex:(NSUInteger)index;

@end