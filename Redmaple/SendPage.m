//
//  SendPage.m
//  MobileFax
//
//  Created by Zhao                                                     on 5/30/13.
//  Copyright (c) 2013 Zhao                                                    . All rights reserved.
//

#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PageViewController.h"
#import "SendPage.h"
#import "NSTiffSplitter.h"
#import "tiffio.h"
#import "dynthresh.h"
#import "dither.h"
#import "AppDelegate.h"
#import "Wsmanager.h"
#import "ContactsViewController.h"
#import "ContactVO.h"

#include<unistd.h>
#include<netdb.h>

@implementation MyTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    return NO;
}

@end

@interface SendPage ()
@end

@implementation SendPage
@synthesize spinner, attachmentArray, recipient, bSendSftfax;

CGRect AttachRect[MAX_PAGE_COUNT];
NSMutableArray *JobQueue = nil;
NSInteger nSensitivity = 0;
NSInteger nMessageWindowHeight = 160;
NSInteger nAttachmentWindowHeight = 230;
NSInteger thumbInterval = 8;
NSInteger thumbWidth = 0;
NSInteger thumbHeight = 0;
NSInteger nMoveToPage = -1;
NSString *strOutBox = @"";
NSString *subjectText = @"";
NSString *memoText = @"";
NSMutableArray *recipientArray = nil;
UIButton *dropboxButton = nil;
UIButton *photosButton = nil;
UIButton *cameraButton = nil;
UIButton *bwCameraButton = nil;
UIButton *iCloudButton = nil;
BOOL bCoverPageOn = YES;
BOOL bAllImageFiles = NO;
int attachmentToolsY = 0;
NSMutableArray *matchedContacts = nil;
NSInteger nScreenWidth = 0;
UINavigationController *contactNaviController = nil;
ContactsViewController *contactsVC = nil;
NSInteger nContactSource = 0;
BOOL bScrollToBottom = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];

    sendPage = self;
    self.tableView.sectionHeaderHeight = 55;

    NSInteger fontSize = nDeviceType == DEVICE_IPHONE ? 13 : 15;
    recipient = [[MyTextField alloc] init];
    recipient.font = [UIFont systemFontOfSize:fontSize];
    recipient.textColor = [UIColor colorWithRed:0.0 green:0.35 blue:0.75 alpha:1.0];
    recipient.text = @"";
    recipient.delegate = self;
    recipient.keyboardType = UIKeyboardTypeURL;
    recipient.autocorrectionType = UITextAutocorrectionTypeNo;
    subject = [[UITextField alloc] init];
    subject.font = [UIFont systemFontOfSize:fontSize];
    subject.text = @"";
    subject.delegate = self;
    subject.autocorrectionType = UITextAutocorrectionTypeNo;
    memo = [[UITextView alloc] init];
    memo.font = [UIFont systemFontOfSize:fontSize];
    memo.text = @"";
    memo.delegate = self;
    memo.autocorrectionType = UITextAutocorrectionTypeNo;
    scrollView = [[UIScrollView alloc] init];
    nScreenWidth = [self getWindowWidth];
    nAttachmentWindowHeight = nDeviceType == DEVICE_IPAD ? 400 : 230;
    CGRect rect = CGRectMake(0, 5, nScreenWidth, nAttachmentWindowHeight-10);
    scrollView.frame = rect;
    imageView = [[UIImageView alloc] init];
    imageView.frame = rect;
    [scrollView addSubview:imageView];

    AttachImageArray = [[NSMutableArray alloc] init];
    attachmentArray = [[NSMutableArray alloc] init];
    recipientArray = [[NSMutableArray alloc] init];
    JobQueue = [[NSMutableArray alloc] init];
    NSInteger y = 510;
    if( nDeviceType==DEVICE_IPAD )
    {
        if( nIOSVersion <= 6 )
            y -= 38;
    }
    else
    {
        y = nIOSVersion<7 ? 372 : 404;
    }
    labelAttachments = [[UILabel alloc] initWithFrame:CGRectMake(140, y, 165, 30)];
    labelAttachments.font = [UIFont systemFontOfSize:15];
    labelAttachments.text = nil;
    labelAttachments.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    [self.tableView addSubview:labelAttachments];

    deviceContacts = [[NSMutableArray alloc] init];
    recipients = [[NSMutableArray alloc] init];
    nSelectedPage = -1;
    nDeleteOne = -1;
    thumbWidth = nDeviceType==DEVICE_IPAD ? nIOSVersion<7?102:115 : 85;
    thumbHeight = thumbWidth * 110.0 / 85.0;
    
    int wt = 18;
    int ht = 18;
    UIGraphicsBeginImageContext(CGSizeMake(wt, ht));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    [[UIColor blueColor] set];
    CGContextSetLineWidth(ctx, 0.8);
    CGContextMoveToPoint(ctx, 4, ht/2);
    CGContextAddLineToPoint(ctx, wt-4, ht/2);
    CGContextMoveToPoint(ctx, wt/2, 4);
    CGContextAddLineToPoint(ctx, wt/2, ht-4);
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, wt-2, ht-2));
    CGContextStrokePath(ctx);
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(2, 2, wt+5, ht+5);
    UIImage* goodImg3 = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [addButton setImage:goodImg3 forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(showContacts) forControlEvents:UIControlEventTouchUpInside];

    UILongPressGestureRecognizer *tap1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    tap1.numberOfTouchesRequired = 1;
    tap1.minimumPressDuration = 0.12;
    [scrollView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuForAttachment:)];
    tap2.numberOfTapsRequired = 2;
    tap2.numberOfTouchesRequired = 1;
    [scrollView addGestureRecognizer:tap2];

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(100, 5, 30, 30);
    [self.navigationController.navigationBar addSubview:spinner];
    spinner.hidden = YES;

    matchedContactsTable = [[UITableView alloc] initWithFrame:CGRectMake(-nScreenWidth, 0, nScreenWidth, 200)];
    matchedContactsTable.delegate = self;
    matchedContactsTable.dataSource = self;
    matchedContactsTable.hidden = YES;
    [self.tableView addSubview:matchedContactsTable];

    attachmentSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 340, 30)];
    attachmentSegments.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    attachmentSegments.tintColor = [UIColor colorWithRed:0.9 green:0.6 blue:0.45 alpha:1.0];
    [attachmentSegments addTarget:self action:@selector(onAnnotationMenu) forControlEvents:UIControlEventValueChanged];
    [attachmentSegments insertSegmentWithImage:[[UIImage imageNamed:@"iCloud.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] atIndex:0 animated:NO];
    [attachmentSegments insertSegmentWithImage:[[UIImage imageNamed:@"Photos.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] atIndex:1 animated:NO];
    [attachmentSegments insertSegmentWithImage:[[UIImage imageNamed:@"Camera.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] atIndex:2 animated:NO];
    [attachmentSegments insertSegmentWithImage:[[UIImage imageNamed:@"Dropbox.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] atIndex:4 animated:NO];


    strOutBox = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"outBox"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:strOutBox] )
    {
        [fileManager removeItemAtPath:strOutBox error:nil];
    }
    [fileManager createDirectoryAtPath:strOutBox withIntermediateDirectories:NO attributes:nil error:nil];
 
    matchedContacts = [[NSMutableArray alloc] init];
    if( coverPageSwitch.on )
    {
        [self addCoverpageForAttachment];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setContacts];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setAttachmentImages];
}
    
- (void)showSpinner
{
    [spinner startAnimating];
    [spinner setHidden:NO];
}

- (void)hideSpinner
{
    [spinner stopAnimating];
    [spinner setHidden:YES];
}

- (NSInteger)getWindowWidth
{
    return self.view.frame.size.width;
}

- (void)onAnnotationMenu
{
    bBackToSendPage = YES;
    if( attachmentSegments.selectedSegmentIndex == 0 )
        [viewerPage onICloudDrive];
    if( attachmentSegments.selectedSegmentIndex == 1 )
        [viewerPage onPhotoLibrary];
    if( attachmentSegments.selectedSegmentIndex == 2 )
        [viewerPage onTakePicture];
    if( attachmentSegments.selectedSegmentIndex == 3 )
        [self onDropbox];
    attachmentSegments.selectedSegmentIndex = -1;
}

- (void)attachFile:(NSString *)file
{
    int num = (int)[ImgCollection count];
    if( num < MAX_ATTACHMENT_COUNT )
    {
        [ImgCollection addObject:file];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // Return the number of sections.
    NSInteger cnt = 1;
    if( aTableView == self.tableView ) cnt = 2;
    
    return cnt;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger cnt = 0;
    
    if( aTableView == self.tableView )
    {
        if( section == 0 )
            cnt = 3;
        if( section == 1 )
            cnt = 1;
    }
    if( aTableView == matchedContactsTable )
        cnt = [matchedContacts count] ;
    
    return cnt;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    if( aTableView == self.tableView )
    {
        if( section == 0 )
            ret = @"Message:";
        if( section == 1 )
            ret = @"Attachments:";
    }
    
    return ret;
}

- (NSString *)tableView:(UITableView *)aTableView titleForFooterInSection:(NSInteger)section
{
    NSString *ret = nil;
    if( aTableView == self.tableView )
    {
        if( section == 1 )
        {
            ret = @"To view a menu of other actions for an attachment, double tap on the attachment.";
        }
    }
    
    return ret;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0;
    if( aTableView == self.tableView )
    {
        if( indexPath.section == 0 )
        {
            if( indexPath.row == 0 )
            {
                height = 40;
            }
            if( indexPath.row == 1 )
            {
                height = 40;
            }
            if( indexPath.row == 2 )
            {
                height = nMessageWindowHeight - 80;
            }
        }
        if( indexPath.section == 1 )
        {
            height = nAttachmentWindowHeight;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if( aTableView == self.tableView )
    {
        CellIdentifier = [NSString stringWithFormat:@"tableView %d:%d", (int)indexPath.section, (int)indexPath.row];
    }
    if( aTableView == matchedContactsTable )
    {
        CellIdentifier = [NSString stringWithFormat:@"contacts %d:%d", (int)indexPath.section, (int)indexPath.row];
    }
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        if( aTableView == matchedContactsTable )
        {
            NSInteger style = nDeviceType == DEVICE_IPAD ? UITableViewCellStyleValue1 : UITableViewCellStyleSubtitle;
            cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:CellIdentifier];
        }
        else
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    NSInteger fontSize = nDeviceType == DEVICE_IPHONE ? 15 : 18;
    cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:0.15 blue:0.75 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.05 green:0.15 blue:0.65 alpha:1.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if( aTableView == self.tableView )
    {
        NSInteger width = [self getWindowWidth];
        CGRect rect = CGRectMake(2, 1, width, 40);
        if( indexPath.section == 0 )
        {
            cell.textLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0];
            NSInteger fs = nDeviceType == DEVICE_IPHONE ? 13 : 15;
            cell.textLabel.font = [UIFont systemFontOfSize:fs];
            if( indexPath.row == 0 )
            {
                cell.textLabel.text = @"To:";
                rect.origin.x = nDeviceType == DEVICE_IPHONE ? 40 : 42;
                rect.origin.y = 3;
                rect.size.width -= rect.origin.x + 50;
                rect.size.height = 34;
                recipient.frame = rect;
                [recipient removeFromSuperview];
                [cell.contentView addSubview:recipient];
                cell.accessoryView = addButton;
            }
            if( indexPath.row == 1 )
            {
                cell.textLabel.text = @"Subject:";
                rect.origin.x = nDeviceType == DEVICE_IPHONE ? 72 : 78;
                rect.origin.y = 3;
                rect.size.width -= rect.origin.x + 10;
                rect.size.height = 34;
                subject.frame = rect;
                [subject removeFromSuperview];
                [cell.contentView addSubview:subject];
            }
            if( indexPath.row == 2 )
            {
                rect.origin.x = 10;
                rect.origin.y = 0;
                rect.size.width -= 10;
                rect.size.height = nMessageWindowHeight-82;
                memo.frame = rect;
                [memo removeFromSuperview];
                [cell.contentView addSubview:memo];
            }
        }
        if( indexPath.section == 1 )
        {
            [scrollView removeFromSuperview];
            [cell.contentView addSubview:scrollView];
        }
    }

    if( aTableView == matchedContactsTable )
    {
        NSDictionary *item = [matchedContacts objectAtIndex:indexPath.row];
        NSString *txt = [item objectForKey:KEY_NAME];
        if( nDeviceType == DEVICE_IPAD )
        {
            NSString *company = [item objectForKey:KEY_COMPANY];
            if( ![company isEqualToString:@""] )
            {
                txt = [txt stringByAppendingString:@",  "];
                txt = [txt stringByAppendingString:company];
            }
        }
        if( nDeviceType == DEVICE_IPHONE )
        {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.text = txt;
        cell.detailTextLabel.text = [item objectForKey:KEY_ADDRESS];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
    if( section == 1 )
    {
        CGRect rt = header.frame;
        int len = nDeviceType == DEVICE_IPAD ? 340 : 200;
        rt.origin.x = rt.size.width - 15 - len;
        rt.origin.y = rt.size.height - 34;
        rt.size.width = len;
        rt.size.height = 30;
        attachmentSegments.frame = rt;
        [header addSubview:attachmentSegments];
    }
}

- (void)tableView:(UITableView *)aTableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( aTableView == matchedContactsTable && [matchedContacts count] > 0 )
    {
        NSDictionary *dic = [matchedContacts objectAtIndex:indexPath.row];
        NSString *str = recipient.text;
        NSRange rgn = [str rangeOfString:@", " options:NSBackwardsSearch];
        NSString *data = rgn.location == NSNotFound ? @"" : [str substringToIndex:rgn.location+rgn.length];
        if( [self addRecipient:dic] )
        {
            NSString *item = [dic valueForKey:KEY_NAME];
            if( [item isEqualToString:@""] )
                item = [dic valueForKey:KEY_ADDRESS];
            data = [data stringByAppendingString:item];
            data = [data stringByAppendingString:@", "];
        }
        recipient.text = data;
        [self hideMatchedContactsTable];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // nScreenWidth will be current view's height instead of width!
    nScreenWidth = self.view.frame.size.height;
    
    CGRect rt = matchedContactsTable.frame;
    rt.size.width = nScreenWidth;
    matchedContactsTable.frame = rt;
    
    rt = scrollView.frame;
    rt.size.width = nScreenWidth;
    scrollView.frame = rt;
    rt = imageView.frame;
    rt.size.width = nScreenWidth;
    imageView.frame = rt;
    [self setAttachmentImages];
    
    if( webView )
    {
        rt = webView.frame;
        rt.size.width = nScreenWidth;
        rt.size.height = self.view.frame.size.width - rt.origin.y;
        webView.frame = rt;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    nScreenWidth = self.view.frame.size.width;
    int len = nDeviceType == DEVICE_IPAD ? 340 : 200;
    if( nDeviceType == DEVICE_IPHONE && nScreenWidth > self.view.frame.size.height )
        len = 340;
    CGRect rt = attachmentSegments.frame;
    rt.origin.x = nScreenWidth - 15 - len;
    rt.size.width = len;
    attachmentSegments.frame = rt;
    
    if( contactNaviController )
    {
        rt = addButton.frame;
        rt.origin.x = nScreenWidth - 45;
        rt.origin.y += 50;
        contactNaviController.popoverPresentationController.sourceRect = rt;
    }
}

- (BOOL)isFaxNumber:(NSString *)address
{
    NSInteger len = [address length];
    if( len == 0 )
        return NO;
    NSInteger i = 0;
    for(i=0; i<len; i++)
    {
        char t = [address characterAtIndex:i];
        if( (t >= '0' && t <= '9') || (t == '-' || t == ' ' || t == '\xa0' || t == '(' || t == ')') )
            continue;
        else
            return NO;
    }
    return YES;
}

- (BOOL)isEmailAddres:(NSString *)address
{
    NSInteger len = [address length];
    for(int i=1; i<len-1; i++)
    {
        char t = [address characterAtIndex:i];
        if( t == '@' )
            return YES;
    }
    return NO;
}

- (void)setContacts
{
    if( nContactSource == 0 )
    {
        if ([CNContactStore class])
        {
            [self showSpinner];
            [deviceContacts removeAllObjects];
            CNEntityType entityType = CNEntityTypeContacts;
            if( [CNContactStore authorizationStatusForEntityType:entityType] == CNAuthorizationStatusNotDetermined)
            {
                CNContactStore * contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error)
                 {
                     if(granted)
                     {
                         [self getAllContact];
                     }
                 }];
            }
            else if( [CNContactStore authorizationStatusForEntityType:entityType]== CNAuthorizationStatusAuthorized)
            {
                [self getAllContact];
            }
            appContacts = deviceContacts;
            [self sortContacts];
            [contactsVC.tableView reloadData];
            [self hideSpinner];
        }
    }
    if( nContactSource == 1 )
    {
        NSArray *contacts = [wsm getContacts];
        [self refreshContacts:contacts];
    }
}

- (void)refreshContacts:(NSArray *)contacts
{
    [deviceContacts removeAllObjects];
    if( contacts == nil )
    {
        appContacts = nil;
        [contactsVC.tableView reloadData];
        return;
    }
    
    if( [contacts isKindOfClass:[NSDictionary class]] )
    {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)contacts];
        NSArray *arr = [NSArray arrayWithObject:dic];
        appContacts = (NSMutableArray *)arr;
    }
    else
    {
        appContacts = (NSMutableArray *)contacts;
    }
    
    for(NSDictionary *obj in appContacts)
    {
        NSString *firstName = [obj objectForKey:@"firstName"];
        NSString *lastName = [obj objectForKey:@"lastName"];
        NSString *name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        name = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
        NSString *address = [obj objectForKey:@"emailAddress"];
        if( [address isEqualToString:@""] )
            address = [obj objectForKey:@"faxNumber"];
        NSString *company = [obj objectForKey:@"company"];
        NSString *contactId = [obj objectForKey:@"contactId"];
        
        if( ![address isEqualToString:@""] )
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 name,      KEY_NAME,
                                 address,   KEY_ADDRESS,
                                 company,   KEY_COMPANY,
                                 contactId, KEY_CONTACTID,
                                 nil];
            [deviceContacts addObject:dic];
        }
    }
    appContacts = deviceContacts;
    NSString *lastOne = [[appContacts lastObject] objectForKey:KEY_ADDRESS];
    [self sortContacts];
    [contactsVC.tableView setContentOffset:CGPointZero];
    [contactsVC.tableView reloadData];
    if( bScrollToBottom )
    {
        bScrollToBottom = NO;
        for(int i=0; i<[appContacts count]; i++)
        {
            NSDictionary *dic = [appContacts objectAtIndex:i];
            NSString *addr = [dic objectForKey:KEY_ADDRESS];
            if( [addr isEqualToString:lastOne] )
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [contactsVC.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                break;
            }
        }
    }
}

- (void)resetContactList:(NSNumber *)val
{
    if( nContactSource == 1 )
    {
        bScrollToBottom = [val boolValue];
        NSArray *contacts = [wsm getContacts];
        [self refreshContacts:contacts];
    }
}

- (void)getAllContact
{
    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactOrganizationNameKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            [self parseContactWithContact:contact];
        }];
    }
}

- (void)parseContactWithContact :(CNContact* )contact
{
    NSString * firstName =  contact.givenName;
    NSString * lastName =  contact.familyName;
    NSString * company =  contact.organizationName;
    NSString * name = @"";
    if( firstName != nil && lastName != nil ) name = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    if( firstName == nil && lastName != nil ) name = [NSString stringWithFormat:@"%@",lastName];
    if( firstName != nil && lastName == nil ) name = [NSString stringWithFormat:@"%@",firstName];
    if( [name isEqualToString:@""] )
        return;
    
    if( nWebService != WEB_SERVICE_ANYWHER )
    {
        NSArray * emails = [contact.emailAddresses valueForKey:@"value"];
        for( NSString* email in emails )
        {
            if( (nWebService == WEB_SERVICE_MOBILE && ![self isEmailAddres:email]) ||
                (nWebService == WEB_SERVICE_SFT && [self isEmailAddres:email]) )
            {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     name,     KEY_NAME,
                                     email,    KEY_ADDRESS,
                                     company,  KEY_COMPANY,
                                     nil];
                [deviceContacts addObject:dic];
            }
        }
    }
    
    for (CNLabeledValue<CNPhoneNumber*>* labeledValue in contact.phoneNumbers)
    {
        if( [labeledValue.label isEqualToString:CNLabelPhoneNumberHomeFax] ||
           [labeledValue.label isEqualToString:CNLabelPhoneNumberWorkFax] ||
           [labeledValue.label isEqualToString:CNLabelPhoneNumberOtherFax] )
        {
            NSString *fax = labeledValue.value.stringValue;
            if( [self isFaxNumber:fax] )
            {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     name,     KEY_NAME,
                                     fax,      KEY_ADDRESS,
                                     company,  KEY_COMPANY,
                                     nil];
                [deviceContacts addObject:dic];
            }
        }
    }
}

- (BOOL)addRecipient:(NSDictionary *)rec
{
    NSString *name = [rec objectForKey:KEY_NAME];
    NSString *addr = [rec objectForKey:KEY_ADDRESS];
    if( [addr isEqualToString:@""] )
        return NO;
    
    BOOL Ok = YES;
    NSInteger num = [recipients count];
    for(NSInteger i=0; i<num; i++)
    {
        NSDictionary *dic = [recipients objectAtIndex:i];
        if( ![name isEqualToString:@""] && nWebService == WEB_SERVICE_SFT )
        {
            if( [[dic objectForKey:KEY_NAME] caseInsensitiveCompare:name] == NSOrderedSame  )
            {
                [recipients replaceObjectAtIndex:i withObject:rec];
                return NO;
            }
        }
        else
        {
            if( [[dic objectForKey:KEY_ADDRESS] caseInsensitiveCompare:addr] == NSOrderedSame  )
            {
                Ok = NO;
                break;
            }
        }
    }
    
    if( Ok )
    {
        [recipients addObject:rec];
    }
    return Ok;
}

- (void)showContacts
{
    matchedContactsTable.hidden = YES;
    NSString *str = recipient.text;
    if( ![str isEqualToString:@""] )
    {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        NSInteger len = str.length;
        if( len > 0 && [str characterAtIndex:len-1] == ',' )
        {
            recipient.text = [str stringByAppendingString:@" "];
        }
        else
        {
            NSArray *arr = [str componentsSeparatedByString:@","];
            NSString *item = [arr lastObject];
            item = [item stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"",     KEY_NAME,
                                 item,    KEY_ADDRESS,
                                 @"",     KEY_COMPANY,
                                 nil];
            if( [self addRecipient:dic] )
            {
                recipient.text = [str stringByAppendingString:@", "];
            }
        }
    }
    [self setContactsInterface:@"Contacts"];
    [self setContacts];
}

- (void)sortContacts
{
    // sort the appContacts
    NSArray *ar1 = [NSArray arrayWithArray:appContacts];
    NSArray *array = [ar1 sortedArrayUsingComparator: ^(id obj1, id obj2)
                      {
                          NSString *str1 = [obj1 objectForKey:KEY_NAME];
                          NSString *str2 = [obj2 objectForKey:KEY_NAME];
                          return [str1 caseInsensitiveCompare:str2];
                      }];
    
    appContacts = (NSMutableArray *)array;
}

- (void)setContactsInterface:(NSString *)title
{
    [recipient resignFirstResponder];
    [subject resignFirstResponder];
    [memo resignFirstResponder];
    contactsVC = [[ContactsViewController alloc] initWithStyle:UITableViewStylePlain];
    contactsVC.preferredContentSize = CGSizeMake(375, 500);
    UIBarButtonItem *ok = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(contactsOk)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(contactsCancel)];
    contactNaviController = [[UINavigationController alloc] init];
    contactNaviController.viewControllers = [NSArray arrayWithObject:contactsVC];
    contactNaviController.navigationBar.topItem.title = @"Contacts";
    contactNaviController.navigationBar.topItem.leftBarButtonItem = cancel;
    contactNaviController.navigationBar.topItem.rightBarButtonItem = ok;
    contactNaviController.delegate = self;
    contactNaviController.modalPresentationStyle = UIModalPresentationPopover;
    contactNaviController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    contactNaviController.popoverPresentationController.sourceView = self.tableView;
    CGRect rt = addButton.frame;
    rt.origin.x = self.view.frame.size.width - 45;
    rt.origin.y += 50;
    contactNaviController.popoverPresentationController.sourceRect = rt;
    [self presentViewController:contactNaviController animated:YES completion:nil];
}

