//
//  NGMenuFlyOutViewController.m
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import "NGMenuFlyOutViewController.h"
#import "NGMenuView.h"
#import "NGMenuConstant.h"

@interface NGMenuFlyOutViewController ()<MenuViewDelegate> {
    NSMutableArray *_navControllerArray;
    NSMutableArray *_controllerArray;
    NGMenuView *_menuView;
    id _selectedNavigationController;

    UIView *_gestureView;
    
    UITapGestureRecognizer *_menuCloseTapGesture;
    
    NSUInteger _selectedIndex;

    BOOL _animatingMenu;
}

@end

@implementation NGMenuFlyOutViewController

- (instancetype)initWithChildController:(NSArray *)childControllers andMenuItems:(NSArray *)items {
    self = [super initWithNibName:@"NGMenuFlyOutViewController" bundle:nil];
    if (self) {
        [self setUpChildController:childControllers];
        [self setUpMenuViewWithItems:items];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDismissTapGesture];
    [self setSelectedIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setting Up View
- (void)setUpChildController:(NSArray *)childControllers {
    _controllerArray = [[NSMutableArray alloc] initWithCapacity:[childControllers count]];
    [_controllerArray addObjectsFromArray:childControllers];
    
    _navControllerArray = [[NSMutableArray alloc] initWithCapacity:[childControllers count]];
    
    for (UIViewController *cntrller in childControllers) {
        UINavigationController *_navController = [[UINavigationController alloc] initWithRootViewController:cntrller];
        [_navControllerArray addObject:_navController];
    }
}

- (void)setUpMenuViewWithItems:(NSArray *)items {
    _menuView = [[NGMenuView alloc] initWithFrame:CGRectMake(0, 0, Menu_Width, Menu_DeviceScreenHeight) andItems:items];
    [_menuView setDelegate:self];
    [_menuView setMenuItemTitleTextColorNormal:[UIColor whiteColor]];
    [_menuView setMenuItemTitleTextColorHighlighted:[UIColor blackColor]];
    [_menuView setMenuItemBackgroundColorNormal:[UIColor clearColor]];
    [_menuView setMenuItemBackgroundColorHighlighted:[UIColor blueColor]];
    [_menuView setRippleAnimationEnabled:YES];
}

#pragma mark - View Life Cycle
- (UIViewController *)selectedViewControlller {
    return [_controllerArray objectAtIndex:_selectedIndex];
}

- (UINavigationController *)selectedNavigationController {
    return _selectedNavigationController;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= _navControllerArray.count) {
        return;
    }
    if (_selectedNavigationController) {
        [_selectedNavigationController willMoveToParentViewController:nil];
        [[_selectedNavigationController view] removeFromSuperview];
        [_selectedNavigationController removeFromParentViewController];
    }
    _selectedIndex = selectedIndex;
    _selectedNavigationController = [_navControllerArray objectAtIndex:_selectedIndex];
    [self addChildViewController:[self selectedNavigationController]];
    [[_selectedNavigationController view] setFrame:[[self view] bounds]];
    [[self view] addSubview:[_selectedNavigationController view]];
    [_selectedNavigationController didMoveToParentViewController:self];
}

#pragma mark - Gesture Related
- (void)addDismissTapGesture {
    if (!_gestureView) {
        CGRect _rect = CGRectMake(0, _menuView.frame.origin.y, Menu_DeviceScreenWidth, _menuView.frame.size.height);
        _gestureView = [[UIView alloc] initWithFrame:_rect];
        [[self view] addSubview:_gestureView];
        [[self view] sendSubviewToBack:_gestureView];
        [_gestureView setBackgroundColor:[UIColor lightGrayColor]];
    }
    _menuCloseTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenuGesture:)];
}

- (void)closeMenuGesture:(UIGestureRecognizer *)recognizer {
    [self hideMenuWithCompletion:^(BOOL finished) {
        
    }];
}

#pragma mark - Show/ Hide Menu
-(void)showMenuViewWithCompletion:(void (^)(void))completion {
    if(!_animatingMenu) {
        
        [[self view] addSubview:_menuView];
        [_gestureView addGestureRecognizer:_menuCloseTapGesture];
        [[self view] bringSubviewToFront:_gestureView];
        
        _animatingMenu = YES;
        _menuView.frame = CGRectMake(-_menuView.frame.size.width, 0, _menuView.frame.size.width, self.view.bounds.size.height);
        [UIView animateWithDuration:0.2 animations:^{
            CGRect menuRect = _menuView.frame;
            menuRect.origin.x = 0;
            _menuView.frame = menuRect;
            
            CGRect _rect = CGRectMake(_menuView.frame.origin.x + _menuView.frame.size.width, _menuView.frame.origin.y, Menu_DeviceScreenWidth - _menuView.frame.size.width, _menuView.frame.size.height);
            [_gestureView setFrame:_rect];
        } completion:^(BOOL finished){
            _animatingMenu = NO;
            [_menuView setSelectedMenuItem:_selectedIndex];
            if (completion) {
                completion();
            }
        }];
    } else {
        // Nothing
    }
}

-(void)hideMenuWithCompletion:(void (^)(BOOL finished))completion {
    if(!_animatingMenu) {
        _animatingMenu = YES;
        _menuView.frame = CGRectMake(0, 0, _menuView.frame.size.width, self.view.bounds.size.height);
        [UIView animateWithDuration:0.2 animations:^{
            CGRect menuRect = _menuView.frame;
            menuRect.origin.x = -_menuView.frame.size.width;
            _menuView.frame = menuRect;
            
            CGRect _rect = CGRectMake(0, _menuView.frame.origin.y, Menu_DeviceScreenWidth, _menuView.frame.size.height);
            [_gestureView setFrame:_rect];

        } completion:^(BOOL finished){
            _animatingMenu = NO;
            [_menuView removeFromSuperview];
            if (completion) {
                completion(finished);
            }
        }];
        [_gestureView removeGestureRecognizer:_menuCloseTapGesture];
        [[self view] sendSubviewToBack:_gestureView];
    } else {
        // Nothing
    }
    
}

#pragma mark - MenuViewDelegate
- (void)menuSelectedIndex:(NSUInteger)index {
    [self hideMenuWithCompletion:^(BOOL finished) {
        [self setSelectedIndex:index];
    }];
}

@end
