//
//  LeftViewController.m
//  AppWEAR
//
//  Created by HKM on 27/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "LeftViewController.h"
#import "RESideMenu.h"
#import "TabBarController.h"
#import <MessageUI/MessageUI.h>

static NSString *const kImageName     =   @"imageName";
static NSString *const kContentName   =   @"contentName";

@interface LeftViewController () <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
{
    NSMutableArray *tableContent;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewContent;

@end

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableViewContent setDelegate:self];
    [_tableViewContent setDataSource:self];
    _tableViewContent.tableFooterView = [UIView new];
    [self prepareDataSource];
    [_tableViewContent reloadData];
}

-(void)prepareDataSource
{
    tableContent = [NSMutableArray arrayWithObjects:@{kImageName : @"home_menu", kContentName : @"Home"}, @{kImageName : @"explore_menu", kContentName : @"Explore"}, @{kImageName : @"warning_menu", kContentName : @"Warning"}, @{kImageName : @"trail_menu", kContentName : @"Trail"}, @{kImageName : @"shop_menu", kContentName : @"Shop"}, @{kImageName : @"profile_menu", kContentName : @"Profile"}, @{kImageName : @"feedback_menu", kContentName : @"Feedback"}, @{kImageName : @"invite_friend_menu", kContentName : @"Invite friend"}, @{kImageName : @"rate_app_menu", kContentName : @"Rate the app"}, nil];
}

#pragma -mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableContent.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabBarController *tabBarController = (TabBarController *)self.sideMenuViewController.contentViewController;
    switch (indexPath.row) {
        case 0:
            tabBarController.selectedIndex = 2;
            break;
        case 1:
            tabBarController.selectedIndex = 0;
            break;
        case 2:
            tabBarController.selectedIndex = 4;
            break;
        case 3:
            tabBarController.selectedIndex = 3;
            break;
        case 4:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appwear.intello3.com"]];
            break;
        case 5:
            tabBarController.selectedIndex = 1;
            break;
        case 6:
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *composeController = [[MFMailComposeViewController alloc] init];
                [composeController setMailComposeDelegate:self];
                [composeController setToRecipients:@[@"feedback@appwear.com"]];
                NSString *subject = [NSString stringWithFormat:@"Feedback from %@", [[LoggedInUser loggedInUser] fullName]];
                [composeController setSubject:subject];
                [self presentViewController:composeController animated:YES completion:nil];
            }
            
            break;
        case 7:
            
            break;
        case 8:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunesconnect.apple.com"]];
            break;
            
        default:
            break;
            
    }
    
    [self.sideMenuViewController hideMenuViewController];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *content = [tableContent objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [cell viewWithTag:100];
    [imageView setImage:[UIImage imageNamed:[content valueForKey:kImageName]]];
    UILabel *label = [cell viewWithTag:200];
    [label setText:[content valueForKey:kContentName]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

#pragma -mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