- (void)contactsCancel
{
    [contactsVC dismissViewControllerAnimated:YES completion:nil];
    contactsVC = nil;
}

- (void)contactsOk
{
    NSArray *array = contactsVC.tableView.indexPathsForSelectedRows;
    NSInteger num = [array count];
    for(NSInteger i=0; i<num; i++)
    {
        NSIndexPath *indexPath = [array objectAtIndex:i];
        NSDictionary *dic = [appContacts objectAtIndex:indexPath.row];
        
        // Replace a space that is 0xA0 with 0x20, if any.
        unichar a = 0xA0;
        NSString *space = [NSString stringWithCharacters:&a length:1];
        NSString *str[3];
        for(int i=0; i<3; i++)
        {
            NSString *txt;
            if( i == 0 ) txt = [dic objectForKey:KEY_NAME];
            if( i == 1 ) txt = [dic objectForKey:KEY_ADDRESS];
            if( i == 2 ) txt = [dic objectForKey:KEY_COMPANY];
            str[i] = [txt stringByReplacingOccurrencesOfString:space withString:@" "];
        }
        dic = [NSDictionary dictionaryWithObjectsAndKeys:
               str[0],    KEY_NAME,
               str[1],    KEY_ADDRESS,
               str[2],    KEY_COMPANY,
               nil];
        if( [self addRecipient:dic] )
        {
            NSString *stra = recipient.text;
            NSString *item = str[0];
            if( [item isEqualToString:@""] )
                item = str[1];
            stra = [stra stringByAppendingString:item];
            stra = [stra stringByAppendingString:@", "];
            recipient.text = stra;
        }
    }
    if( num > 0 )
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    [self contactsCancel];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self hideMatchedContactsTable];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    static BOOL bSelected = NO;
    
    if( textField == recipient )
    {
        if( string.length > 1 )
            return YES;
        
        int charter = [string isEqualToString:@""] ? 0 : [string characterAtIndex:0];
        NSInteger count = recipient.text.length;
        if( [string isEqualToString:@""] ) count -= 1;
        if( charter < 128 && range.location != count )
        {
            if( bSelected )
            {
                UITextRange *selectedRange = [recipient selectedTextRange];
                UITextPosition* beginning = recipient.beginningOfDocument;
                UITextPosition* selectionStart = selectedRange.start;
                UITextPosition* selectionEnd = selectedRange.end;
                const NSInteger location = [recipient offsetFromPosition:beginning toPosition:selectionStart];
                const NSInteger length = [recipient offsetFromPosition:selectionStart toPosition:selectionEnd];
                
                const int max = 1500;
                int commas[max];
                int index = 0;
                int start = 0;
                int end = -1;
                bool bStart = true;
                bool bEnd = true;
                for(int i=0; i<recipient.text.length; i++)
                {
                    if( [recipient.text characterAtIndex:i] == ',' )
                    {
                        if( bStart && location < i )
                        {
                            start = index;
                            bStart = false;
                        }
                        if( bEnd && location + length <= i+2 )
                        {
                            end = index;
                            bEnd = false;
                        }
                        commas[index++] = i;
                    }
                    if( index == max )
                        break;
                }
                
                NSInteger newLocation, newLength;
                if( start == 0 )
                {
                    newLocation = 0;
                }
                else
                {
                    newLocation = commas[start-1] + 2;
                }
                if( end == index - 1 )
                {
                    newLength = recipient.text.length - newLocation;
                }
                else
                {
                    newLength = commas[end] + 2 - newLocation;
                }
                
                UITextPosition *newPosition = [recipient positionFromPosition:selectedRange.start offset:newLocation-location];
                UITextPosition *endPosition = [recipient positionFromPosition:newPosition offset:newLength];
                UITextRange *newRange = [recipient textRangeFromPosition:newPosition toPosition:endPosition];
                [recipient setSelectedTextRange:newRange];
                for(int i=0; i<end-start+1; i++)
                {
                    if( [recipients count] > i )
                        [recipients removeObjectAtIndex:start];
                }
                bSelected = NO;
                return YES;
            }
            return NO;
        }
        
        NSArray *arr = [recipient.text componentsSeparatedByString:@","];
        if( [string isEqualToString:@","] )
        {
            NSString *item = [arr lastObject];
            item = [item stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            if( ![item isEqualToString:@""] )
            {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"",     KEY_NAME,
                                     item,    KEY_ADDRESS,
                                     @"",     KEY_COMPANY,
                                     nil];
                if( [self addRecipient:dic] )
                {
                    NSString *ss = [recipient.text stringByAppendingString:@", "];
                    recipient.text = ss;
                }
                else
                {
                    [viewerPage ShowAlertTitle:@"Error" message:@"The fax number is existing in the list."];
                }
            }
            return NO;
        }

        NSString *str = [arr lastObject];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if( [string isEqualToString:@""] && range.length == 1 )
        {
            NSInteger num = [arr count];
            if( num > 1 )
            {
                NSString *item = [arr objectAtIndex:num-2];
                item = [item stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
                UITextRange *selectedRange = [recipient selectedTextRange];
                NSInteger len = recipient.text.length;
                if( len > 0 && [recipient.text characterAtIndex:len-1] == ',' )
                {
                    UITextPosition *newPosition = [recipient positionFromPosition:selectedRange.start offset:-(item.length+1)];
                    UITextRange *newRange = [recipient textRangeFromPosition:newPosition toPosition:selectedRange.start];
                    [recipient setSelectedTextRange:newRange];
                    bSelected = YES;
                    return NO;
                }
                if( len > 1 && [recipient.text characterAtIndex:len-1] == ' ' && [recipient.text characterAtIndex:len-2] == ',' )
                {
                    UITextPosition *newPosition = [recipient positionFromPosition:selectedRange.start offset:-(item.length+2)];
                    UITextRange *newRange = [recipient textRangeFromPosition:newPosition toPosition:selectedRange.start];
                    [recipient setSelectedTextRange:newRange];
                    bSelected = YES;
                    return NO;
                }
            }
            
            if( str.length > 0 )
            {
                NSMutableString *data = [NSMutableString stringWithString:str];
                [data deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
                str = data;
            }
        }
        else
        {
            str = [str stringByAppendingString:string];
        }
        [matchedContacts removeAllObjects];
        
        if( str.length > 0 )
        {
            if( [str isEqualToString:@" "] )
            {
                return NO;
            }
            
            for(NSDictionary* dic in appContacts)
            {
                NSString* name = [dic valueForKey:KEY_NAME];
                NSRange rg = [name rangeOfString:str options:NSCaseInsensitiveSearch];
                if( rg.location == 0 )
                {
                    [matchedContacts addObject:dic];
                }
                else
                {
                    BOOL ok = NO;
                    NSArray *arr = [name componentsSeparatedByString:@" "];
                    if( [arr count] >= 2 )
                    {
                        NSString* lastName = [arr objectAtIndex:1];
                        NSRange rg = [lastName rangeOfString:str options:NSCaseInsensitiveSearch];
                        if( rg.location == 0 )
                        {
                            [matchedContacts addObject:dic];
                            ok = YES;
                        }
                        else
                        if( [arr count] > 2 )
                        {
                            NSString* lastName = [arr objectAtIndex:2];
                            NSRange rg = [lastName rangeOfString:str options:NSCaseInsensitiveSearch];
                            if( rg.location == 0 )
                            {
                                [matchedContacts addObject:dic];
                                ok = YES;
                            }
                        }
                    }
                    if( !ok )
                    {
                        NSString* addr = [dic valueForKey:KEY_ADDRESS];
                        NSRange rg = [addr rangeOfString:str options:NSCaseInsensitiveSearch];
                        if( rg.location == 0 )
                        {
                            [matchedContacts addObject:dic];
                        }
                    }
                }
            }
        }
        
        if( [matchedContacts count] > 0 )
        {
            if( matchedContactsTable.hidden )
            {
                CGRect rt = matchedContactsTable.frame;
                rt.origin.x = -nScreenWidth;
                rt.origin.y = biPhoneX ? 100 : 106;
                rt.size.height = 132;
                matchedContactsTable.frame = rt;
                matchedContactsTable.hidden = NO;
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                rt = matchedContactsTable.frame;
                rt.origin.x = 0;
                matchedContactsTable.frame = rt;
                [UIView commitAnimations];
            }
            [matchedContactsTable reloadData];
        }
        else
        {
            [self hideMatchedContactsTable];
        }
    }
    return YES;
}

- (void)hideMatchedContactsTable
{
    if( !matchedContactsTable.hidden )
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect rt = matchedContactsTable.frame;
        rt.origin.x = -nScreenWidth;
        matchedContactsTable.frame = rt;
        [UIView commitAnimations];
        matchedContactsTable.hidden = YES;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
}

- (void)addCoverpageForAttachment
{
    if( coverPageSwitch.on )
    {
        subjectText = subject.text;
        memoText = memo.text;
        NSDictionary *dic = nil;
        if( [recipients count] > 0 )
        {
            dic = [recipients objectAtIndex:0];
        }
        else
            if( ![recipient.text isEqualToString:@""] )
            {
                dic = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"",               KEY_NAME,
                       recipient.text,    KEY_ADDRESS,
                       @"",               KEY_COMPANY,
                       nil];
            }
        NSString *sf = [self getCoverpageImageFor:dic index:0];
        [ImgCollection insertObject:sf atIndex:0];
    }
}

