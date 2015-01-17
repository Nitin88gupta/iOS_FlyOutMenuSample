//
//  NGMenuView.m
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import "NGMenuView.h"
#import "NGMenuConstant.h"
#import "NGMenuItemModel.h"
#import "NGMenuTableViewCell.h"

@implementation NGMenuView

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)itemsList{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpMenuItemModel:itemsList];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Menu_DeviceStatusBarHeight, self.bounds.size.width, self.bounds.size.height-Menu_DeviceStatusBarHeight) style:UITableViewStylePlain];
        [self addSubview:_menuTableView];
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.separatorColor = [UIColor clearColor];
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.bounces = YES;
        _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _menuTableView.rowHeight = 40;
    }
    return self;
}

-(void)didMoveToSuperview {
    if(!self.superview) {
        return;
    } else {
        [_menuTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.08];
    }

}

#pragma mark - View Life Cycle
- (void)setUpMenuItemModel:(NSArray *)itemsList {
    _menuItemsArray = [[NSMutableArray alloc] initWithCapacity:[itemsList count]];
    for (NSDictionary *dict in itemsList) {
        NGMenuItemModel *entity = [[NGMenuItemModel alloc] initWithTitle:[dict objectForKey:Menu_TitleKey] iconName:[dict objectForKey:Menu_IconKey]];
        [_menuItemsArray addObject:entity];
    }
}

- (void)setSelectedMenuItem:(NSInteger)index {
    [_menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItemsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(menuSelectedIndex:)]) {
        [_delegate menuSelectedIndex:indexPath.row];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"MenuItem";
    NGMenuTableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[NGMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.menuCellBackgroundColorNormal = _menuItemBackgroundColorNormal;
        cell.menuCellBackgroundColorNormal = _menuItemBackgroundColorHighlighted;
        
        cell.textLabel.textColor = _menuItemTitleTextColorNormal? _menuItemTitleTextColorNormal:[UIColor whiteColor];
        cell.textLabel.highlightedTextColor = _menuItemTitleTextColorHighlighted? _menuItemTitleTextColorHighlighted:[UIColor redColor];

        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NGMenuItemModel *entity = [_menuItemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = entity.title;    
    if(entity.iconName && ![entity.iconName isEqualToString:@""]) {
        cell.imageView.image = [UIImage imageNamed:entity.iconName];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath = %@, Row = %d",indexPath,indexPath.row);
    if (!_rippleAnimationEnabled || [(NGMenuTableViewCell *)cell animatingCell]) {
        return;
    }
    
    [(NGMenuTableViewCell *)cell setAnimatingCell:YES];

    cell.alpha = 1.0;
    CATransform3D scale = CATransform3DMakeTranslation(tableView.bounds.size.width, 0, 0);
    cell.layer.transform = CATransform3DConcat(scale, CATransform3DMakeScale(0.1, 0.1, 0.1));
    
    [UIView animateWithDuration:0.18 delay:indexPath.row*0.06 options:UIViewAnimationOptionCurveEaseOut animations:^{
        cell.alpha = 1.0;
        cell.layer.transform = CATransform3DConcat(CATransform3DMakeTranslation(-7, 0, 0), CATransform3DMakeScale(1.3, 1.3, 1.3));
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.13 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.layer.transform = CATransform3DConcat(CATransform3DMakeTranslation(5, 0, 0), CATransform3DMakeScale(0.9, 0.9, 0.9)) ;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.09 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                cell.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished){
                [(NGMenuTableViewCell *)cell setAnimatingCell:NO];
            }];
        }];
    }];
}

@end
