//
//  SettingPage.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/19/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "SettingPage.h"
#import "PageViewController.h"

@interface SettingPage ()

@end

@implementation SettingPage


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    settingsPage = self;
    self.tableView.sectionHeaderHeight = 55;
    self.clearsSelectionOnViewWillAppear = NO;
    
    for(int i=0; i<7; i++)
    {
        UITextField *item = [[UITextField alloc] init];
        item.backgroundColor = [UIColor whiteColor];
        item.textAlignment = NSTextAlignmentLeft;
        item.autocorrectionType = UITextAutocorrectionTypeNo;
        item.clearButtonMode = UITextFieldViewModeAlways;
        item.textColor = [UIColor colorWithRed:0.15 green:0.35 blue:0.75 alpha:1.0];
        item.delegate = self;
        if( i == 0 ) webService = item;
        if( i == 1 ) username = item;
        if( i == 2 ) password = item;
        if( i == 3 ) senderName = item;
        if( i == 4 ) senderAddr = item;
        if( i == 5 ) senderComp = item;
        if( i == 6 ) senderPhon = item;
    }
    [self setEditorFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setEditorFrames];
}

- (void)switchCoverpage
{
    if( coverPageSwitch.on )
    {
        if( [ImgCollection count] > 0 )
        {
            NSString *file = [ImgCollection objectAtIndex:0];
            NSArray *array = [file componentsSeparatedByString:@"/"];
            NSString *subStr = [array objectAtIndex:[array count]-1];
            NSRange range = [subStr rangeOfString:@"Coverpage-"];
            if( range.location != 0 )
            {
                [sendPage addCoverpageForAttachment];
            }
        }
        else
        {
            [sendPage addCoverpageForAttachment];
        }
    }
    else
    {
        if( [ImgCollection count] > 0 )
        {
            NSString *file = [ImgCollection objectAtIndex:0];
            NSArray *array = [file componentsSeparatedByString:@"/"];
            NSString *subStr = [array objectAtIndex:[array count]-1];
            NSRange range = [subStr rangeOfString:@"Coverpage-"];
            if( range.location == 0 )
            {
                [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
                [ImgCollection removeObjectAtIndex:0];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return coverPageSwitch.on ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cnt = 0;
    if( section == 0 )
        cnt = 3;
    if( section == 1 )
        cnt = 3;
    if( section == 2 )
        cnt = 4;
    return cnt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = @"";
    if( section == 0 )
        ret = @"Account info";
    if( section == 1 )
        ret = @"System info";
    if( section == 2 )
        ret = @"Sender info";
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSInteger fontSize = nDeviceType == DEVICE_IPHONE ? 15 : 18;
    cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:fontSize];
    cell.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
    cell.detailTextLabel.text = @"";
    
    if( indexPath.section == 0 && indexPath.row == 0 )
    {
        cell.textLabel.text = @"Server:";
        webService.placeholder = @"required";
        webService.keyboardType = UIKeyboardTypeURL;
//        webService.clearButtonMode = UITextFieldViewModeNever;
        webService.text = sWebService;
        [cell.contentView addSubview:webService];
    }
    if( indexPath.section == 0 && indexPath.row == 1 )
    {
        cell.textLabel.text = @"Username:";
        username.placeholder = @"required";
        username.keyboardType = UIKeyboardTypeEmailAddress;
        username.text = sUsername;
        [cell.contentView addSubview:username];
    }
    if( indexPath.section == 0 && indexPath.row == 2 )
    {
        cell.textLabel.text = @"Password:";
        password.placeholder = @"required";
        password.text = sPassword;
        password.secureTextEntry = YES;
        [cell.contentView addSubview:password];
    }
    if( indexPath.section == 1 && indexPath.row == 0 )
    {
        cell.textLabel.text = @"Web service version";
        cell.detailTextLabel.text = WebServiceVersion;
    }
    if( indexPath.section == 1 && indexPath.row == 1 )
    {
        cell.textLabel.text = @"This app version";
        cell.detailTextLabel.text = APP_VERSION;
    }
    if( indexPath.section == 1 && indexPath.row == 2 )
    {
        cell.textLabel.text = @"Use cover page";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = coverPageSwitch;
    }
    if( indexPath.section == 2 && indexPath.row == 0 )
    {
        cell.textLabel.text = @"Name:";
        senderName.autocapitalizationType = UITextAutocapitalizationTypeWords;
        senderName.text = sSenderName;
        [cell.contentView addSubview:senderName];
    }
    if( indexPath.section == 2 && indexPath.row == 1 )
    {
        cell.textLabel.text = @"Fax number:";
        senderAddr.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        senderAddr.text = sSenderAddr;
        [cell.contentView addSubview:senderAddr];
    }
    if( indexPath.section == 2 && indexPath.row == 2 )
    {
        cell.textLabel.text = @"Company:";
        senderComp.autocapitalizationType = UITextAutocapitalizationTypeWords;
        senderComp.text = sSenderComp;
        [cell.contentView addSubview:senderComp];
    }
    if( indexPath.section == 2 && indexPath.row == 3 )
    {
        cell.textLabel.text = @"Phone:";
        senderPhon.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        senderPhon.text = sSenderPhon;
        [cell.contentView addSubview:senderPhon];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
}

- (void)setEditorFrames
{
    int w = self.view.frame.size.width - 10;
    if( nDeviceType == DEVICE_IPHONE )
    {
        webService.frame = CGRectMake(80, 6, w-80, 31);
        username.frame = CGRectMake(110, 6, w-110, 31);
        password.frame = CGRectMake(110, 6, w-110, 31);
        senderName.frame = CGRectMake(120, 6, w-120, 31);
        senderAddr.frame = CGRectMake(120, 6, w-120, 31);
        senderComp.frame = CGRectMake(120, 6, w-120, 31);
        senderPhon.frame = CGRectMake(120, 6, w-120, 31);
    }
    else
    {
        webService.frame = CGRectMake(133, 9, w-133, 26);
        username.frame = CGRectMake(133, 9, w-133, 26);
        password.frame = CGRectMake(133, 9, w-133, 26);
        senderName.frame = CGRectMake(145, 9, w-145, 26);
        senderAddr.frame = CGRectMake(145, 9, w-145, 26);
        senderComp.frame = CGRectMake(145, 9, w-145, 26);
        senderPhon.frame = CGRectMake(145, 9, w-145, 26);
    }
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if( nDeviceType == DEVICE_IPHONE || (nDeviceType == DEVICE_IPAD && bOrientLandscape) )
    {
        if( [sender isEqual:senderName] || [sender isEqual:senderAddr] || [sender isEqual:senderComp] || [sender isEqual:senderPhon] )
        {
            [self performSelector:@selector(doBeginEditing) withObject:nil afterDelay:0.1];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    if( [sender isEqual:webService] )
        sWebService = webService.text;
    if( [sender isEqual:username] )
        sUsername = username.text;
    if( [sender isEqual:password] )
        sPassword = password.text;
    if( [sender isEqual:senderName] )
        sSenderName = senderName.text;
    if( [sender isEqual:senderAddr] )
        sSenderAddr = senderAddr.text;
    if( [sender isEqual:senderComp] )
        sSenderComp = senderComp.text;
    if( [sender isEqual:senderPhon] )
        sSenderPhon = senderPhon.text;
}

- (void)doBeginEditing
{
    [self.tableView setContentOffset:CGPointMake(0, 290) animated:YES];
}

- (IBAction)OnLogin:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [wsm terminateSession];
    [self sveData];
    if( [inboxPage setInfo] )
    {
        [viewerPage switchToView:viewerPage];
        [viewerPage displayLogoImage];
        [inboxPage OnRefresh:nil];
        [self.tableView reloadData];
    }
}

- (void)sveData
{
    NSDictionary* prop = [NSDictionary dictionaryWithObjectsAndKeys:
                          webService ? webService.text : sWebService,        @"WebService",
                          username ? username.text : sUsername,              @"Username",
                          password ? password.text : sPassword,              @"Password",
                          [NSNumber numberWithBool:coverPageSwitch.on],      @"UseCoverpage",
                          senderName ? senderName.text : sSenderName,        @"SenderName",
                          senderAddr ? senderAddr.text : sSenderAddr,        @"SenderAddr",
                          senderComp ? senderComp.text : sSenderComp,        @"SenderComp",
                          senderPhon ? senderPhon.text : sSenderPhon,        @"SenderPhon",
                          nil];
    [prop writeToFile:settingsFilePath atomically:YES];
}

@end