- (UIImage *)convertion:(UIImage *)img setAnnotation:(BOOL)bSetAnnotation
{
    CGImageRef cgImage = [img CGImage];
    UIImage *copyImg = [[UIImage alloc] initWithCGImage:cgImage];
    UIImage *newimage = nil;
    
    // If the image is from Photo Library or taken with the camera, and the image
    // is portrait mode, it would be automatically rotated to left, even it displayed
    // correctly. We need rotate it back.
    UIImageOrientation orn = img.imageOrientation;
    if( orn == UIImageOrientationRight || orn == UIImageOrientationLeft || orn == UIImageOrientationDown ||
       (bSetAnnotation && orn == UIImageOrientationUp) )
    {
        CGSize size = CGSizeMake(copyImg.size.height, copyImg.size.width);
        if( orn == UIImageOrientationDown || orn == UIImageOrientationUp )
        {
            size = copyImg.size;
        }
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        if( orn == UIImageOrientationLeft )
        {
            if( bSetAnnotation )
            {
                CGContextTranslateCTM(ctx, size.width, 0);
                CGContextRotateCTM(ctx,  M_PI / 2.0);
                CGContextTranslateCTM(ctx, 0, size.width);
                CGContextScaleCTM(ctx, 1, -1);
            }
            else
            {
                CGContextTranslateCTM(ctx, 0, size.height);
                CGContextRotateCTM(ctx,  M_PI / -2.0);
            }
        }
        if( orn == UIImageOrientationRight )
        {
            if( bSetAnnotation )
            {
                CGContextTranslateCTM(ctx, 0, size.height);
                CGContextRotateCTM(ctx,  M_PI / -2.0);
                CGContextTranslateCTM(ctx, 0, size.width);
                CGContextScaleCTM(ctx, 1, -1);
            }
            else
            {
                CGContextTranslateCTM(ctx, size.width, 0);
                CGContextRotateCTM(ctx,  M_PI / 2.0);
            }
        }
        if( orn == UIImageOrientationDown )
        {
            if( bSetAnnotation )
            {
                CGContextTranslateCTM(ctx, size.width, 0);
                CGContextScaleCTM(ctx, -1, 1);
            }
            else
            {
                CGContextTranslateCTM(ctx, size.width, size.height);
                CGContextRotateCTM(ctx,  M_PI);
            }
        }
        if( bSetAnnotation && orn == UIImageOrientationUp )
        {
            CGContextTranslateCTM(ctx, 0, size.height);
            CGContextScaleCTM(ctx, 1, -1);
        }
        [copyImg drawAtPoint:CGPointMake(0, 0)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        newimage = copyImg;
    }
    
    return newimage;
}

- (NSString *)getDateTimeStringForDate:(BOOL)bDate
{
    NSTimeZone* gmTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* localTimeZone = [NSTimeZone systemTimeZone];
    
    NSDate *dt = [NSDate date];
    NSInteger sourceGMTOffset = [gmTimeZone secondsFromGMTForDate:dt];
    NSInteger destinationGMTOffset = [localTimeZone secondsFromGMTForDate:dt];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:dt];
    
    NSString *txt = [destinationDate description];
    NSArray *arr = [txt componentsSeparatedByString:@" "];
    NSString *date = [arr objectAtIndex:0];
    NSString *time = [arr objectAtIndex:1];
    
    arr = [date componentsSeparatedByString:@"-"];
    date = [NSString stringWithFormat:@"%@/%@/%@", [arr objectAtIndex:1], [arr objectAtIndex:2], [arr objectAtIndex:0]];
    arr = [time componentsSeparatedByString:@":"];
    NSInteger hr = [[arr objectAtIndex:0] integerValue];
    txt = hr < 12 ? @"AM" : @"PM";
    NSInteger tm = hr > 12 ? hr - 12 : hr;
    time = [NSString stringWithFormat:@"%ld:%@:%@ %@", (long)tm, [arr objectAtIndex:1], [arr objectAtIndex:2], txt];
    
    return bDate ? date : time;
}

