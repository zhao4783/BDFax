//
//  ContactsViewController.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 5/30/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "PageViewController.h"
#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

extern NSInteger nContactSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.sectionHeaderHeight = 45;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(85, 6, 30, 30);
    [self.navigationController.navigationBar addSubview:spinner];
    [spinner stopAnimating];
    
    btAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [[btAdd layer] setBorderWidth:1.0f];
    [[btAdd layer] setBorderColor:[UIColor blackColor].CGColor];
    [[btAdd layer] setCornerRadius:4.0];
    [[btAdd layer] setMasksToBounds:YES];
    [btAdd setTitle:@"+" forState:UIControlStateNormal];
    [btAdd setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btAdd.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [btAdd addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];

    btDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [[btDelete layer] setBorderWidth:1.0f];
    [[btDelete layer] setBorderColor:[UIColor blackColor].CGColor];
    [[btDelete layer] setCornerRadius:4.0];
    [[btDelete layer] setMasksToBounds:YES];
    [btDelete setTitle:@"-" forState:UIControlStateNormal];
    [btDelete setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btDelete.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [btDelete addTarget:self action:@selector(deleteContacts) forControlEvents:UIControlEventTouchUpInside];
    
    contactSegments = [[UISegmentedControl alloc] init];
    contactSegments.tintColor = [UIColor colorWithRed:0.9 green:0.6 blue:0.45 alpha:1.0];
    [contactSegments addTarget:self action:@selector(changeContactSource) forControlEvents:UIControlEventValueChanged];
    [contactSegments insertSegmentWithTitle:@"From Local" atIndex:0 animated:NO];
    [contactSegments insertSegmentWithTitle:@"From Server" atIndex:1 animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    contactSegments.selectedSegmentIndex = nContactSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeContactSource
{
    nContactSource = contactSegments.selectedSegmentIndex;
    [spinner startAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        [sendPage setContacts];
        [spinner stopAnimating];
    });
}

- (void)deleteContacts
{
    NSArray *array = self.tableView.indexPathsForSelectedRows;
    if( [array count] == 0 )
        return;
    NSString *msg = [NSString stringWithFormat:@"Do you want to delete %d selected contacts?", (int)[array count]];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete contacts"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         NSMutableArray *contacts = [[NSMutableArray alloc] init];
                                                         for(NSIndexPath *indexPath in array)
                                                         {
                                                             NSDictionary *dic = [appContacts objectAtIndex:indexPath.row];
                                                             NSString *cid = [dic objectForKey:KEY_CONTACTID];
                                                             [contacts addObject:cid];
                                                         }
                                                         [wsm deleteContacts:contacts];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

NSString *defaultName = @"";
NSString *defaultAddress = @"";
NSString *defaultCompany = @"";
- (void)addContact
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add a contact"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self enterContactName:alert.textFields[0].text
                                                                             address:alert.textFields[1].text
                                                                             company:alert.textFields[2].text];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name: (required)";
        textField.font = [UIFont systemFontOfSize:16];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.text = defaultName;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email / Fax#: (required)";
        textField.font = [UIFont systemFontOfSize:16];
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.text = defaultAddress;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Company:";
        textField.font = [UIFont systemFontOfSize:16];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.text = defaultCompany;
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)enterContactName:(NSString *)name address:(NSString *)address company:(NSString *)company
{
    defaultName = name;
    defaultCompany = company;
    defaultAddress = address;
    name = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if( [name isEqualToString:@""] )
    {
        [self ShowAlertTitle:@"Error" message:@"You have to input a name."];
        return;
    }
    address = [address stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    if( ![sendPage isEmailAddres:address] && ![sendPage isFaxNumber:address] )
    {
        [self ShowAlertTitle:@"Error" message:@"Email/Fax# has a bad format."];
        return;
    }

    for(NSDictionary *obj in appContacts)
    {
        NSString *addr = [obj objectForKey:KEY_ADDRESS];
        if( [address isEqualToString:addr] )
        {
            [self ShowAlertTitle:@"Cannot add" message:@"The email/fax# has already existed."];
            return;
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         name,     KEY_NAME,
                         address,  KEY_ADDRESS,
                         company,  KEY_COMPANY,
                         nil];
    if( nContactSource == 0 )
    {
        [appContacts addObject:dic];
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[appContacts count]-1 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    if( nContactSource == 1 )
    {
        [wsm addContact:dic];
    }

    defaultName = @"";
    defaultCompany = @"";
    defaultAddress = @"";
}

- (void)ShowAlertTitle:(NSString *)title message:(NSString *)msg
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle: title
                                                                    message: msg
                                                             preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appContacts count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    NSDictionary *item = [appContacts objectAtIndex:indexPath.row];
    NSString *txt = [item objectForKey:KEY_NAME];
    NSString *company = [item objectForKey:KEY_COMPANY];
    if( ![company isEqualToString:@""] )
    {
        txt = [txt stringByAppendingString:@",  "];
        txt = [txt stringByAppendingString:company];
    }
    if( nDeviceType == DEVICE_IPHONE )
    {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = txt;
    NSString *text = [item objectForKey:KEY_ADDRESS];
    if( [text containsString:@"@"] )
        text = [NSString stringWithFormat:@"email: %@", text];
    else
        text = [NSString stringWithFormat:@"fax#: %@", text];
    cell.detailTextLabel.text = text;

    return cell;
}

// Fixed for iPhone X
- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    int leftMargin = 0;
    int rightMargin = 0;
    if( @available(iOS 11.0, *) )
    {
        leftMargin = self.view.safeAreaInsets.left;
        rightMargin = self.view.safeAreaInsets.right;
    }
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    CGRect rt = header.frame;
    rt.origin.x = 10 + leftMargin;
    rt.origin.y = rt.size.height - 34;
    rt.size.width = 210;
    rt.size.height = 30;
    contactSegments.frame = rt;
    if( ![contactSegments isDescendantOfView:header] )
        [header addSubview:contactSegments];

    if( nContactSource == 0 )
    {
        btAdd.hidden = YES;
        btDelete.hidden = YES;
    }
    if( nContactSource == 1 )
    {
        int width = header.frame.size.width - rightMargin;
        rt.origin.x = width - 50;
        rt.size.width = 40;
        btDelete.frame = rt;
        btDelete.hidden = NO;
        if( ![btDelete isDescendantOfView:header] )
            [header addSubview:btDelete];
        rt.origin.x = width - 92;
        rt.size.width = 40;
        btAdd.frame = rt;
        btAdd.hidden = NO;
        if( ![btAdd isDescendantOfView:header] )
            [header addSubview:btAdd];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if( nContactSource == 1 && nDeviceType == DEVICE_IPHONE )
    {
        int leftMargin = 0;
        int rightMargin = 0;
        if( @available(iOS 11.0, *) )
        {
            leftMargin = self.view.safeAreaInsets.left;
            rightMargin = self.view.safeAreaInsets.right;
        }
        CGRect rt = contactSegments.frame;
        rt.origin.x = 10 + leftMargin;
        contactSegments.frame = rt;
        int width = self.view.frame.size.width - rightMargin;
        rt = btDelete.frame;
        rt.origin.x = width - 50;
        btDelete.frame = rt;
        rt = btAdd.frame;
        rt.origin.x = width - 92;
        btAdd.frame = rt;
    }
}

@end
