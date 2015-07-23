//
//  SettingsNavigationController.m
//  Blockchain
//
//  Created by Kevin Wu on 7/13/15.
//  Copyright (c) 2015 Qkos Services Ltd. All rights reserved.
//

#import "SettingsNavigationController.h"
#import "SettingsTableViewController.h"
#import "AppDelegate.h"

@interface SettingsNavigationController ()
@property (nonatomic) UIButton *backButton;
@end

@implementation SettingsNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, app.window.frame.size.width, app.window.frame.size.height);
    
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DEFAULT_HEADER_HEIGHT)];
    topBar.backgroundColor = COLOR_BLOCKCHAIN_BLUE;
    [self.view addSubview:topBar];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 17.5, self.view.frame.size.width - 160, 40)];
    headerLabel.font = [UIFont systemFontOfSize:22.0];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.adjustsFontSizeToFitWidth = YES;
    headerLabel.text = @"Settings";
    [topBar addSubview:headerLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 12, 85, 51);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [backButton setImage:[UIImage imageNamed:@"back_chevron_icon"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithWhite:0.56 alpha:1.0] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:backButton];
    self.backButton = backButton;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if (self.viewControllers.count == 1) {
        self.backButton.frame = CGRectMake(self.view.frame.size.width-50-12, 15, 50, 51);
        self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.backButton setTitle:BC_STRING_CLOSE forState:UIControlStateNormal];
        [self.backButton setImage:nil forState:UIControlStateNormal];
    } else {
        self.backButton.frame = CGRectMake(0, 12, 50, 51);
        self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.backButton setTitle:@"" forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"back_chevron_icon"] forState:UIControlStateNormal];
    }
}

- (void)backButtonClicked:(UIButton *)sender
{
    if ([self.visibleViewController isMemberOfClass:[SettingsTableViewController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [app.wallet getWalletAndHistory];
}

@end