- (NSString *)getCoverpageImageFor:(NSDictionary *)dic index:(int)index
{
    CGSize size = CGSizeMake(1700, 2200);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    float fsize = 13.0 * 200.0/72.0;
    UIFont *font = [UIFont systemFontOfSize:fsize];
    CGRect rt = CGRectMake(0, 0, size.width, size.height);
    
    CGContextBeginPath(ctx);
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rt);
    UIImage *image = [UIImage imageNamed:@"Sftfax.jpg"];
    image = [self convertion:image setAnnotation:YES];
    CGRect rect = CGRectMake(330, 100, 1040, 156);
    CGContextDrawImage(ctx, rect, image.CGImage);
    UIColor *color = [UIColor colorWithRed:0.2 green:0.7 blue:0.8 alpha:1.0];
    [color set];
    CGContextSetLineWidth(ctx, 4.0);
    CGContextSetLineDash(ctx, 0, nil, 0);
    CGContextAddRect(ctx, CGRectMake(160, 905, 1380, 1205));
    CGContextStrokePath(ctx);
    
    NSString *dateStr = [self getDateTimeStringForDate:YES];
    NSString *timeStr = [self getDateTimeStringForDate:NO];
    NSTimeZone* localTimeZone = [NSTimeZone systemTimeZone];
    NSDate *dtm = [NSDate date];
    NSInteger destinationGMTOffset = [localTimeZone secondsFromGMTForDate:dtm];
    NSString *dateTime = [NSString stringWithFormat:@"%@  %@  (GMT %d:00)", dateStr, timeStr, (int)destinationGMTOffset/3600];
    NSString *txt[10] = {@"To:", @"Address:", @"Company:", @"From:", @"Address:", @"Company:", @"Phone:", @"Date & Time:", @"Subject:", @"Memo:"};
    int my[10] = {300, 355, 410, 495, 550, 605, 660, 745, 800, 855};
    for(int i=0; i<10; i++)
    {
        [[UIColor colorWithRed:0 green:0.7 blue:0.2 alpha:1.0] set];
        CGSize sz = [txt[i] sizeWithFont:font constrainedToSize:rt.size lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = CGRectMake(200, my[i], sz.width, sz.height);
        [txt[i] drawInRect:rect withFont:font];
        
        [[UIColor blackColor] set];
        NSString *str;
        if( i == 0 ) str = [dic objectForKey:KEY_NAME];
        if( i == 1 ) str = [dic objectForKey:KEY_ADDRESS];
        if( i == 2 ) str = [dic objectForKey:KEY_COMPANY];
        if( i == 3 ) str = sSenderName;
        if( i == 4 ) str = sSenderAddr;
        if( i == 5 ) str = sSenderComp;
        if( i == 6 ) str = sSenderPhon;
        if( i == 7 ) str = dateTime;
        if( i == 8 ) str = subjectText;
        if( i == 9 ) str = memoText;
        CGRect rect2 = CGRectMake(200, 925, 1700-400, 1100);
        if( i < 9 )
        {
            CGSize sz2 = [str sizeWithFont:font constrainedToSize:rt.size lineBreakMode:NSLineBreakByWordWrapping];
            rect2 = CGRectMake(450, my[i], sz2.width, sz2.height);
        }
        [str drawInRect:rect2 withFont:font];
    }
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *filename = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Coverpage-%d.tif", index]];
    NSData *imageData = UIImageJPEGRepresentation(newimage, 1.0);
    [imageData writeToFile:filename atomically:YES];
    
    return filename;
}

- (CGRect)getOrigialRect:(NSInteger)index
{
    NSInteger nCol = (scrollView.frame.size.width - 10) / (thumbWidth + 10);
    thumbInterval = (scrollView.frame.size.width - nCol * thumbWidth) / (nCol + 1);
    CGRect rect = CGRectMake(thumbInterval + index % nCol * (thumbWidth + thumbInterval),
                             thumbInterval + index / nCol * (thumbHeight + thumbInterval),
                             thumbWidth, thumbHeight);
    return rect;
}

- (CGRect)getThumbnailRect:(CGSize)size index:(NSInteger)index
{
    CGRect rect = [self getOrigialRect:index];
    CGFloat rx = rect.size.width / size.width;
    CGFloat ry = rect.size.height / size.height;
    CGFloat rr = rx < ry ? rx : ry;
    CGRect rt = rect;
    rt.size.width = size.width * rr;
    rt.size.height = size.height * rr;
    if( ry < rx )
        rt.origin.x += (rect.size.width - rt.size.width) / 2;
    else
        rt.origin.y += (rect.size.height - rt.size.height) / 2;
    
    return rt;
}

- (UIImage *)getThumbnailImage:(UIImage *)image rect:(CGRect)rect mark:(NSInteger)mark name:(NSString *)name
{
    CGRect ct = CGRectMake(0, 0, rect.size.width+2, rect.size.height+2);
    UIGraphicsBeginImageContext(ct.size);
    
    int textHt = [name isEqualToString:@""] ? 0 : 16;
    CGRect rt = CGRectMake(1, 1, rect.size.width, rect.size.height-textHt);
    [image drawInRect:rt];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.8, 1.0);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, rt);
    CGContextStrokePath(ctx);
    
    if( mark > 0 )
    {
        UIFont *font = [UIFont boldSystemFontOfSize:24];
        CGRect ct = CGRectMake(rt.origin.x+20, rt.origin.y+40, 80, 40);
        [[UIColor blueColor] set];
        //        NSString *text = [NSString stringWithFormat:@"#%ld", (long)mark];
        //        [text drawInRect:CGRectIntegral(ct) withFont:font];
        if( ![name isEqualToString:@""] )
        {
            ct = CGRectMake(-15, rt.size.height+2, rt.size.width+30, 15);
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = NSTextAlignmentCenter;
            NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:12],
                                          NSForegroundColorAttributeName: [UIColor blueColor],
                                          NSParagraphStyleAttributeName: style
                                          };
            [name drawInRect:CGRectIntegral(ct) withAttributes:attributes];
        }
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)setAttachmentImages
{
    if( imageView == nil )
        return;
    
    NSInteger count = [ImgCollection count];
   
    bAllImageFiles = YES;
    [AttachImageArray removeAllObjects];
    NSInteger npdf = 0;
    for(NSInteger i=0; i<count; i++)
    {
        NSString *file = [ImgCollection objectAtIndex:i];
        NSRange range = [file rangeOfString:FILE_ATTACHMENT];
        UIImage *image = nil;
        NSString *name = @"";
        NSInteger mark = 0;
        if( range.location != NSNotFound )
        {
            NSArray *array = [file componentsSeparatedByString:@"."];
            NSString *ext = [array lastObject];
            if( ![ext isEqualToString:@"bmp"] && ![ext isEqualToString:@"gif"] &&
                ![ext isEqualToString:@"jpg"] && ![ext isEqualToString:@"png"] &&
                ![ext isEqualToString:@"tif"] && ![ext isEqualToString:@"jpeg"] &&
                ![ext isEqualToString:@"tiff"] )
            {
                bAllImageFiles = NO;
            }
            image = [UIImage imageWithContentsOfFile:[self getFilePath:ext]];
            NSArray *arr = [file componentsSeparatedByString:@"/"];
            NSString *filename = [arr lastObject];
            arr = [filename componentsSeparatedByString:@"-$"];
            if( [arr count] > 1 )
                name = [arr lastObject];
            npdf += 1;
            mark = npdf;
        }
        else
        {
            image = [UIImage imageWithContentsOfFile:file];
            if( image == nil )
            {
                NSArray *array = [file componentsSeparatedByString:@"/"];
                NSString *subStr = [array objectAtIndex:[array count]-1];
                NSRange range = [subStr rangeOfString:@"Coverpage-"];
                if( range.location == 0 && coverPageSwitch.on )
                {
                    [ImgCollection removeObjectAtIndex:0];
                    [self addCoverpageForAttachment];
                }
            }
        }
        
        if( image != nil )
        {
            AttachRect[i] = [self getThumbnailRect:image.size index:i];
            [AttachImageArray addObject:[self getThumbnailImage:image rect:AttachRect[i] mark:mark name:name]];
        }
    }
    
    NSInteger index = count-1;
    CGRect rect = [self getOrigialRect:index];
    CGSize size = scrollView.frame.size;
    size.height = rect.origin.y + rect.size.height + 30;
    if( size.height < nAttachmentWindowHeight )
        size.height = nAttachmentWindowHeight;

    UIGraphicsBeginImageContext(size);
    count = [AttachImageArray count];
    CGRect lastRect;
    for(NSInteger i=0; i<count; i++)
    {
        UIImage *image = [AttachImageArray objectAtIndex:i];
        CGRect rt = AttachRect[i];
        [image drawAtPoint:rt.origin];
        lastRect = rt;
        
        if( i == nDeleteOne )
        {
            [[UIColor colorWithWhite:0.5 alpha:0.1] setFill];
            UIRectFill(rt);
        }
    }
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    scrollView.contentSize = size;
    labelAttachments.text = @"";

    if( count > 0 )
    {
        lastRect.origin.y += 10;
        [scrollView scrollRectToVisible:lastRect animated:YES];
    }
}

