//
//  InboxController.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/11/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "PageViewController.h"
#import "InboxController.h"
#import "Wsmanager.h"
#import "DeliveryVO.h"
#import "DocumentVO.h"
#import "GetDelivery.h"

@interface InboxController ()

@end

@implementation InboxController
@synthesize faxTable;

NSInteger nThumbnailWindowHeight = 410;
UIImageView *thumbnailImageView[MAX_PAGE_COUNT] = {nil};
NSInteger nSelectedIndex = -1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    inboxPage = self;
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = 0.5;

    faxTable = [[UITableView alloc] init];
    faxTable.delegate = self;
    faxTable.dataSource = self;
    faxTable.cellLayoutMarginsFollowReadableWidth = NO;
    [faxTable addGestureRecognizer:longPress];
    
    if( nDeviceType == DEVICE_IPAD )
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        thumbnailView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        thumbnailView.backgroundColor = [UIColor whiteColor];
        thumbnailView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        thumbnailView.layer.borderWidth = 1.0;
        [thumbnailView setDataSource:self];
        [thumbnailView setDelegate:self];
        [thumbnailView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    
    thumbSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    thumbSpinner.hidesWhenStopped = YES;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(100, 5, 30, 30);
    [self.navigationController.navigationBar addSubview:spinner];
    spinner.hidden = YES;
    self.tableView.sectionHeaderHeight = 55;
    if( [self setInfo] )
    {
        spinner.hidden = NO;
        [spinner startAnimating];
        [self performSelector:@selector(startJob) withObject:nil afterDelay:0.1];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    int dx = self.tableView.frame.size.width;
    CGRect rect = CGRectMake(10, 10, dx - 20, nThumbnailWindowHeight);
    thumbnailView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startJob
{
    [self showSpinner:YES];
    WebServiceVersion = [wsm getWebServiceVersion];
    [wsm getReceivedIPFaxes];
}

- (void)showSpinner:(BOOL)bShow
{
    spinner.hidden = !bShow;
    if( bShow )
        [spinner startAnimating];
    else
        [spinner stopAnimating];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:faxTable];
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [faxTable indexPathForRowAtPoint:location];
            if( indexPath != nil )
            {
                [faxTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                if( nWebService == WEB_SERVICE_MOBILE )
                {
                    FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = [listOfMeta objectAtIndex:indexPath.row];
                    NSString *sdata = [NSString stringWithFormat:@"TSI: %@\nCallerID: %@\nConnectTime: %d\nDID: %@\nFileExtension: %@\nStatus: %@",
                                       meta.TSI,
                                       meta.CallerID,
                                       [meta.ConnectTime intValue],
                                       meta.DID,
                                       meta.FileExtension,
                                       meta.StatusText];
                    [viewerPage ShowAlertTitle:@"Metadata" message:sdata];
                }
                else
                    if( nWebService == WEB_SERVICE_ANYWHER )
                    {
                        FAWebServiceMain_RxStatus *meta = [listOfMeta objectAtIndex:indexPath.row];
                        NSString *sdata = [NSString stringWithFormat:@"TSI: %@\nCallerID: %@\nConnectTime: %d\nDID: %@\nStatus: %@",
                                           meta.TSI,
                                           meta.CallerID,
                                           [meta.ConnectTime intValue],
                                           meta.DID,
                                           meta.StatusText];
                        [viewerPage ShowAlertTitle:@"Metadata" message:sdata];
                    }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}

- (bool)setInfo
{
    NSDictionary* properties = [NSDictionary dictionaryWithContentsOfFile:settingsFilePath];
    if( properties )
    {
        sWebService = [properties valueForKey:@"WebService"];
        sUsername = [properties valueForKey:@"Username"];
        sPassword = [properties valueForKey:@"Password"];
        sSenderName = [properties valueForKey:@"SenderName"];
        sSenderAddr = [properties valueForKey:@"SenderAddr"];
        sSenderComp = [properties valueForKey:@"SenderComp"];
        sSenderPhon = [properties valueForKey:@"SenderPhon"];
        coverPageSwitch.on = [[properties valueForKey:@"UseCoverpage"] boolValue];
    }
    if( [sWebService isEqualToString:@""] || [sUsername isEqualToString:@""] || [sPassword isEqualToString:@""] )
        return false;
    
    NSRange rg1 = [sWebService rangeOfString:@"http://"];
    if( rg1.location == 0 )
    {
        sWebService = [sWebService stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    }
    NSRange rg2 = [sWebService rangeOfString:@"https://"];
    if( rg2.location == 0 )
    {
        sWebService = [sWebService stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    }
    NSRange rg = [sWebService rangeOfString:@"/"];
    if( rg.location == NSNotFound )
    {
        sWebService = [sWebService stringByAppendingString:@"/"];
    }
    nWebService = 0;
    sWebService = [sWebService lowercaseString];
    if( [sWebService isEqualToString:SERVER_MOBILEFAX] )
    {
        nWebService = WEB_SERVICE_MOBILE;
        FaxFolder = [FaxFolder stringByAppendingString:@"/MobileFax"];
    }
    else if( [sWebService isEqualToString:SERVER_FAXCOMANYWHERE] )
    {
        nWebService = WEB_SERVICE_ANYWHER;
        FaxFolder = [FaxFolder stringByAppendingString:@"/Faxcomanywhere"];
    }
    else if( [sWebService containsString:SERVER_SFTFAX] || [sWebService containsString:@"faxcomanywherev2.com"] )
    {
        nWebService = WEB_SERVICE_SFT;
        FaxFolder = [FaxFolder stringByAppendingString:@"/Sftfax"];
        coverPageSwitch.on = YES;
    }

    if( nWebService == 0 )
    {
        [viewerPage ShowAlertTitle:@"Error" message:@"Invalid server name"];
        return false;
    }
    else
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if( ![fileManager fileExistsAtPath:FaxFolder] )
        {
            [fileManager createDirectoryAtPath:FaxFolder withIntermediateDirectories:NO attributes:nil error:nil];
        }
        wsm = [[WSManager alloc] init];
    }

    return true;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger num = 1;
    if( tableView == self.tableView ) num = nDeviceType == DEVICE_IPAD ? 2 : 1;
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if( tableView == self.tableView ) num = 1;
    if( tableView == faxTable ) num = [listOfMeta count];
    
    return num;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = nWebService == WEB_SERVICE_SFT ? 45 : 38;
    if( aTableView == self.tableView )
    {
        if( indexPath.section == 0 )
        {
            if( nDeviceType == DEVICE_IPHONE )
            {
                height = aTableView.frame.size.height;
            }
            else
            {
                height = 375;
            }
            faxTable.frame = CGRectMake(2, 2, aTableView.frame.size.width-4, height-4);
        }
        else
        {
            height = nThumbnailWindowHeight + 20;
        }
    }
    
    return height;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    if( aTableView == self.tableView )
    {
        if( section == 0 )
        {
            ret = [listOfMeta count] == 1 ? @"1 fax" : [NSString stringWithFormat:@"%lu Faxes", (unsigned long)[listOfMeta count]];
        }
        if( section == 1 )
        {
            ret = @"Thumbnails";
        }
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        if( nWebService == WEB_SERVICE_SFT )
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        else
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if( tableView == self.tableView && indexPath.section == 0 )
        {
            [cell.contentView addSubview:faxTable];
        }
        if( tableView == self.tableView && nDeviceType == DEVICE_IPAD && indexPath.section == 1 )
        {
            int dx = self.tableView.frame.size.width;
            CGRect rect = CGRectMake(10, 10, dx - 20, nThumbnailWindowHeight);
            thumbnailView.frame = rect;
            [cell.contentView addSubview:thumbnailView];
        }
    }
    
    if( tableView == faxTable && [listOfMeta count] > 0 )
    {
        NSInteger status = 0;
        NSInteger NumberOfPages = 0;
        NSDate *ReceiveTime = nil;
        NSString *DID = nil;
        NSString *callerID = nil;
        NSInteger fontSize1 = nWebService == WEB_SERVICE_SFT ? 14 : 18;
        NSInteger fontSize2 = nWebService == WEB_SERVICE_SFT ? 12 : 16;
        UIColor *color = nWebService == WEB_SERVICE_SFT ? [UIColor grayColor] : [UIColor blackColor];
        
        if( nWebService == WEB_SERVICE_MOBILE )
        {
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = [listOfMeta objectAtIndex:indexPath.row];
            status = [meta.IsRead boolValue] ? 0 : 1;
            ReceiveTime = meta.ReceiveTime;
            NumberOfPages = [meta.NumberOfPages intValue];
            DID = meta.DID;
            callerID = meta.CallerID;
        }
        else if( nWebService == WEB_SERVICE_ANYWHER )
        {
            FAWebServiceMain_RxStatus *meta = [listOfMeta objectAtIndex:indexPath.row];
            status = [meta.Status intValue];
            ReceiveTime = meta.CompletionTime;
            NumberOfPages = [meta.NumberOfPages intValue];
            DID = meta.DID;
            callerID = meta.CallerID;
        }
        else if( nWebService == WEB_SERVICE_SFT )
        {
            DeliveryVO *delV = [listOfMeta objectAtIndex:indexPath.row];
            status = [delV getReadStatus] ? 0 : 1;
            DID = @"s";
        }

        if( status == 1 )
        {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:fontSize1];
            cell.detailTextLabel.textColor = DID==nil ? [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1] : color;
            cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:fontSize2];
        }
        else
        {
            cell.textLabel.font = [UIFont systemFontOfSize:fontSize1];
            cell.detailTextLabel.textColor = DID==nil ? [UIColor colorWithRed:0 green:0.5 blue:0 alpha:0.75] : [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:fontSize2];
        }
        
        if( nWebService == WEB_SERVICE_SFT )
        {
            DeliveryVO *delV = [listOfMeta objectAtIndex:indexPath.row];
            NSString *from = [delV getSenderEmailAddress];
            NSArray *chunks = [[delV getParsedDateLastUpdated] componentsSeparatedByString: @" "];
            NSString *subject = [delV getDeliveryName];
            NSString *tmStr = [NSString stringWithFormat:@"%@ %@%@", [chunks objectAtIndex:0], [chunks objectAtIndex:1], [chunks objectAtIndex:2]];
            NSString *str = nDeviceType == DEVICE_IPHONE ? [NSString stringWithFormat:@"%@,  %@", tmStr, from] : [NSString stringWithFormat:@"%@  from: %@", tmStr, from];
            cell.textLabel.text = str;
            DocumentVO *docV = [delV.getDocumentVOs objectAtIndex:0];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d-page,  %@", docV.getPageCount, subject];
        }
        else
        {
            NSString *tmStr = [viewerPage GetTimeStringFrom:ReceiveTime forFileName:NO];
            NSString *str = nDeviceType == DEVICE_IPHONE ? tmStr : [NSString stringWithFormat:@"%@  from: %@", tmStr, callerID];
            cell.textLabel.text = str;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-page", (long)NumberOfPages];
        }
        
        if( nSelectedIndex == indexPath.row )
        {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.tintColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    header.textLabel.font = [UIFont boldSystemFontOfSize:17];
    header.textLabel.textColor = [UIColor blackColor];
    
    if( aTableView == self.tableView && section == 1 )
    {
        CGSize sz = view.frame.size;
        thumbSpinner.frame = CGRectMake(sz.width/2-15, sz.height-40, 30, 30);
        [view addSubview:thumbSpinner];
        [thumbSpinner stopAnimating];
    }
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( aTableView == self.tableView )
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    if( aTableView == faxTable )
    {
        [self performSelector:@selector(doSelectAtIndexPath:) withObject:indexPath afterDelay:0];
    }
}

- (void)doSelectAtIndexPath:(NSIndexPath *)indexPath
{
    if( nSelectedIndex == indexPath.row )
    {
        if( nDeviceType == DEVICE_IPHONE )
        {
            [viewerPage switchToView:viewerPage];
        }
    }
    else
    {
        nSelectedIndex = indexPath.row;
        [self goToSelectedFax];
    }
}

- (void)goToSelectedFax
{
    if( nWebService == WEB_SERVICE_MOBILE )
    {
        FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = [listOfMeta objectAtIndex:nSelectedIndex];
        theFaxID = meta.FaxIDInFolder;
        if( ![meta.IsRead boolValue] )
        {
            meta.IsRead = [[USBoolean alloc] initWithBool:YES];
            [faxTable reloadData];
            NSInteger anm = [UIApplication sharedApplication].applicationIconBadgeNumber;
            if( anm > 0 )
                [self setApplicationBadgeNumber:anm - 1];
            [wsm setReadFlag];
        }
    }
    else if( nWebService == WEB_SERVICE_ANYWHER )
    {
        FAWebServiceMain_RxStatus *meta = [listOfMeta objectAtIndex:nSelectedIndex];
        theFaxID = meta.ImageFileName;
        if( [meta.Status intValue] )
        {
            meta.Status = [NSNumber numberWithInt:0];
            [self.tableView reloadData];
            NSInteger anm = [UIApplication sharedApplication].applicationIconBadgeNumber;
            if( anm > 0 )
                [self setApplicationBadgeNumber:anm - 1];
        }
    }
    else if( nWebService == WEB_SERVICE_SFT )
    {
        DeliveryVO *delV = [listOfMeta objectAtIndex:nSelectedIndex];
        theFaxID = [NSString stringWithFormat:@"%d", delV.getDeliveryId];
        if( ![delV getReadStatus] )
        {
            GetDelivery *gdlv = [[GetDelivery alloc] initWithDeliveryVO:delV :self];
            [gdlv getDelivery:delV.getDeliveryId :nil];
            [delV setReadStatus:YES];
            [faxTable reloadData];
            NSInteger anm = [UIApplication sharedApplication].applicationIconBadgeNumber;
            if( anm > 0 )
                [self setApplicationBadgeNumber:anm - 1];
        }
    }

    if( nDeviceType == DEVICE_IPHONE )
    {
        [viewerPage switchToView:viewerPage];
        [viewerPage cleanScreen];
        [viewerPage showSpinner:YES];
    }
    else
    {
        nTotalPages = 0;
        [thumbnailView setContentOffset:CGPointZero];
        for(NSInteger i=0; i<MAX_PAGE_COUNT; i++)
        {
            if( thumbnailImageView[i] )
            {
                [thumbnailImageView[i] removeFromSuperview];
                thumbnailImageView[i] = nil;
            }
        }
    }
    [self performSelector:@selector(DoReceive) withObject:nil afterDelay:0];
}

- (void)DoReceive
{
    if( [theFaxID isEqualToString:@""] == NO )
    {
        NSLog(@"Start loading file...");
        NSString *file = @"";
        if( nDeviceType == DEVICE_IPHONE )
        {
            file = [wsm receiveIPFaxByFaxID:theFaxID];
        }
        else
        {
            [thumbSpinner startAnimating];
            file = [wsm receiveIPFaxByFaxID:theFaxID];
            if( nWebService != WEB_SERVICE_SFT )
            {
                [thumbSpinner stopAnimating];
            }
        }
        NSLog(@"Finish loading file...");
        
        [self performSelector:@selector(postReceive:) withObject:file afterDelay:0];
    }
}

- (void)postReceive:(NSString *)file
{
    if( [file isEqualToString:@""] )
    {
        if( nWebService == WEB_SERVICE_SFT )
        {
            wsm.wsSft.bAccessing = true;
        }
    }
    else
    {
        [self readFaxFile:file];
    }
}

- (void)openDocumentForSft:(NSString *)fileName
{
    wsm.wsSft.bAccessing = false;
    [self readFaxFile:fileName];
}

- (void)readFaxFile:(NSString *)fileName
{
    if( nDeviceType == DEVICE_IPAD )
        bShowThumbnail = YES;
    [viewerPage setPageInfoForFile:fileName];
    bShowThumbnail = NO;

    if( nDeviceType == DEVICE_IPHONE )
    {
        [viewerPage showSpinner:NO];
    }
    else
    {
        [thumbnailView reloadData];
        [self prepareForThumbnails];
        [self displayThumbnails];
    }
}

- (void)resetThumbnailView
{
    NSIndexPath *path = faxTable.indexPathForSelectedRow;
    [faxTable deselectRowAtIndexPath:path animated:YES];
    nSelectedIndex = -1;
    if( nDeviceType == DEVICE_IPAD )
    {
        [thumbnailView setContentOffset:CGPointZero];
        for(NSInteger i=0; i<MAX_PAGE_COUNT; i++)
        {
            if( thumbnailImageView[i] )
            {
                [thumbnailImageView[i] removeFromSuperview];
                thumbnailImageView[i] = nil;
            }
        }
        [thumbnailView reloadData];
    }
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [theFaxID isEqualToString:@""] ? 0 : nTotalPages;
}

NSInteger nThumbIndex = 0;
- (void)setThumbnails
{
    if( nThumbIndex < nTotalPages )
    {
        [self doSetThumbnailImageAtPage];
    }
    else
    {
        [thumbSpinner stopAnimating];
        [viewerPage closeFileData];
    }
}

- (void)prepareForThumbnails
{
    nThumbIndex = 0;
    CGSize size = [self getThumbnailSize];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    for(NSInteger i=0; i<nTotalPages; i++)
    {
        if( thumbnailImageView[i] )
        {
            thumbnailImageView[i].frame = rect;
        }
        else
        {
            thumbnailImageView[i] = [[UIImageView alloc] initWithFrame:rect];
        }
    }
}

- (void)displayThumbnails
{
    [self prepareForThumbnails];
    [self performSelectorInBackground:@selector(setThumbnails) withObject:nil];
}

- (void)doSetThumbnailImageAtPage
{
    NSInteger page = nThumbIndex++;
    UIImage *image = [viewerPage getImageForPage:page];
    [self setThumbnailImage:image AtPage:page];
    [self performSelectorInBackground:@selector(setThumbnails) withObject:nil];
}

- (void)setThumbnailImage:(UIImage *)image AtPage:(NSInteger)page
{
    image = [viewerPage MergeAnnotationsWithImage:image onPage:page];
    
    CGSize size = [self getThumbnailSize];
    float w = size.width;
    float h = w * 11.0 / 8.5;
    float rx = w / image.size.width;
    float ry = h / image.size.height;
    float r = rx < ry ? rx : ry;
    float wd = image.size.width * r;
    float ht = image.size.height * r;
    float x = (size.width - wd) / 2.0;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rt = CGRectMake(x, 20, wd, ht);
    [image drawInRect:rt];
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.8, 1.0);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, rt);
    CGContextStrokePath(ctx);
    UIFont *font = [UIFont systemFontOfSize:13];
    [[UIColor grayColor] set];
    NSString *text = [NSString stringWithFormat:@"%d.", (int)page+1];
    [text drawAtPoint:CGPointMake(rt.origin.x, rt.origin.y-17) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    thumbnailImageView[page].image = newImage;
}

- (void)clearThumbnailView
{
    for(NSInteger i=0; i<MAX_PAGE_COUNT; i++)
    {
        if( thumbnailImageView[i] )
        {
            [thumbnailImageView[i] removeFromSuperview];
            thumbnailImageView[i] = nil;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if( [cell.contentView.subviews count] > 0 )
    {
        [cell.contentView.subviews[0] removeFromSuperview];
    }
    [cell.contentView addSubview:thumbnailImageView[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [viewerPage goToPage:indexPath.row];
    [viewerPage switchToView:viewerPage];
}

- (CGSize)getThumbnailSize
{
    CGSize size;
    if( bOrientLandscape )
    {
        if( nTotalPages == 1 ) size.width = 950;
        if( nTotalPages == 2 ) size.width = 490;
        if( nTotalPages == 3 ) size.width = 320;
        if( nTotalPages >= 4 ) size.width = 240;
    }
    else
    {
        if( nTotalPages == 1 ) size.width = 700;
        if( nTotalPages == 2 ) size.width = 360;
        if( nTotalPages >= 3 ) size.width = 235;
    }
    size.height = size.width * 11.0 / 8.5 + 20;
    
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getThumbnailSize];
}

- (IBAction)OnRefresh:(id)sender
{
    [self showSpinner:YES];
    [wsm updateReceivedIPFaxes];
    [self deselectFaxTable];
}

- (NSString *)getFileName
{
    static NSInteger nID = 0;
    if( nID == 5 ) nID = 0;
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"ImageFile-%ld.tmp", (long)nID++]];
}

- (void)deselectFaxTable
{
    nSelectedIndex = -1;
    [faxTable reloadData];
}

- (void)setApplicationBadgeNumber:(NSInteger)badgeNumber
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = badgeNumber;
}

- (void)updateViewWithUnreadNumber:(NSInteger)num
{
    [self setApplicationBadgeNumber:num];
    [self.tableView reloadData];
    [faxTable reloadData];
}

@end
