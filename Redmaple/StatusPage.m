//
//  StatusPage.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 6/5/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "PageViewController.h"
#import "StatusPage.h"
#import "DeliveryVO.h"

@interface StatusPage ()

@end

@implementation StatusPage
@synthesize sentLogArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    statusPage = self;
    self.tableView.allowsSelection = NO;
    self.tableView.sectionHeaderHeight = 55;
    sentLogArray = [[NSMutableArray alloc] init];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(100, 5, 30, 30);
    spinner.hidden = YES;
    [self.navigationController.navigationBar addSubview:spinner];
    [self performSelector:@selector(OnRefresh:) withObject:nil afterDelay:0.2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSpinner:(BOOL)bShow
{
    spinner.hidden = !bShow;
    if( bShow )
        [spinner startAnimating];
    else
        [spinner stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sentLogArray count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = @"";
    int cnt = (int)[sentLogArray count];
    if( cnt == 0 )
        str = [NSString stringWithFormat:@"Sent Log:"];
    if( cnt == 1 )
        str = [NSString stringWithFormat:@"Sent Log:  %d record", cnt];
    if( cnt > 1 )
        str = [NSString stringWithFormat:@"Sent Log:  %d records", cnt];
    return str;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSInteger fontSize = nDeviceType == DEVICE_IPHONE ? 15 : 18;
    cell.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:fontSize];

    if( nWebService == WEB_SERVICE_MOBILE )
    {
        FAXCOM_x0020_Service_MessageStatus *sts = [sentLogArray objectAtIndex:indexPath.row];
        NSString *sdt = [viewerPage GetTimeStringFrom:sts.TransmitTime forFileName:NO];
        NSString *msg = [NSString stringWithFormat:@"%@ to %@", sdt, sts.RecipientName];
        cell.textLabel.text = msg;
        cell.detailTextLabel.text = sts.StatusName;
    }
    else if( nWebService == WEB_SERVICE_ANYWHER )
    {
        FAWebServiceMain_MessageStatus *sts = [sentLogArray objectAtIndex:indexPath.row];
        NSString *sdt = [viewerPage GetTimeStringFrom:sts.TransmitTime forFileName:NO];
        NSString *msg = [NSString stringWithFormat:@"%@ to %@", sdt, sts.RecipientName];
        cell.textLabel.text = msg;
        cell.detailTextLabel.text = sts.StatusName;
    }
    else if( nWebService == WEB_SERVICE_SFT )
    {
        DeliveryVO *delV = [sentLogArray objectAtIndex:indexPath.row];
        NSString *status = [delV getStatus];
        if( [status isEqualToString:@"V"] )
        {
            NSString *to = [delV getToAddressList];
            if( [to isEqualToString:@""] )
                to = @"(Fax recipient)";
            NSArray *chunks = [[delV getParsedDateLastUpdated] componentsSeparatedByString: @" "];
            NSString *tmStr = [NSString stringWithFormat:@"%@ %@%@", [chunks objectAtIndex:0], [chunks objectAtIndex:1], [chunks objectAtIndex:2]];
            NSString *str = [NSString stringWithFormat:@"%@ to %@", tmStr, to];
            cell.textLabel.text = str;
            cell.detailTextLabel.text = @"";
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
}

- (IBAction)OnRefresh:(id)sender
{
    [self showSpinner:YES];
    if( [wsm setStatusLogs] )
    {
        [self.tableView reloadData];
    }
}

@end