- (NSString *)getFilePath:(NSString *)ext
{
    NSString *filePath = @"";
    if( [ext isEqualToString:@"pdf"] )
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"PDFIcon" ofType:@"png"];
    }
    else if( [ext isEqualToString:@"doc"] || [ext isEqualToString:@"docx"] )
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"WordIcon" ofType:@"png"];
    }
    else if( [ext isEqualToString:@"ppt"] || [ext isEqualToString:@"pptx"] )
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"PowerPointIcon" ofType:@"png"];
    }
    else if( [ext isEqualToString:@"xls"] || [ext isEqualToString:@"xlsx"] )
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"ExcelIcon" ofType:@"png"];
    }
    else if( [ext isEqualToString:@"bmp"] || [ext isEqualToString:@"gif"] ||
             [ext isEqualToString:@"jpg"] || [ext isEqualToString:@"png"] ||
             [ext isEqualToString:@"tif"] || [ext isEqualToString:@"jpeg"] ||
             [ext isEqualToString:@"tiff"] )
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"ImageIcon" ofType:@"png"];
    }
    else
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"TextIcon" ofType:@"png"];
    }

    return filePath;
}

- (void)handleLongPress:(UITapGestureRecognizer *)recognizer
{
    static CGPoint StartPoint;
    
    CGPoint point = [recognizer locationInView:scrollView];
    if( recognizer.state == UIGestureRecognizerStateBegan )
    {
        [self selectAttachment:point];
        StartPoint = point;
    }
    else
        if( recognizer.state == UIGestureRecognizerStateChanged )
        {
            CGSize size = CGSizeMake(point.x - StartPoint.x, point.y - StartPoint.y);
            [self moveAttachment:size];
            StartPoint = point;
        }
        else
            if( recognizer.state == UIGestureRecognizerStateEnded )
            {
                [self endMoveAttachment];
            }
}

- (void)selectAttachment:(CGPoint)point
{
    nSelectedPage = -1;
    NSInteger count = [ImgCollection count];
    for(NSInteger i=0; i<count; i++)
    {
        CGRect rect = AttachRect[i];
        if( CGRectContainsPoint(rect, point) )
        {
            nSelectedPage = i;
        }
    }
}

CGRect orgRect[MAX_PAGE_COUNT];
CGRect dstRect[MAX_PAGE_COUNT];
NSInteger oldIndex[MAX_PAGE_COUNT];
NSTimer *MovingTimer;
NSInteger nMovingTime = 0;
NSInteger strt, end;
bool bMovingPage = false;
- (void)endMoveAttachment
{
    if( nMoveToPage < 0 || bMovingPage )
        return;
    
    NSInteger count = [ImgCollection count];
    if( count > MAX_PAGE_COUNT )
        count = MAX_PAGE_COUNT;
    for(NSInteger i=0; i<count; i++)
    {
        orgRect[i] = AttachRect[i];
        dstRect[i] = AttachRect[i];
        oldIndex[i] = i;
    }
    
    if( nMoveToPage > nSelectedPage )
        nMoveToPage -= 1;
    
    if( nMoveToPage >= 0 )
    {
        if( nSelectedPage < nMoveToPage )
        {
            strt = nSelectedPage;
            end = nMoveToPage;
            for(NSInteger i=strt; i<end; i++)
            {
                oldIndex[i] = i+1;
            }
            oldIndex[end] = strt;
        }
        else
        {
            strt = nMoveToPage;
            end = nSelectedPage;
            for(NSInteger i=strt+1; i<=end; i++)
            {
                oldIndex[i] = i-1;
            }
            oldIndex[strt] = end;
        }
    }
    else
    {
        strt = end = nSelectedPage;
    }
    
    if( nMoveToPage >= 0 )
    {
        UIImage *image = [AttachImageArray objectAtIndex:nSelectedPage];
        //Because the image will be released when it is removed from the array,
        //we need make a copy before remove and insert.
        UIImage *copyImage = [UIImage imageWithCGImage:[image CGImage]];
        [AttachImageArray removeObjectAtIndex:nSelectedPage];
        [AttachImageArray insertObject:copyImage atIndex:nMoveToPage];
        
        NSString *filename = [ImgCollection objectAtIndex:nSelectedPage];
        NSString *copyFilename = [NSString stringWithString:filename];
        [ImgCollection removeObjectAtIndex:nSelectedPage];
        [ImgCollection insertObject:copyFilename atIndex:nMoveToPage];
    }
    
    for(NSInteger i=strt; i<=end; i++)
    {
        UIImage *image = [AttachImageArray objectAtIndex:i];
        dstRect[i] = [self getThumbnailRect:image.size index:i];
    }
    
    nMovingTime = 0;
    MovingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                   target:self
                                                 selector:@selector(autoMoveProc)
                                                 userInfo:nil
                                                  repeats:YES];
    
    nMoveToPage = -1;
    bMovingPage = true;
}

- (void)autoMoveProc
{
    static NSInteger times = 40;
    
    double x = (double)nMovingTime / times;
    double f = sqrt(1.0 - (x-1.0)*(x-1.0));
    for(NSInteger i=strt; i<=end; i++)
    {
        NSInteger k = oldIndex[i];
        CGRect rt = orgRect[k];
        rt.origin.x += (dstRect[i].origin.x - orgRect[k].origin.x) * f;
        rt.origin.y += (dstRect[i].origin.y - orgRect[k].origin.y) * f;
        AttachRect[i] = rt;
    }
    
    NSInteger count = [ImgCollection count];
    if( count > MAX_PAGE_COUNT )
        count = MAX_PAGE_COUNT;
    [self paintImages:count];
    
    nMovingTime += 1;
    if( nMovingTime >= times )
    {
        [MovingTimer invalidate];
        bMovingPage = false;
    }
}

CGPoint MovePagePos;
- (void)moveAttachment:(CGSize)sz
{
    if( nSelectedPage < 0 || bMovingPage )
        return;
    
    if( nSelectedPage == 0 && coverPageSwitch.on )
        return;
    
    NSInteger count = [ImgCollection count];
    if( count > MAX_PAGE_COUNT )
        count = MAX_PAGE_COUNT;
    
    CGSize size = scrollView.frame.size;
    NSInteger nx = size.width / (thumbWidth+thumbInterval);
    NSInteger ny = count / nx;
    NSInteger wd = thumbInterval + thumbWidth;
    NSInteger ht = thumbInterval + thumbHeight;
    
    CGPoint movePoint = AttachRect[nSelectedPage].origin;
    movePoint.x += sz.width;
    movePoint.y += sz.height;
    CGPoint pt = CGPointMake(movePoint.x + thumbWidth / 2,
                             movePoint.y + thumbHeight / 2);
    nMoveToPage = nSelectedPage;
    CGPoint scrollPoint = scrollView.contentOffset;
    
    NSInteger frameBottom = movePoint.y + AttachRect[nSelectedPage].size.height;
    NSInteger off = 5;
    if( sz.height < 0 && movePoint.y < scrollPoint.y )
    {
        scrollPoint.y -= off;
        if( scrollPoint.y < 0 )
        {
            AttachRect[nSelectedPage].origin.y = 0;
            scrollPoint.y = 0;
        }
        else
        {
            AttachRect[nSelectedPage].origin.y -= off;
        }
        [self paintImages:count];
        [scrollView setContentOffset:scrollPoint];
    }
    else if( sz.height > 0 && frameBottom > size.height + scrollPoint.y )
    {
        scrollPoint.y += off;
        int hgt = scrollView.contentSize.height - size.height;
        if( scrollPoint.y > hgt )
        {
            AttachRect[nSelectedPage].origin.y = scrollView.contentSize.height - AttachRect[nSelectedPage].size.height;
            scrollPoint.y = hgt;
        }
        else
        {
            AttachRect[nSelectedPage].origin.y += off;
        }
        [self paintImages:count];
        [scrollView setContentOffset:scrollPoint];
    }
    else
    {
        AttachRect[nSelectedPage].origin = movePoint;
        for(NSInteger py=0; py<=ny; py++)
        {
            int y = (int)(ht * (py - 0.2));
            for(NSInteger px=0; px<=nx; px++)
            {
                int x = (int)(wd * (px - 0.5));
                CGRect rt = CGRectMake(x, y, wd, ht);
                if( CGRectContainsPoint(rt, pt) )
                {
                    nMoveToPage = px + nx * py;
                    MovePagePos = CGPointMake(px, py);
                    break;
                }
            }
            if( nMoveToPage > count )
            {
                MovePagePos.x = count % nx;
                nMoveToPage = count;
            }
            [self paintImages:count];
        }
    }
}

