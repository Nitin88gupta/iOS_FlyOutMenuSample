//
//  NGSixthViewController.m
//  MenuFlyout
//
//  Created by Nitin Gupta on 1/13/15.
//  Copyright (c) 2015 NitinGupta. All rights reserved.
//

#import "NGSixthViewController.h"
#import "AppDelegate.h"

@interface NGSixthViewController ()

@end

@implementation NGSixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Item
- (void)addNavigationLeftItem {
    UIButton *navLeftButn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [navLeftButn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navLeftButn setTitle:@"Menu" forState:UIControlStateNormal];
    [navLeftButn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navLeftButn];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
}

- (void)menuAction:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    [(AppDelegate *)[UIApplication sharedApplication].delegate showMenuView];
}

@end
