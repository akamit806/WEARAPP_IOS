//
//  WarningViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "WarningViewController.h"
#import "WarningTableViewCell.h"

@interface WarningViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewWarning;

@end

@implementation WarningViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"WARNING";
    [self addLeftSideMenuButton];
    [_tableViewWarning setDelegate:self];
    [_tableViewWarning setDataSource:self];
    [_tableViewWarning reloadData];
}

#pragma -mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WarningTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"WarningDetailViewControllerSegue" sender:nil];
}

@end