- (void)paintImages:(NSInteger)count
{
    if( coverPageSwitch.on && nMoveToPage == 0 )
    {
        nMoveToPage = nSelectedPage;
        return;
    }
    
    CGSize size = scrollView.contentSize;
    UIGraphicsBeginImageContext(size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGRect rt = CGRectMake(0, 0, size.width, size.height);
    CGContextFillRect(ctx, rt);
    
    for(NSInteger i=0; i<count; i++)
    {
        if( i != nSelectedPage )
        {
            UIImage *image = [AttachImageArray objectAtIndex:i];
            [image drawInRect:AttachRect[i]];
        }
    }
    UIImage *image = [AttachImageArray objectAtIndex:nSelectedPage];
    [image drawInRect:AttachRect[nSelectedPage]];
    
    if( nMoveToPage >= 0 && nMoveToPage != nSelectedPage && nMoveToPage != nSelectedPage+1 )
    {
        CGContextSetRGBStrokeColor(ctx, 0.95, 0.8, 0.1, 1.0);
        CGContextSetLineWidth(ctx, 3.0);
        NSInteger x = thumbInterval/2 + (thumbInterval+thumbWidth) * MovePagePos.x;
        NSInteger y = thumbInterval + (thumbInterval+thumbHeight) * MovePagePos.y;
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddLineToPoint(ctx, x, y+thumbHeight);
        CGContextMoveToPoint(ctx, x-5, y-5);
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddLineToPoint(ctx, x+5, y-5);
        y += thumbHeight;
        CGContextMoveToPoint(ctx, x-5, y+5);
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddLineToPoint(ctx, x+5, y+5);
        CGContextStrokePath(ctx);
    }
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

- (void)menuForAttachment:(UITapGestureRecognizer *)recognizer
{
    if( recognizer.state != UIGestureRecognizerStateEnded )
        return;
    
    CGPoint point = [recognizer locationInView:scrollView];
    [self selectAttachment:point];
    if( nSelectedPage < 0 )
        return;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Menu"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* preview = [UIAlertAction actionWithTitle:@"Preview"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [self previewAttachment];
                               }];
    [alert addAction:preview];
    
    if( nSelectedPage > 0 || !coverPageSwitch.on )
    {
        UIAlertAction* delete = [UIAlertAction actionWithTitle:@"Delete"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action)
                                  {
                                      [self deleteAttachment];
                                  }];
        [alert addAction:delete];

        NSString *file = [ImgCollection objectAtIndex:nSelectedPage];
        NSRange range = [file rangeOfString:FILE_ATTACHMENT];
        if( range.location == NSNotFound )
        {
            UIAlertAction* convert = [UIAlertAction actionWithTitle:@"Convert image to BW"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action)
                                      {
                                          [self showSpinner];
                                          [self performSelector:@selector(convert2BW) withObject:nil afterDelay:0.2];
                                      }];
            [alert addAction:convert];
        }
    }

    if( nDeviceType == DEVICE_IPHONE )
    {
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action)
                                 {
                                 }];
        [alert addAction:cancel];

    }
    alert.popoverPresentationController.sourceView = scrollView;
    alert.popoverPresentationController.sourceRect = AttachRect[nSelectedPage];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)previewAttachment
{
    if( nSelectedPage < 0 )
        return;
    
    webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;

    if( nSelectedPage == 0 && coverPageSwitch.on )
    {
        [self updateCoverpage];
    }
    NSString *file = [ImgCollection objectAtIndex:nSelectedPage];
    NSRange range = [file rangeOfString:FILE_ATTACHMENT];
    if( range.location == NSNotFound )
    {
        //To make it fit the page, we have to use following HTML string, scalesPageToFit is not enough.
        NSString *photoWrapper = [NSString stringWithFormat:@"\
                                  <html>\n\
                                  <head>\n\
                                  <meta name=\"viewport\" content=\"width=device-width\" />\n\
                                  <style type=\"text/css\">\n\
                                  body {\n\
                                  margin: 0;\n\
                                  padding: 0;\n\
                                  }\n\
                                  img {\n\
                                  width: 100%%;\n\
                                  }\n\
                                  </style>\n\
                                  </head>\n\
                                  <body>\n\
                                  <img src=\"%@\" />\n\
                                  </body>\n\
                                  </html>\
                                  ", [NSURL fileURLWithPath:file]];
        [webView loadHTMLString:photoWrapper baseURL:nil];
    }
    else
    {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:file]]];
    }
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGRect rect = self.navigationController.navigationBar.frame;
    int y = rect.origin.y + rect.size.height;
    webView.frame = CGRectMake(-screenSize.width, y, screenSize.width, screenSize.height-y);
    webView.gapBetweenPages = 30;
    [self.tabBarController.view addSubview:webView];
    
    savedLeftButton = self.navigationItem.leftBarButtonItem;
    savedRightButton = self.navigationItem.rightBarButtonItem;
    savedTitle = self.navigationItem.title;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    {
        CGRect rt = webView.frame;
        rt.origin.x = 0;
        webView.frame = rt;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
        self.navigationItem.title = @"Preview";
    }
    [UIView commitAnimations];
}

- (void)clickBack
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    {
        CGRect rt = webView.frame;
        rt.origin.x = -rt.size.width;
        webView.frame = rt;
        self.navigationItem.leftBarButtonItem = savedLeftButton;
        self.navigationItem.rightBarButtonItem = savedRightButton;
        self.navigationItem.title = savedTitle;
    }
    [UIView commitAnimations];
    webView = nil;
}

- (void)updateCoverpage
{
    if( [ImgCollection count] > 0 )
    {
        NSString *file = [ImgCollection objectAtIndex:0];
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
        [ImgCollection removeObjectAtIndex:0];
    }
    [self addCoverpageForAttachment];
    [self setAttachmentImages];
}

- (void)deleteAttachment
{
    if( nSelectedPage >= 0 )
    {
        NSString *file = [ImgCollection objectAtIndex:nSelectedPage];
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
        [ImgCollection removeObjectAtIndex:nSelectedPage];
        [self setAttachmentImages];
    }
}

- (void)convert2BW
{
    if( nSelectedPage >= 0 )
    {
        NSString *file = [ImgCollection objectAtIndex:nSelectedPage];
        UIImage *image = [UIImage imageWithContentsOfFile: file];
        UIImage *newImage = [self doConvert2BW:image sensitivity:(int)nSensitivity];
        if( newImage )
        {
            [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
            [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:file atomically:NO];
            [self setAttachmentImages];
        }
        [self hideSpinner];
    }
}

- (UIImage *)doConvert2BW:(UIImage *)image sensitivity:(int)sens
{
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, 0);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    void *data = CGBitmapContextGetData( context );
    if( data == NULL )
    {
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        return nil;
    }
    
    NSInteger bytesPerRow = CGBitmapContextGetBytesPerRow( context );
    NSInteger height = CGBitmapContextGetHeight( context );
    NSInteger len = bytesPerRow * height;
    unsigned char *outbytes = malloc(len);
    memset(outbytes, 255, len);
    dynthresh(data, outbytes, (int)bytesPerRow, (int)height, PHOTOMETRIC_MINISBLACK, 0, sens, 4, 4, '*');
    memcpy(data, outbytes, len);
    free(outbytes);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    return newImage;
}

extern DBOAuthResult *authResult;
- (void)onDropbox
{
    if( authResult != nil && [authResult isSuccess] )
    {
        [self setDropboxWindow:nil];
    }
    else
    {
        [DBClientsManager authorizeFromController:[UIApplication sharedApplication]
                                       controller:self
                                          openURL:^(NSURL *url) {
                                              [[UIApplication sharedApplication] openURL:url];
                                          }];
    }
}

NSString *dropboxTitle = @"";
- (void)setDropboxWindow:(DBFILESMetadata *)data
{
    DBUserClient *client = [DBClientsManager authorizedClient];
    NSString *searchPath = @"";
    if( data != nil )
    {
        searchPath = data.pathLower;
        dropboxTitle = data.name;
    }
    
    // list folder metadata contents (folder will be root "/" Dropbox folder if app has permission
    // "Full Dropbox" or "/Apps/<APP_NAME>/" if app has permission "App Folder").
    [[client.filesRoutes listFolder:searchPath]
     setResponseBlock:^(DBFILESListFolderResult *result, DBFILESListFolderError *routeError, DBRequestError *error)
     {
         if (result)
         {
             NSArray *ar1 = [NSArray arrayWithArray:result.entries];
             NSArray *array = [ar1 sortedArrayUsingComparator: ^(DBFILESMetadata *obj1, DBFILESMetadata *obj2)
                               {
                                   NSString *str1 = obj1.name;
                                   NSString *str2 = obj2.name;
                                   return [str1 caseInsensitiveCompare:str2];
                               }];
             if( [searchPath isEqualToString:@""] )
                 [self procFunc:array];
             else
                 [self procFunc2:array];
         }
         else
         {
             NSString *title = @"";
             NSString *message = @"";
             if (routeError)
             {
                 // Route-specific request error
                 title = @"Route-specific error";
                 if ([routeError isPath]) {
                     message = [NSString stringWithFormat:@"Invalid path: %@", routeError.path];
                 }
             }
             else
             {
                 // Generic request error
                 title = @"Generic request error";
                 if ([error isInternalServerError]) {
                     DBRequestInternalServerError *internalServerError = [error asInternalServerError];
                     message = [NSString stringWithFormat:@"%@", internalServerError];
                 } else if ([error isBadInputError]) {
                     DBRequestBadInputError *badInputError = [error asBadInputError];
                     message = [NSString stringWithFormat:@"%@", badInputError];
                 } else if ([error isAuthError]) {
                     DBRequestAuthError *authError = [error asAuthError];
                     message = [NSString stringWithFormat:@"%@", authError];
                 } else if ([error isRateLimitError]) {
                     DBRequestRateLimitError *rateLimitError = [error asRateLimitError];
                     message = [NSString stringWithFormat:@"%@", rateLimitError];
                 } else if ([error isHttpError]) {
                     DBRequestHttpError *genericHttpError = [error asHttpError];
                     message = [NSString stringWithFormat:@"%@", genericHttpError];
                 } else if ([error isClientError]) {
                     DBRequestClientError *genericLocalError = [error asClientError];
                     message = [NSString stringWithFormat:@"%@", genericLocalError];
                 }
             }
             
             UIAlertController *alertController =
             [UIAlertController alertControllerWithTitle:title
                                                 message:message
                                          preferredStyle:(UIAlertControllerStyle)UIAlertControllerStyleAlert];
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                 style:(UIAlertActionStyle)UIAlertActionStyleCancel
                                                               handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }];
}

- (void)downloadProc:(NSString *)imagePath
{
    [self showSpinner];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self downloadImage:imagePath];
    });
}

