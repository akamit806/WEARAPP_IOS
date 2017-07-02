//
//  TrailActivityViewController.m
//  AppWEAR
//
//  Created by HKM on 05/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TrailActivityViewController.h"
#import "TextFieldRightView.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "LoggedInUser.h"
#import "SVProgressHUD.h"
#import "TrailActivityTableViewCell.h"

@interface TrailActivityViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, TrailActivityTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewTrails;
@property (weak, nonatomic) IBOutlet TextFieldRightView *textFieldTrails;
@property (strong, nonatomic) NSMutableArray *searchedTrails;
@property (strong, nonatomic) NSMutableArray *allTrails;
@property (weak, nonatomic) IBOutlet UILabel *labelNoData;

@end

@implementation TrailActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_textFieldTrails setDelegate:self];
    [_textFieldTrails setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
    [_tableViewTrails setDelegate:self];
    [_tableViewTrails setDataSource:self];
    _tableViewTrails.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:_textFieldTrails];

}

-(void)textFieldTextChanged:(NSNotification *)notification
{
    if (_textFieldTrails.text.length == 0)
    {
        self.searchedTrails = [self.allTrails mutableCopy];
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@", kTrial_Name, _textFieldTrails.text];
        self.searchedTrails = [[self.allTrails filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    
    [_tableViewTrails reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self searchTrails];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_textFieldTrails];
}

-(void)searchTrails
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kUser_Id : loggedInUser.userId};
        [SVProgressHUD showWithStatus:@"Searching..."];
        [[WebApiHandler sharedHandler] searchUserTrailWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                id dataObject = [response objectForKey:kData];
                if(dataObject != [NSNull null])
                {
                    weakSelf.searchedTrails = [[response objectForKey:kData] copy];
                    weakSelf.allTrails = [weakSelf.searchedTrails mutableCopy];
                    if (weakSelf.searchedTrails.count > 0)
                    {
                        [_labelNoData setHidden:YES];
                        [weakSelf.tableViewTrails setHidden:NO];
                        [weakSelf.tableViewTrails reloadData];
                    }
                    else
                    {
                        [_labelNoData setHidden:NO];
                        [weakSelf.tableViewTrails setHidden:YES];
                    }
                }
                else
                {
                    [_labelNoData setHidden:NO];
                    [weakSelf.tableViewTrails setHidden:YES];
                }
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)deleteTrail:(NSDictionary *)trail
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kTrial_Id : [trail valueForKey:kTrial_Id]};
        [SVProgressHUD showWithStatus:@"Deleting..."];
        [[WebApiHandler sharedHandler] deleteTrailWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                id dataObject = [response objectForKey:kData];
                if(dataObject != [NSNull null])
                {
                    
                }
                else
                {
                    
                }
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)trailActivityTableViewCell: (TrailActivityTableViewCell *)cell didClickedDeleteButton:(UIButton *)button
{
    NSIndexPath *indexPath = [_tableViewTrails indexPathForCell:cell];
    NSDictionary *trail = [_allTrails objectAtIndex:indexPath.row];
    [self deleteTrail:trail];
}


#pragma mark UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchedTrails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrailActivityTableViewCell *cell = [_tableViewTrails dequeueReusableCellWithIdentifier:NSStringFromClass([TrailActivityTableViewCell class]) forIndexPath:indexPath];
    [cell setDelegate:self];
    NSDictionary *trail = [_searchedTrails objectAtIndex:indexPath.row];
    [cell setTrail:trail];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma -mark UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) // Backspace
    {
        
    }
    else // Forward
    {
        
    }
    return true;
}

@end