- (void)downloadImage:(NSString *)imagePath
{
    DBUserClient *client = [DBClientsManager authorizedClient];
    [[client.filesRoutes downloadData:imagePath]
     setResponseBlock:^(DBFILESFileMetadata *result, DBFILESDownloadError *routeError, DBRequestError *error, NSData *fileData)
     {
         if (result)
         {
             NSArray *arr = [imagePath componentsSeparatedByString:@"/"];
             NSString *fname = [[arr lastObject] lowercaseString];
             NSString *theFilePath = [viewerPage getFilePathWithFilename:fname];
             [fileData writeToFile:theFilePath atomically:YES];
             [viewerPage loadAttachFile:theFilePath];
         }
         else
         {
             NSString *title = @"";
             NSString *message = @"";
             if (routeError) {
                 // Route-specific request error
                 title = @"Route-specific error";
                 if ([routeError isPath]) {
                     message = [NSString stringWithFormat:@"Invalid path: %@", routeError.path];
                 } else if ([routeError isOther]) {
                     message = [NSString stringWithFormat:@"Unknown error: %@", routeError];
                 }
             } else {
                 // Generic request error
                 title = @"Generic request error";
                 if ([error isInternalServerError]) {
                     DBRequestInternalServerError *internalServerError = [error asInternalServerError];
                     message = [NSString stringWithFormat:@"%@", internalServerError];
                 } else if ([error isBadInputError]) {
                     DBRequestBadInputError *badInputError = [error asBadInputError];
                     message = [NSString stringWithFormat:@"%@", badInputError];
                 } else if ([error isAuthError]) {
                     DBRequestAuthError *authError = [error asAuthError];
                     message = [NSString stringWithFormat:@"%@", authError];
                 } else if ([error isRateLimitError]) {
                     DBRequestRateLimitError *rateLimitError = [error asRateLimitError];
                     message = [NSString stringWithFormat:@"%@", rateLimitError];
                 } else if ([error isHttpError]) {
                     DBRequestHttpError *genericHttpError = [error asHttpError];
                     message = [NSString stringWithFormat:@"%@", genericHttpError];
                 } else if ([error isClientError]) {
                     DBRequestClientError *genericLocalError = [error asClientError];
                     message = [NSString stringWithFormat:@"%@", genericLocalError];
                 }
             }
             
             UIAlertController *alertController =
             [UIAlertController alertControllerWithTitle:title
                                                 message:message
                                          preferredStyle:(UIAlertControllerStyle)UIAlertControllerStyleAlert];
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                 style:(UIAlertActionStyle)UIAlertActionStyleCancel
                                                               handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }
         [self hideSpinner];
     }];
}

dropboxController *dropboxVC = nil;
UINavigationController *naviController = nil;
UIBarButtonItem *cancel = nil;
- (void)procFunc:(NSArray<DBFILESMetadata *> *)folderEntries;
{
    dropboxVC = [[dropboxController alloc] initWithStyle:UITableViewStyleGrouped];
    dropboxVC.preferredContentSize = CGSizeMake(320, 525);
    dropboxVC.folderEntries = folderEntries;
    cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onDropboxCancel)];
    naviController = [[UINavigationController alloc] init];
    naviController.viewControllers = [NSArray arrayWithObject:dropboxVC];
    naviController.navigationBar.topItem.title = @"Dropbox";
    naviController.navigationBar.topItem.rightBarButtonItem = cancel;
    naviController.delegate = self;
    naviController.modalPresentationStyle = UIModalPresentationPopover;
    naviController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    naviController.popoverPresentationController.sourceView = self.navigationController.navigationBar;
    naviController.popoverPresentationController.sourceRect = CGRectMake(10, 30, 80, 20);
    [self presentViewController:naviController animated:YES completion:nil];
}

- (void)procFunc2:(NSArray<DBFILESMetadata *> *)folderEntries;
{
    dropboxController *dVC = [[dropboxController alloc] initWithStyle:UITableViewStyleGrouped];
    dVC.preferredContentSize = CGSizeMake(320, 525);
    dVC.title = dropboxTitle;
    dVC.navigationItem.rightBarButtonItem = cancel;
    dVC.folderEntries = folderEntries;
    [naviController pushViewController:dVC animated:YES];
}

- (void)onDropboxCancel
{
    [dropboxVC dismissViewControllerAnimated:YES completion:nil];
    dropboxVC = nil;
    naviController = nil;
    cancel = nil;
}

- (IBAction)OnReset:(id)sender
{
    if( ![recipient.text isEqualToString:@""] || ![memo.text isEqualToString:@""] || ![subject.text isEqualToString:@""] || [ImgCollection count] != 0 )
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle: @"Reset"
                                                                        message: @"Do you want to reset Send Fax screen?"
                                                                 preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [self cleanSendFaxPage];
                             }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)OnSend:(id)sender
{
    if( [recipient.text isEqualToString:@""] )
    {
        [viewerPage ShowAlertTitle:@"Warning" message:@"Please enter recipients."];
        return;
    }
    
    if( [ImgCollection count] == 0 && [memo.text isEqualToString:@""] )
    {
        [viewerPage ShowAlertTitle:@"Warning" message:@"Please input the message and/or attachments."];
        return;
    }
    
    NSArray *arr = [recipient.text componentsSeparatedByString:@","];
    int num = 0;
    for(int i=0; i<recipient.text.length; i++)
    {
        if( [recipient.text characterAtIndex:i] == ',' )
        {
            num += 1;
        }
    }
    if( num < [arr count] )
    {
        NSString *item = [arr lastObject];
        item = [item stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if( ![item isEqualToString:@""] )
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"",     KEY_NAME,
                                 item,    KEY_ADDRESS,
                                 @"",     KEY_COMPANY,
                                 nil];
            if( [self addRecipient:dic] )
            {
                NSString *ss = [recipient.text stringByAppendingString:@", "];
                recipient.text = ss;
            }
        }
    }
    NSDictionary* properties = [NSDictionary dictionaryWithObjectsAndKeys:
                                subject.text,       @"Subject",
                                memo.text,          @"Memo",
                                recipients,         @"Recipients",
                                ImgCollection,      @"Attachments",
                                sSenderName,        @"SenderName",
                                sSenderAddr,        @"SenderAddr",
                                sSenderComp,        @"SenderComp",
                                sSenderPhon,        @"SenderPhon",
                                [NSNumber numberWithBool:coverPageSwitch.on], @"CoverPageOn",
                                [NSNumber numberWithInt:(int)[ImgCollection count]], @"CountOfPages",
                                nil];
    NSString *tmStr = [viewerPage GetTimeStringFrom:[NSDate date] forFileName:YES];
    NSDictionary *dic = [recipients objectAtIndex:0];
    NSString *recipientName = [dic objectForKey:KEY_NAME];
    NSString *strstr = @"";
    if( [recipients count] == 1 )
    {
        strstr = [NSString stringWithFormat:@"%@ to %@", tmStr, recipientName];
    }
    else
    {
        strstr = [NSString stringWithFormat:@"%@ to %@ and more", tmStr, recipientName];
    }
    NSString *fname = [strOutBox stringByAppendingPathComponent:strstr];
    if( [properties writeToFile:fname atomically:YES] )
    {
        [self showSpinner];
        [self performSelector:@selector(tryToSendFax:) withObject:fname afterDelay:0.1];
    }
    else
    {
        [viewerPage ShowAlertTitle:@"Failed" message:@"Failed to add the fax to the outbox."];
    }
}

- (BOOL)tryToSendFax:(NSString *)fname
{
    if( ![wsm canAccess] )
    {
        return NO;
    }
    
    if( ![wsm login:YES] )
    {
        return NO;
    }
    
    [recipientArray removeAllObjects];
    [attachmentArray removeAllObjects];
    [JobQueue removeAllObjects];
    
    NSDictionary* properties = [NSDictionary dictionaryWithContentsOfFile:fname];
    subjectText = [properties valueForKey:@"Subject"];
    memoText = [properties valueForKey:@"Memo"];
    bCoverPageOn = [[properties valueForKey:@"CoverPageOn"] boolValue];
    [recipientArray addObjectsFromArray:[properties valueForKey:@"Recipients"]];
    [attachmentArray addObjectsFromArray:[properties valueForKey:@"Attachments"]];
    sSenderName = [properties valueForKey:@"SenderName"];
    sSenderAddr = [properties valueForKey:@"SenderAddr"];
    sSenderComp = [properties valueForKey:@"SenderComp"];
    sSenderPhon = [properties valueForKey:@"SenderPhon"];
    [[NSFileManager defaultManager] removeItemAtPath:fname error:nil];
    
    NSMutableArray *emailRecps = [[NSMutableArray alloc] init];
    NSMutableArray *faxRecps = [[NSMutableArray alloc] init];
    NSMutableArray *ipfaxRecps = [[NSMutableArray alloc] init];
    NSInteger nRecipients = [recipientArray count];
    for(int i=0; i<nRecipients; i++)
    {
        NSDictionary *dic = [recipientArray objectAtIndex:i];
        NSString *address = [dic objectForKey:KEY_ADDRESS];
        if( [self isFaxNumber:address] )
        {
            NSMutableString *str = [NSMutableString new];
            [str setString:@""];
            for(int i=0; i<address.length; i++)
            {
                char t = [address characterAtIndex:i];
                if( t != ' ' && t != '\xa0' && t != '(' && t != ')' && t != '-' )
                {
                    [str appendString:[NSString stringWithFormat:@"%c", t]];
                }
            }
            address = str;
            if( nWebService == WEB_SERVICE_ANYWHER )
            {
                [dic setValue:address forKey:KEY_ADDRESS];
                [faxRecps addObject:dic];
            }
            if( nWebService == WEB_SERVICE_SFT )
            {
                address = [address stringByAppendingString:@"@faxcomanywhere.com"];
                [dic setValue:address forKey:KEY_ADDRESS];
                [ipfaxRecps addObject:dic];
            }
        }
        else if( [self isEmailAddres:address] )
        {
            if( nWebService == WEB_SERVICE_SFT && bAllImageFiles )
                [ipfaxRecps addObject:dic];
            else
                [emailRecps addObject:dic];
        }
        else
        {
            [ipfaxRecps addObject:dic];
        }
    }
    
    if( nWebService == WEB_SERVICE_SFT && [faxRecps count] > 0 )
    {
        if( bAllImageFiles )
            [ipfaxRecps addObjectsFromArray:faxRecps];
        else
            [emailRecps addObjectsFromArray:faxRecps];
        [faxRecps removeAllObjects];
    }
    
    int nFailed = 0;
    if( [faxRecps count] > 0 )
    {
        NSString *file = @"";
        if( bCoverPageOn )
        {
            file = [attachmentArray objectAtIndex:0];
            [attachmentArray removeObjectAtIndex:0];
        }
        if( ![wsm sendFax:faxRecps pack:properties index:-1] )
        {
            NSDictionary *dic = [faxRecps objectAtIndex:0];
            NSString *address = [dic objectForKey:KEY_ADDRESS];
            NSString *msg = [NSString stringWithFormat: @"Failed to send a fax to %@", address];
            [viewerPage writeLog:msg];
            nFailed += [faxRecps count];
        }
        if( bCoverPageOn )
        {
            [attachmentArray insertObject:file atIndex:0];
        }
    }
    
    NSString *dateStr = [self getDateTimeStringForDate:YES];
    NSString *timeStr = [self getDateTimeStringForDate:NO];
    int numAttachments = (int)[attachmentArray count];
    for(int i=0; i<[ipfaxRecps count]; i++)
    {
        if( bCoverPageOn )
        {
            NSString *sf = [self getCoverpageImageFor:[ipfaxRecps objectAtIndex:i] index:i+1];
            [attachmentArray replaceObjectAtIndex:0 withObject:sf];
        }
        for(int k=0; k<numAttachments; k++)
        {
            if( i != 0 && !(k == 0 && bCoverPageOn) )
                continue;
            
            @autoreleasepool
            {
                NSString *file = [attachmentArray objectAtIndex:k];
                UIImage *img = [UIImage imageWithContentsOfFile:file];
                float fsize = img.size.width / 140.0 * 200.0/72.0;
                CGSize size = img.size;
                CGPoint imgPt = CGPointZero;
                
                UIGraphicsBeginImageContext(size);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [img drawAtPoint:imgPt];
                CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
                CGRect rt = CGRectMake(0, 0, img.size.width, fsize+5);
                CGContextFillRect(ctx, rt);
                CGContextStrokePath(ctx);
                UIColor *color = [UIColor blackColor];
                [color set];
                NSString *text[3];
                text[0] = [NSString stringWithFormat:@"%@  %@", dateStr, timeStr];
                text[1] = MAIN_TITLE;
                text[2] = [NSString stringWithFormat:@"PAGE %d OF %d", k+1, numAttachments];
                CGRect rect = CGRectMake(20, 0, img.size.width-40, fsize+5);
                for(int j=0; j<3; j++)
                {
                    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                    style.lineBreakMode = NSLineBreakByTruncatingTail;
                    style.alignment = j==0 ? NSTextAlignmentLeft : (j==1 ? NSTextAlignmentCenter : NSTextAlignmentRight);
                    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:fsize],
                                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                                  NSParagraphStyleAttributeName: style
                                                  };
                    [text[j] drawInRect:rect withAttributes:attributes];
                }
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                NSData *imageData = UIImageJPEGRepresentation (image, 0.8);
                [imageData writeToFile:file atomically:YES];
            }
        }
        
        if( nWebService == WEB_SERVICE_SFT )
        {
            NSString *filename = [self saveAttachmentFile:i isPDF:YES];
            if( ![filename isEqualToString:@""] )
            {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:properties];
                [dict removeObjectForKey:@"Attachments"];
                NSMutableArray *arr = [NSMutableArray arrayWithObject:filename];
                [dict setObject:arr forKey:@"Attachments"];
                NSArray *recp = [NSArray arrayWithObject:[ipfaxRecps objectAtIndex:i]];
                NSDictionary *dta = [NSDictionary dictionaryWithObjectsAndKeys:
                                     recp,      @"Recipient",
                                     dict,      @"faxPackage",
                                     nil];
                [JobQueue addObject:dta];
            }
            else
            {
                [viewerPage ShowAlertTitle:@"Cannot send the fax" message:@"Failed to create the tif file."];
                [self hideSpinner];
                [recipientArray removeAllObjects];
                [attachmentArray removeAllObjects];
                return NO;
            }
        }
        else
        {
            if( ![wsm sendFax:ipfaxRecps pack:properties index:i] )
            {
                NSDictionary *dic = [ipfaxRecps objectAtIndex:i];
                NSString *address = [dic objectForKey:KEY_ADDRESS];
                NSString *msg = [NSString stringWithFormat: @"Failed to send an ipfax to %@", address];
                [viewerPage writeLog:msg];
                nFailed += 1;
            }
        }
    }
    
    if( [emailRecps count] > 0 )
    {
        if( nWebService == WEB_SERVICE_SFT )
        {
            if( bCoverPageOn )
            {
                NSString *file = [attachmentArray objectAtIndex:0];
                [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
                [attachmentArray removeObjectAtIndex:0];
                [properties setValue:attachmentArray forKey:@"Attachments"];
            }
            if( ![wsm sendFax:emailRecps pack:properties index:-1] )
            {
                NSString *msg = [NSString stringWithFormat: @"Failed to send a fax"];
                [viewerPage writeLog:msg];
            }
        }
        else
        {
            if( NO )
            {
                [self displayComposerSheet:emailRecps];
            }
            else
            {
                [viewerPage ShowAlertTitle:@"Error" message:@"Cannot send email with the current server."];
            }
        }
        [self hideSpinner];
        [recipientArray removeAllObjects];
        [attachmentArray removeAllObjects];
        [self cleanSendFaxPage];
        return YES;
    }
    
    if( nWebService == WEB_SERVICE_SFT )
    {
        bSendSftfax = NO;
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(sendSftFaxProc:)
                                       userInfo:nil
                                        repeats:YES];
    }
    else
    {
        nRecipients = [faxRecps count] + [ipfaxRecps count];
        if( nRecipients > 0 )
        {
            NSString *msg = @"";
            if( nFailed == 0 )
            {
                msg = @"Successfully submit the fax.";
            }
            else
                if( nFailed == nRecipients )
                {
                    msg = @"Failed to submit the fax.";
                }
                else
                {
                    msg = [NSString stringWithFormat: @"Successfully submit the fax to %d recipient(s).\nFailed to submit to %d recipient(s).", (int)(nRecipients-nFailed), nFailed];
                }
            [viewerPage ShowAlertTitle:@"End of sending fax" message:msg];
        }
    }
    
    [viewerPage removeFilesfromArray:attachmentArray];
    [self hideSpinner];
    [recipientArray removeAllObjects];
    [attachmentArray removeAllObjects];
    if( nWebService != WEB_SERVICE_SFT )
        [self cleanSendFaxPage];
    
    return YES;
}

- (NSString *)saveAttachmentFile:(int)index isPDF:(BOOL)bPDF
{
    NSString *ret = @"";
    if( bPDF )
    {
        NSString *filename = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"mypdf-%d.pdf", index]];
        [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
        if( [viewerPage MyCreatePDFFile:filename list:attachmentArray isPrint:YES] )
            ret = filename;
    }
    else
    {
        NSString *filename = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"mytiff-%d.tif", index]];
        [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
        if( [self saveTifFileWithMultiPages:attachmentArray images:NO filename:filename] )
            ret = filename;
    }
    return ret;
}

- (void)sendSftFaxProc:(NSTimer *)timer
{
    static int times = 0;
    if( bSendSftfax )
    {
        times += 1;
        if( times > 3*60 )
            bSendSftfax = NO;
    }
    if( !bSendSftfax && [JobQueue count] )
    {
        NSDictionary *dict = [JobQueue objectAtIndex:0];
        [JobQueue removeObjectAtIndex:0];
        NSDictionary *pack = [dict valueForKey:@"faxPackage"];
        NSArray *recip = [dict valueForKey:@"Recipient"];
        bSendSftfax = YES;
        times = 0;
        if( ![wsm sendFax:recip pack:pack index:0] )
        {
            NSMutableArray *arrAtach = [pack valueForKey:@"Attachments"];
            [viewerPage removeFilesfromArray:arrAtach];
            NSDictionary *arr = [recip objectAtIndex:0];
            NSString *address = [arr objectForKey:KEY_ADDRESS];
            NSLog(@"Failed to send a sftfax to %@", address);
            bSendSftfax = NO;
        }
    }
    if( [JobQueue count] == 0 )
    {
        [timer invalidate];
        [self cleanSendFaxPage];
    }
}

- (bool)saveTifFileWithMultiPages:(NSArray *)attachments images:(BOOL)bImages filename:(NSString *)filename
{
    NSInteger numAttachments = [attachments count];
    NSMutableData* imageData = [NSMutableData data];
    CGImageDestinationRef imageDest =  CGImageDestinationCreateWithData((CFMutableDataRef) CFBridgingRetain(imageData),
                                                                        (CFStringRef)@"public.tiff",
                                                                        numAttachments, NULL);
    NSDictionary* tifProp = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithInt:5], kCGImagePropertyTIFFCompression, //5 for LZW, 4 for group4, unable to make JPG compression
                             [NSNumber numberWithInteger:200], kCGImagePropertyTIFFXResolution,
                             [NSNumber numberWithInteger:200], kCGImagePropertyTIFFYResolution,
                             nil];
    NSDictionary* prop = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat:0.8], kCGImageDestinationLossyCompressionQuality,
                          tifProp, kCGImagePropertyTIFFDictionary,
                          nil];
    for(int m=0; m<numAttachments; m++)
    {
        UIImage *image = nil;
        if( bImages )
        {
            image = [attachments objectAtIndex:m];
        }
        else
        {
            NSString *fname = [attachments objectAtIndex:m];
            image = [UIImage imageWithContentsOfFile:fname];
        }
        CGImageDestinationAddImage(imageDest, [image CGImage], (CFDictionaryRef) CFBridgingRetain(prop));
    }
    
    if( CGImageDestinationFinalize(imageDest) )
    {
        [imageData writeToFile:filename atomically:YES];
        CFRelease(imageDest);
        return YES;
    }
    else
    {
        CFRelease(imageDest);
        return NO;
    }
}

- (void)displayComposerSheet:(NSArray *)recips
{
    if( ![MFMailComposeViewController canSendMail] )
    {
        [viewerPage ShowAlertTitle:@"Error" message:@"Mail function has not been configured, you cannot send email.\n"
         "To configure mail function, go to the device Settings/Mail, Contacts, Calendars."];
        return;
    }
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    [mailPicker setSubject:subjectText];
    [mailPicker setMessageBody:memoText isHTML:NO];
    
    [mailPicker setToRecipients:recips];
    
    // Attach images to the email.
    int numAttachments = (int)[attachmentArray count];
    int st = bCoverPageOn ? 1 : 0;
    for(int k=st; k<numAttachments; k++)
    {
        @autoreleasepool
        {
            NSString *file = [attachmentArray objectAtIndex:k];
            UIImage *img = [UIImage imageWithContentsOfFile:file];
            NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
            NSArray *array = [file componentsSeparatedByString:@"/"];
            NSInteger nm = [array count];
            NSString *filename = [array objectAtIndex:nm-1];
            [mailPicker addAttachmentData:imageData mimeType:@"image/jpg" fileName:filename];
        }
    }
    
    // Present the mail composition interface.
    [self presentViewController:mailPicker animated:YES completion:nil];
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cleanSendFaxPage
{
    [recipient resignFirstResponder];
    [subject resignFirstResponder];
    [memo resignFirstResponder];
    [self hideMatchedContactsTable];
    
    memo.text = @"";
    subject.text = @"";
    recipient.text = @"";
    labelAttachments.text = @"";
    [recipients removeAllObjects];
    [ImgCollection removeAllObjects];
    [self addCoverpageForAttachment];
    [self setAttachmentImages];
}

@end

///////////////////////////////////////////////////
//
//

@implementation dropboxController
@synthesize folderEntries;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [folderEntries count];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CellIdentifier = [NSString stringWithFormat:@"Line - %ld", (long)(indexPath.row)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    DBFILESMetadata *entry = folderEntries[indexPath.row];
    if ([entry isKindOfClass:[DBFILESFileMetadata class]])
    {
        DBFILESFileMetadata *fileMetadata = (DBFILESFileMetadata *)entry;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = fileMetadata.name;
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f KB,  %@", (float)fileMetadata.size.intValue/1024.0, [viewerPage GetTimeStringFrom:fileMetadata.clientModified forFileName:NO]];
        cell.imageView.image = [UIImage imageNamed:@"Save.png"];
    }
    else if ([entry isKindOfClass:[DBFILESFolderMetadata class]])
    {
        DBFILESFolderMetadata *folderMetadata = (DBFILESFolderMetadata *)entry;
        cell.textLabel.text = folderMetadata.name;
        cell.imageView.image = [UIImage imageNamed:@"Open.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBFILESMetadata *entry = folderEntries[indexPath.row];
    if ([entry isKindOfClass:[DBFILESFileMetadata class]])
    {
        [sendPage onDropboxCancel];
        [sendPage performSelector:@selector(downloadProc:) withObject:entry.pathLower afterDelay:0.3];
    }
    else if ([entry isKindOfClass:[DBFILESFolderMetadata class]])
    {
        [sendPage setDropboxWindow:entry];
    }
}

@end
