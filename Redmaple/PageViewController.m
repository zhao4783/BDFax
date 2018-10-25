//
//  PageViewController.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/9/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import "PageViewController.h"
#import "MenuViewController.h"
#import "dynthresh.h"
#import "SettingsViewController.h"


@interface PageViewController ()

@end

@implementation PageViewController
@synthesize pageList;


PageViewController *viewerPage = nil;
InboxController *inboxPage = nil;
SettingPage *settingsPage = nil;
SendPage *sendPage = nil;
StatusPage *statusPage = nil;
WSManager *wsm = nil;
NSString *MAIN_TITLE = @"BDFax";
NSString *sWebService=@"", *sUsername=@"", *sPassword=@"";
NSString *sSenderName=@"", *sSenderAddr=@"", *sSenderComp=@"", *sSenderPhon=@"";
NSString *WebServiceVersion = @"";
NSString *settingsFilePath = @"";
NSString *contactsFilePath = @"";
NSString *FaxFolder = @"";
NSString *pageFolder = @"";
CGRect savedScrollViewFrame;
int nDeviceType;
int nIOSVersion;
int nWebService = 0;
BOOL bOrientLandscape = NO;
UISwitch *coverPageSwitch = nil;
BOOL bBackToSendPage = NO;
BOOL bAnnotationOn = NO;

FAWebServiceMain_MessageStatus *stsAnywhere = nil;
FAWebServiceMain_PendingMessage *ptsAnywhere = nil;
FAXCOM_x0020_Service_MessageStatus *stsMobile = nil;
FAXCOM_x0020_Service_PendingMessage *ptsMobile = nil;
NSString *theFaxID = @"";
NSInteger nTotalPages = 0;
NSInteger nNextPage = 0;
NSMutableArray *listOfMeta = nil;
NSMutableArray *ImgCollection = nil;
UIBarButtonItem *savedLeftButton = nil;
UIBarButtonItem *savedRightButton = nil;
NSString *savedTitle = @"";

NSMutableArray *appContacts = nil;
NSMutableArray *ColorsOfLine = nil;
UISegmentedControl *typeSegments = nil;
NSInteger nAnnoLineIndex = 0;
NSInteger nAnnoColorIndex = 0;
NSInteger nAnnoFontSizeIndex = 0;
NSInteger nAnnotationType = -1;
UISegmentedControl *colorAnnoSegments = nil;
UISegmentedControl *lineAnnoSegments = nil;
UISegmentedControl *fontSizeAnnoSegments = nil;
UIColor *backgroundColor;
BOOL biPhoneX = NO;
CGRect landscapeFrame;
CGRect portraitFrame;
NSString *showAgreement = @"";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone )
    {
        nDeviceType = DEVICE_IPHONE;
        if (screenSize.height == 812)
            biPhoneX = YES;
    }
    else
    {
        nDeviceType = DEVICE_IPAD;
    }
    
    bOrientLandscape = screenSize.width > screenSize.height;
    nIOSVersion = [[[UIDevice currentDevice] systemVersion] intValue];

    CGFloat ac = 0.75;
    backgroundColor = [UIColor colorWithRed:ac green:ac blue:ac alpha:1.0];
    pageControl = [UIPageControl appearance];
    pageControl.backgroundColor = backgroundColor;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.hidesForSinglePage = YES;
    
    viewerPage = self;
    inboxPage = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxController"];
    settingsPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingPage"];
    sendPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SendPage"];
    statusPage = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusPage"];

    self.navigationController.toolbarHidden = YES;
    self.delegate = self;
    self.dataSource = self;
    pageList = [[NSMutableArray alloc] init];
    ImgCollection = [[NSMutableArray alloc] init];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    settingsFilePath = [documentsDirectory stringByAppendingPathComponent:@"Settings.dic"];
    contactsFilePath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.arr"];
    FaxFolder = [documentsDirectory stringByAppendingPathComponent:@"FaxFolder"];
    pageFolder = [documentsDirectory stringByAppendingPathComponent:@"pageFolder"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( ![fileManager fileExistsAtPath:FaxFolder] )
    {
        [fileManager createDirectoryAtPath:FaxFolder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if( ![fileManager fileExistsAtPath:pageFolder] )
    {
        [fileManager createDirectoryAtPath:pageFolder withIntermediateDirectories:NO attributes:nil error:nil];
    }

    landscapeFrame = CGRectZero;
    portraitFrame = CGRectZero;
    [self performSelector:@selector(onStart) withObject:nil afterDelay:0.1];

    coverPageSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [coverPageSwitch setOn:YES animated:NO];
    [coverPageSwitch addTarget:settingsPage action:@selector(switchCoverpage) forControlEvents:UIControlEventValueChanged];
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
   
    [inboxPage setInfo];
    showAgreement = [documentsDirectory stringByAppendingPathComponent:@"showAgreement.dat"];
    if( ![[NSFileManager defaultManager] fileExistsAtPath:showAgreement] )
    {
        NSString *agreementFilePath = [[NSBundle mainBundle] pathForResource:@"Agreement" ofType:@"txt"];
        NSString *str = [NSString stringWithContentsOfFile:agreementFilePath encoding:NSASCIIStringEncoding error:nil];
        [self agreementScreen:str];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self goToPage:nCurrentPageIndex];
}

UIViewController *agreement = nil;
- (void)agreementScreen:(NSString *)str
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Accept" style:UIBarButtonItemStylePlain target:self action:@selector(acceptAgreement)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Do not" style:UIBarButtonItemStylePlain target:self action:@selector(onNotAccept)];
    
    agreement = [[UIViewController alloc] init];
    CGRect ct = self.navigationController.navigationBar.frame;
    int wy = ct.origin.y + ct.size.height;
    CGRect rt = self.view.frame;
    rt.origin.y = wy;
    rt.origin.x = 0;
    rt.size.height -= wy;
    UITextView *pv = [[UITextView alloc] initWithFrame:rt];
    pv.editable = NO;
    pv.text = str;
    [agreement.view addSubview:pv];

    UINavigationController *naviController = [[UINavigationController alloc] init];
    naviController.viewControllers = [NSArray arrayWithObject:agreement];
    naviController.navigationBar.topItem.title = @"Agreement";
    naviController.navigationBar.topItem.leftBarButtonItem = leftBtn;
    naviController.navigationBar.topItem.rightBarButtonItem = rightBtn;
    naviController.delegate = self;
    [self presentViewController:naviController animated:YES completion:nil];
}

- (void)onNotAccept
{
    exit(0);
}

- (void)acceptAgreement
{
    [agreement dismissViewControllerAnimated:YES completion:nil];
    [@"Yes" writeToFile:showAgreement atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)setAnnotationBar
{
    bAnnotationOn = bAnnotationOn ? NO : YES;
    self.navigationController.toolbarHidden = !bAnnotationOn;
    savedScrollViewFrame = [self getScrollViewFrame];
    contentVC.scrollView.frame = savedScrollViewFrame;
    [contentVC setImageViewFrame];
}

- (CGRect)getScrollViewFrame
{
    CGRect rt = self.view.frame;
    if( @available(iOS 11.0, *) )
    {
        int top = self.view.safeAreaInsets.top;
        int bottom = self.view.safeAreaInsets.bottom;
        int left = self.view.safeAreaInsets.left;
        int right = self.view.safeAreaInsets.right;
        rt.origin.x = left;
        rt.origin.y = top;
        rt.size.width -= left + right;
        rt.size.height -= top + bottom;
    }
    else
    {
        int top = self.topLayoutGuide.length;
        int bottom = self.bottomLayoutGuide.length;
        rt.origin.y = top;
        rt.size.height -= top + bottom;
    }
    int pageControlBarHeight = 36;
    rt.size.height -= pageControlBarHeight;
    if( rt.size.width > rt.size.height )
        landscapeFrame = rt;
    else
        portraitFrame = rt;

    return rt;
}

- (void)onStart
{
    savedScrollViewFrame = [self getScrollViewFrame];
    [self setAnnotationTools];
    strLogoFile = [[NSBundle mainBundle] pathForResource:@"Logo" ofType:@"png"];
    [self displayLogoImage];
}

- (void)displayLogoImage
{
    [self setPageInfoForFile:strLogoFile];
}

NSTiffSplitter *splitter = nil;
CGPDFDocumentRef fromPDFDoc;
NSInteger fileFormat = 0;
- (UIImage *)getImageForPage:(NSInteger)page
{
    UIImage *image = nil;
    NSData *data = nil;
    if( fileFormat == FILE_TIF )
    {
        data = [splitter dataForImage:page];
        if( data )
            image = [UIImage imageWithData:data];
    }
    if( fileFormat == FILE_PDF )
    {
        image = [self getImageFromPdf:fromPDFDoc forPage:page];
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    if( data )
    {
        NSString *file = [pageFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"ImagePage-%d.tmp", page]];
        if( [data writeToFile:file atomically:YES] )
            [pageList addObject:[self makePageInfo:file]];
    }
    return image;
}

- (void)closeFileData
{
    if( fileFormat == FILE_PDF )
    {
        CGPDFDocumentRelease(fromPDFDoc);
    }
}

- (void)setPageInfoForFile:(NSString *)filename
{
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:filename];
    if( fh == nil )
    {
        [self ShowAlertTitle:@"Error" message:@"Cannot find this document."];
        return;
    }
    
    [self removeTempFilesInFolder:pageFolder];
    [pageList removeAllObjects];
    nTotalPages = 0;
    
    NSData *fileData = [fh readDataToEndOfFile];
    [fh closeFile];
    char buf[5];
    [fileData getBytes:buf length:4];
    int nPages = 0;
    if( strncmp(buf, "II", 2)==0 || strncmp(buf, "MM", 2)==0 )
    {
        fileFormat = FILE_TIF;
        splitter = [[NSTiffSplitter alloc] initWithPathToImage:filename];
        int nPages = splitter.countOfImages;
        if( nPages > MAX_PAGE_COUNT )
            nPages = MAX_PAGE_COUNT;
        
        if( nDeviceType == DEVICE_IPAD )
        {
            nTotalPages = nPages;
            nCurrentPageIndex = 0;
        }
        else
        {
            for(int i=0; i<nPages; i++)
            {
                @autoreleasepool
                {
                    NSData *data = [splitter dataForImage:i];
                    if( data )
                    {
                        NSString *file = [pageFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"ImagePage-%d.tmp", i]];
                        if( [data writeToFile:file atomically:YES] )
                            [pageList addObject:[self makePageInfo:file]];
                    }
                }
            }
        }
    }
    else if( strncmp(buf, "%PDF", 4)==0 )
    {
        fileFormat = FILE_PDF;
        CFStringRef path = CFStringCreateWithCString (NULL, [filename UTF8String], kCFStringEncodingUTF8);
        CFURLRef url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
        fromPDFDoc = CGPDFDocumentCreateWithURL((CFURLRef)url);
        CFRelease (path);
        CFRelease (url);
        nPages = (int)CGPDFDocumentGetNumberOfPages(fromPDFDoc);
        if( nPages > MAX_PAGE_COUNT )
            nPages = MAX_PAGE_COUNT;
        
        if( nDeviceType == DEVICE_IPAD )
        {
            nTotalPages = nPages;
            nCurrentPageIndex = 0;
        }
        else
        {
            for(int i=0; i<nPages; i++)
            {
                NSLog(@"Set page %d", i);
                @autoreleasepool
                {
                    UIImage *image = [self getImageFromPdf:fromPDFDoc forPage:i];
                    NSData *data = UIImageJPEGRepresentation(image, 1.0);
                    if( data )
                    {
                        NSString *file = [pageFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"ImagePage-%d.tmp", i]];
                        if( [data writeToFile:file atomically:YES] )
                            [pageList addObject:[self makePageInfo:file]];
                    }
                }
            }
            CGPDFDocumentRelease(fromPDFDoc);
        }
    }
    else
    {
        NSString *file = [pageFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"ImagePage-%d.tmp", 0]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if( [fileManager copyItemAtPath:filename toPath:file error:nil] )
            [pageList addObject:[self makePageInfo:file]];
        [inboxPage resetThumbnailView];
    }

    if( [pageList count] > 0 )
    {
        nTotalPages = [pageList count];
        nCurrentPageIndex = 0;
        ContentViewController *cvc = [self viewControllerAtIndex:0];
        NSArray *viewControllers = @[cvc];
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (NSMutableDictionary *)makePageInfo:(NSString *)imageFile
{
    NSMutableArray *anno = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                imageFile, PAGE_IMAGEFILE,
                                anno, PAGE_ANNOTATION,
                                nil];
    return dic;
}

- (void)showSpinner:(BOOL)bShow
{
    ContentViewController *cvc = [self.viewControllers objectAtIndex:0];
    cvc.spinner.hidden = !bShow;
    if( bShow )
        [cvc.spinner startAnimating];
    else
        [cvc.spinner stopAnimating];
}

- (UIImage *)getImageFromPdf:(CGPDFDocumentRef)pdfRef forPage:(NSInteger)page
{
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdfRef, page+1);
    CGPDFPageRetain(pageRef);
    
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFMediaBox);
    CGSize size = CGSizeMake(1700, 2200);
    if( pageRect.size.width > pageRect.size.height )
        size = CGSizeMake(2200, 1700);
    CGFloat rx = size.width / pageRect.size.width;
    CGFloat ry = size.height / pageRect.size.height;
    CGFloat r = rx < ry ? rx : ry;
    size.width = pageRect.size.width * r;
    size.height = pageRect.size.height * r;
    
    // renders its content.
    UIGraphicsBeginImageContext(size);
    CGContextRef imgContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(imgContext);
    CGContextTranslateCTM(imgContext, 0.0, size.height);
    CGContextScaleCTM(imgContext, r, -r);
    CGContextSetInterpolationQuality(imgContext, kCGInterpolationDefault);
    CGContextSetRenderingIntent(imgContext, kCGRenderingIntentDefault);
    CGContextDrawPDFPage(imgContext, pageRef);
    CGContextRestoreGState(imgContext);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); //PDF Page to image
    UIGraphicsEndImageContext();
    
    CGPDFPageRelease(pageRef);
    return image;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( toInterfaceOrientation == UIInterfaceOrientationPortrait ||
       toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        bOrientLandscape = false;
    }
    else
    {
        bOrientLandscape = true;
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View delegate Methods

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        nCurrentPageIndex = ((ContentViewController *)[pageViewController.viewControllers objectAtIndex:0]).pageIndex;
    }
}

#pragma mark - Page View Datasource Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [pageList count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Other Methods
- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([pageList count] == 0) || (index >= [pageList count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];

    NSDictionary *dic = [pageList objectAtIndex:index];
    contentViewController.image = [UIImage imageWithContentsOfFile:[dic valueForKey:PAGE_IMAGEFILE]];
    contentViewController.pageIndex = index;
    contentViewController.annotationList = [[pageList objectAtIndex:index] valueForKey:PAGE_ANNOTATION];

    return contentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [pageList count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return nCurrentPageIndex;
}

- (void)cleanScreen
{
    nCurrentPageIndex = -1;
    [pageList removeAllObjects];
    ContentViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    contentViewController.image = nil;
    contentViewController.pageIndex = 0;
    NSArray *viewControllers = @[contentViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)goToPage:(NSInteger)page
{
    if( page < 0 )
    {
        [self cleanScreen];
    }
    else if( page < [pageList count] )
    {
        nCurrentPageIndex = page;
        ContentViewController *cvc = [self viewControllerAtIndex:page];
        NSArray *viewControllers = @[cvc];
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (IBAction)OnAction:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Action"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* printBut = [UIAlertAction actionWithTitle:@"Print document"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                                                            {
                                                                [self printImage];
                                                            }];
    UIAlertAction* openBut = [UIAlertAction actionWithTitle:@"Open In..."
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                                                            {
                                                                [self openIn];
                                                            }];
    [alert addAction:printBut];
    [alert addAction:openBut];
    if( nDeviceType == DEVICE_IPHONE )
    {
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action)
                                 {
                                 }];
        [alert addAction:cancel];
    }
    else
    {
        alert.popoverPresentationController.sourceView = self.navigationController.navigationBar;
        CGRect rt = self.navigationController.navigationBar.frame;
        rt.origin.x = rt.size.width - 100;
        rt.origin.y -= 30;
        rt.size.width = 100;
        alert.popoverPresentationController.sourceRect = rt;
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)printImage
{
    if( ![UIPrintInteractionController isPrintingAvailable] )
    {
        return;
    }
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    //Prepare a print-information object initialized with default values.
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    
    printInfo.orientation = UIPrintInfoOrientationPortrait;
    printInfo.outputType = UIPrintInfoOutputGeneral;
    pic.printInfo = printInfo;
    
    NSString *pdfFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temPDF.pdf"];
    [[NSFileManager defaultManager] removeItemAtPath:pdfFile error:nil];
    if( [self MyCreatePDFFile:pdfFile isPrint:YES] )
    {
        pic.showsPageRange = YES;
        pic.printingItem = [NSURL fileURLWithPath:pdfFile];
    
        //Wait for completion
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error)
        {
            if (!completed && error)
            {
                NSLog(@"Printing could not complete because of error: %@", error);
            }
        };
        [pic presentFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES completionHandler:completionHandler];
    }
}

- (bool)MyCreatePDFFile:(NSString *)filename isPrint:(BOOL)bPrint
{
    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    path = CFStringCreateWithCString (NULL, [filename UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    CGRect pageRect = CGRectMake(0, 0, 612, 792);
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
    CFRelease(myDictionary);
    CFRelease(url);
    pageDictionary = CFDictionaryCreateMutable(NULL, 0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    nTotalPages = [pageList count];
    for(NSInteger i=0; i<nTotalPages; i++)
    {
        @autoreleasepool
        {
            UIImage *image = [self setImageAtPage:i];
            image = [self MergeAnnotationsWithImage:image onPage:i];
            CGSize size = image.size;
            if( bPrint && size.width > size.height )
            {
                image = [self DoRotateImage:image];
                size = image.size;
            }
            
            //scale the image to fit A4 paper size
            CGFloat rx = size.width / 1728.0;
            CGFloat ry = size.height / 2200.0;
            CGFloat rr = rx > ry ? rx : ry;
            CGSize sz = CGSizeMake(size.width/rr, size.height/rr);
            pageRect = CGRectMake(0, 0, sz.width*72.0/200.0, sz.height*72.0/200.0);
            
            CFDataRef boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
            CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
            CGPDFContextBeginPage (pdfContext, pageDictionary);
            CGContextDrawImage (pdfContext, pageRect,[image CGImage]);
            CGPDFContextEndPage (pdfContext);
            CFRelease(boxData);
        }
    }
    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    
    return true;
}

- (void)openIn
{
    static NSString *openInFile = @"";
    
    if( ![openInFile isEqualToString:@""] )
    {
        [[NSFileManager defaultManager] removeItemAtPath:openInFile error:nil];
    }
    
    openInFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", [self GetTimeStringFrom:[NSDate date] forFileName:YES]]];
    if( [self MyCreatePDFFile:openInFile isPrint:NO] )
    {
        UIDocumentInteractionController *openInController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:openInFile]];
        openInController.delegate = self;
        [openInController presentOpenInMenuFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
    }
}

MenuViewController *menuVC = nil;
- (IBAction)OnMenu:(id)sender
{
    menuVC = [[MenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
    int dy = nDeviceType == DEVICE_IPHONE ? 525 : 610;
    menuVC.preferredContentSize = CGSizeMake(320, dy);
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onMenuCancel)];
    UINavigationController *naviController = [[UINavigationController alloc] init];
    naviController.viewControllers = [NSArray arrayWithObject:menuVC];
    naviController.navigationBar.topItem.title = @"Menu";
    naviController.navigationBar.topItem.rightBarButtonItem = nDeviceType == DEVICE_IPHONE ? cancel : nil;
    naviController.modalPresentationStyle = UIModalPresentationPopover;
    naviController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    naviController.popoverPresentationController.sourceView = self.view;
    naviController.popoverPresentationController.sourceRect = CGRectMake(20, 20, 50, 30);
    [self presentViewController:naviController animated:YES completion:nil];
}

- (void)onMenuCancel
{
    [menuVC dismissViewControllerAnimated:YES completion:nil];
    menuVC = nil;
}

- (void)removeFilesfromArray:(NSMutableArray *)array
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSInteger num = [array count];
    for(NSInteger i = 0; i < num; i++)
    {
        NSString *file = [array objectAtIndex:i];
        if( ![file isEqualToString:@""] )
        {
            [fileManager removeItemAtPath:file error:nil];
        }
    }
}

- (void)removeTempFilesInFolder:(NSString *)folder
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    for(int i=0; i<1000; i++)
    {
        NSString *file = [NSString stringWithFormat:@"%@/ImagePage-%d.tmp", folder, i];
        if( [mgr fileExistsAtPath:file] )
            [mgr removeItemAtPath:file error:nil];
        else
            break;
    }
}

- (void)writeLog:(NSString *)msg
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:@"MobileLog.txt"];
    
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:logFilePath];
    NSData *fileData = [fh readDataToEndOfFile];
    
    NSString *sdata = @"";
    if( fileData != nil )
    {
        sdata = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        if( [sdata length] > 100*1024 )
        {
            for(NSInteger i=80*1024; i>=0; i--)
            {
                unichar chr = [sdata characterAtIndex:i];
                if( (NSInteger)chr == '\n' )
                {
                    sdata = [sdata substringToIndex:i];
                    break;
                }
            }
        }
    }

    NSString *str = [NSString stringWithFormat:@"%@ - %@\n", [self GetTimeStringFrom:[NSDate date] forFileName:NO], msg];
    str = [str stringByAppendingString:sdata];
    [str writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)GetTimeStringFrom:(NSDate *)dt forFileName:(BOOL)bFileName
{
    NSTimeZone* gmTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* localTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [gmTimeZone secondsFromGMTForDate:dt];
    NSInteger destinationGMTOffset = [localTimeZone secondsFromGMTForDate:dt];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:dt];
    
    NSString *txt = [destinationDate description];
    NSArray *arr = [txt componentsSeparatedByString:@" "];
    NSString *date = [arr objectAtIndex:0];
    NSString *time = [arr objectAtIndex:1];
    
    arr = [date componentsSeparatedByString:@"-"];
    if( bFileName )
        date = [NSString stringWithFormat:@"%@-%@-%@", [arr objectAtIndex:1], [arr objectAtIndex:2], [arr objectAtIndex:0]];
    else
        date = [NSString stringWithFormat:@"%@/%@/%@", [arr objectAtIndex:1], [arr objectAtIndex:2], [arr objectAtIndex:0]];
    
    return [NSString stringWithFormat:@"%@ %@", date, time];
}

- (void)switchToNextPage
{
    
}

- (void)switchToView:(UIViewController *)view
{
    int index = 0;
    if( view == viewerPage ) index = 0;
    if( view == inboxPage ) index = 1;
    if( view == settingsPage ) index = 2;
    if( view == statusPage ) index = 3;
    if( view == sendPage ) index = 4;
    [self.navigationController.tabBarController setSelectedIndex:index];
}

- (UIImage *)setImageAtPage:(NSInteger)page
{
    if( page >= [pageList count] )
        return nil;
    NSDictionary *dic = [pageList objectAtIndex:page];
    return [UIImage imageWithContentsOfFile:[dic valueForKey:PAGE_IMAGEFILE]];
}

- (UIImage *)MergeAnnotationsWithImage:(UIImage *)img onPage:(NSInteger)page
{
    NSMutableArray *arr = [[pageList objectAtIndex:page] valueForKey:PAGE_ANNOTATION];
    NSInteger num = [arr count];
    if( num == 0 )
        return img;
    
    CGSize size = img.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [img drawAtPoint:CGPointZero];
    
    contentVC.annotationView.bShow = false;
    for(NSInteger i = 0; i < num; i++)
    {
        NSMutableDictionary *annotation = [arr objectAtIndex:i];
        [contentVC.annotationView drawAnnotation:annotation atContext:ctx mode:M_MERGE];
    }
    contentVC.annotationView.bShow = true;
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)getRotatedImage:(UIImage *)image
{
    switch (image.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            image = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:UIImageOrientationUp]; // change this if you need another orientation
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            // The image is already in correct orientation
            break;
    }
    
    return image;
}

- (NSString *)getAttachmentFileName
{
    static int nAttachment = 0;
    if( nAttachment > 200 ) nAttachment = 0;
    return [NSString stringWithFormat:@"%@-%ld.jpg", IMAGE_ATTACHMENT, (long)nAttachment++];
}

- (void)savePage:(NSInteger)page
{
    int num = (int)[ImgCollection count];
    if( num >= MAX_ATTACHMENT_COUNT )
        return;
    
    @autoreleasepool
    {
        UIImage *image = [self setImageAtPage:page];
        image = [self MergeAnnotationsWithImage:image onPage:page];
        NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:[self getAttachmentFileName]];
        NSError *err;
        NSData *imageData = UIImageJPEGRepresentation(image,1.0);
        if( [imageData writeToFile:file options:NSDataWritingFileProtectionNone error:&err] )
        {
            [sendPage attachFile:file];
        }
        else
        {
            [self ShowAlertTitle:@"Error" message:[err localizedDescription]];
        }
    }
}

NSInteger attachMode = 0;
- (void)forSavingPages:(NSInteger)mode
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attaching"
                                                                   message:@"\nPlease wait for the pages to be attached to a fax."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    attachMode = mode;
    [self performSelector:@selector(toAttachPages:) withObject:alert afterDelay:1.0];
}

- (void)toAttachPages:(UIAlertController *)alert
{
    if( attachMode == 0 )
    {
        [self savePage:nCurrentPageIndex];
    }
    else
    {
        for(NSInteger i=0; i<nTotalPages; i++)
        {
            [self savePage:i];
        }
    }
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(postAttach) withObject:nil afterDelay:0.5];
}

- (void)postAttach
{
    [self switchToView:sendPage];
    [sendPage setAttachmentImages];
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self performSelector:@selector(postPickPicture:) withObject:image afterDelay:0];
}

BOOL bCameraMode = NO;
- (void)onPhotoLibrary
{
    bCameraMode = NO;
    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)onTakePicture
{
    if( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
    {
        [self ShowAlertTitle:@"No camera found" message:@""];
        return;
    }
    bCameraMode = YES;
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}

- (void)postPickPicture:(UIImage *)picture
{
    static int index = 0;
    CGSize size = picture.size;
    double max = 2100.0;
    if( size.width > max || size.height > max )
    {
        if( size.width > size.height )
        {
            double r = max / size.width;
            size.width = max;
            size.height *= r;
        }
        else
        {
            double r = max / size.height;
            size.height = max;
            size.width *= r;
        }
        picture = [self doResizeImage:picture imageSize:size];
    }
    
    NSString *str= [NSString stringWithFormat:@"pickImage-%d.jpg", index++];
    if( index > 40 ) index = 0;
    NSString *fname = [NSTemporaryDirectory() stringByAppendingPathComponent:str];
    [UIImageJPEGRepresentation(picture, 1.0) writeToFile:fname atomically:NO];
    if( bBackToSendPage )
    {
        [sendPage attachFile:fname];
        [sendPage setAttachmentImages];
        bBackToSendPage = false;
    }
    else
    {
        [self setPageInfoForFile:fname];
        [[NSFileManager defaultManager] removeItemAtPath:fname error:nil];
    }
    
    if( bCameraMode )
    {
        UIImageWriteToSavedPhotosAlbum(picture, nil, nil, nil);
    }
}

- (UIImage *)doResizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect: CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)onICloudDrive
{
    NSArray *arr = @[(NSString *)kUTTypePDF,
                     (NSString *)kUTTypeGIF,
                     (NSString *)kUTTypeJPEG,
                     (NSString *)kUTTypePNG,
                     (NSString *)kUTTypeTIFF,
                     (NSString *)kUTTypeBMP];
    NSMutableArray *marr = [[NSMutableArray alloc] init];
    [marr addObjectsFromArray:arr];
    if( bBackToSendPage )
    {
        NSArray *a2 = @[@"com.microsoft.word.doc",
                        @"org.openxmlformats.wordprocessingml.document",
                        @"com.microsoft.excel.xls",
                        @"org.openxmlformats.spreadsheetml.sheet",
                        @"com.microsoft.powerpoint.ppt",
                        @"org.openxmlformats.presentationml.presentation",
                        @"public.rtf",
                        @"public.text"
                        ];
        [marr addObjectsFromArray:a2];
    }
    UIDocumentPickerViewController *iCloudController = [[UIDocumentPickerViewController alloc]
                                                        initWithDocumentTypes:marr
                                                        inMode:UIDocumentPickerModeImport];
    if( iCloudController != nil )
    {
        iCloudController.delegate = self;
        [self presentViewController:iCloudController animated:YES completion:nil];
    }
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    NSString *str = [url absoluteString];
    NSArray *arr = [str componentsSeparatedByString:@"/"];
    NSString *theFilePath = [self getFilePathWithFilename:[arr lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:theFilePath error:nil];
    [[NSFileManager defaultManager] copyItemAtURL:url
                                            toURL:[NSURL fileURLWithPath:theFilePath]
                                            error:nil];
    
    if( bBackToSendPage )
    {
        bBackToSendPage = NO;
        [self performSelector:@selector(loadAttachFile:) withObject:theFilePath afterDelay:0];
    }
    else
    {
        [viewerPage performSelector:@selector(setPageInfoForFile:) withObject:theFilePath afterDelay:0];
    }
}

- (void)loadAttachFile:(NSString *)tempFile
{
    NSArray *arr = [tempFile componentsSeparatedByString:@"."];
    NSString *ext = [[arr lastObject] lowercaseString];
    if ([ext isEqualToString:@"doc"] || [ext isEqualToString:@"docx"] ||
        [ext isEqualToString:@"xls"] || [ext isEqualToString:@"xlsx"] ||
        [ext isEqualToString:@"ppt"] || [ext isEqualToString:@"pptx"] ||
        [ext isEqualToString:@"pdf"] || [ext isEqualToString:@"rtf"] || [ext isEqualToString:@"txt"] )
    {
        [sendPage attachFile:tempFile];
        [sendPage setAttachmentImages];
        return;
    }
    
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:tempFile];
    if( fh == nil )
    {
        [self ShowAlertTitle:@"Error" message:@"Cannot find this document."];
        bBackToSendPage = false;
        return;
    }
    
    NSData *fileData = [fh readDataToEndOfFile];
    [fh closeFile];
    int nPages = 0;
    NSTiffSplitter *splitter = nil;
    CGPDFDocumentRef fromPDFDoc = nil;
    NSString *type = @"";
    char buf[5];
    [fileData getBytes:buf length:4];
    if( strncmp(buf, "II", 2)==0 || strncmp(buf, "MM", 2)==0 )
    {
        splitter = [[NSTiffSplitter alloc] initWithPathToImage:tempFile];
        nPages = splitter.countOfImages;
        type = @"TIF";
    }
    else if( strncmp(buf, "%PDF", 4)==0 )
    {
        CFStringRef path = CFStringCreateWithCString (NULL, [tempFile UTF8String], kCFStringEncodingUTF8);
        CFURLRef url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
        fromPDFDoc = CGPDFDocumentCreateWithURL((CFURLRef)url);
        CFRelease (path);
        CFRelease (url);
        nPages = (int)CGPDFDocumentGetNumberOfPages(fromPDFDoc);
        type = @"PDF";
    }
    else if( [ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"] ||
             [ext isEqualToString:@"png"] || [ext isEqualToString:@"bmp"] || [ext isEqualToString:@"gif"] )
    {
        nPages = 1;
        type = @"IMG";
    }
    else
    {
        [self ShowAlertTitle:@"Error" message:@"Cannot open this type of files."];
        return;
    }

    for(int i=0; i<nPages; i++)
    {
        @autoreleasepool
        {
            NSData *data = nil;
            if( [type isEqualToString:@"TIF"] )
            {
                data = [splitter dataForImage:i];
            }
            else if( [type isEqualToString:@"PDF"] )
            {
                UIImage *image = [self getImageFromPdf:fromPDFDoc forPage:i];
                data = UIImageJPEGRepresentation(image, 1.0);
            }
            else
            {
                data = [[NSData alloc] initWithContentsOfFile:tempFile];
            }
            
            if( data != nil )
            {
                NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:[self getAttachmentFileName]];
                NSError *err;
                if( [data writeToFile:file options:NSDataWritingFileProtectionNone error:&err] )
                {
                    [sendPage attachFile:file];
                }
            }
        }
    }
    
    [sendPage setAttachmentImages];
}

- (NSString *)getFilePathWithFilename:(NSString *)fname
{
    static int num = 0;
    
    NSArray *array = [fname componentsSeparatedByString:@"."];
    NSString *ext = [array lastObject];
    ext = [ext lowercaseString];
    
    NSMutableArray *extArray = [[NSMutableArray alloc] init];
    [extArray addObject:@"pdf"];
    [extArray addObject:@"doc"];
    [extArray addObject:@"ppt"];
    [extArray addObject:@"xls"];
    [extArray addObject:@"docx"];
    [extArray addObject:@"pptx"];
    [extArray addObject:@"xlsx"];
    [extArray addObject:@"txt"];
    [extArray addObject:@"xml"];
    [extArray addObject:@"rtf"];
    [extArray addObject:@"htm"];
    [extArray addObject:@"html"];
    [extArray addObject:@"bmp"];
    [extArray addObject:@"gif"];
    [extArray addObject:@"jpg"];
    [extArray addObject:@"png"];
    [extArray addObject:@"tif"];
    [extArray addObject:@"jpeg"];
    [extArray addObject:@"tiff"];
    
    ext = [ext lowercaseString];
    NSInteger cnt = [extArray count];
    bool bOk = false;
    for(NSInteger i=0; i<cnt; i++)
    {
        if( [ext isEqualToString:[extArray objectAtIndex:i]] )
        {
            bOk = true;
            break;
        }
    }
    if( !bOk )
    {
        [self ShowAlertTitle:@"Not support" message:[NSString stringWithFormat:@"Cannot support files with extension %@", ext]];
        return @"";
    }
    
    NSString *theFileName = [NSString stringWithFormat:@"%@-%d-$%@", FILE_ATTACHMENT, num++, fname];
    if( num >= 5 ) num = 0;
    NSString *theFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:theFileName];
    [[NSFileManager defaultManager] removeItemAtPath:theFilePath error:nil];
    return theFilePath;
}

- (void)convertBWImage
{
    NSDictionary *dic = [pageList objectAtIndex:nCurrentPageIndex];
    NSString *fname = [dic valueForKey:PAGE_IMAGEFILE];
    UIImage *image = [UIImage imageWithContentsOfFile:fname];

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
        return;
    }
    
    NSInteger bytesPerRow = CGBitmapContextGetBytesPerRow( context );
    NSInteger height = CGBitmapContextGetHeight( context );
    NSInteger len = bytesPerRow * height;
    unsigned char *outbytes = malloc(len);
    memset(outbytes, 255, len);
    dynthresh(data, outbytes, (int)bytesPerRow, (int)height, PHOTOMETRIC_MINISBLACK, 0, -5, 4, 4, '*');
    memcpy(data, outbytes, len);
    free(outbytes);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);

    [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:fname atomically:YES];
    [self goToPage:nCurrentPageIndex];
    [self showSpinner:NO];
}

- (void)onRotate
{
    if( nCurrentPageIndex < 0 || nCurrentPageIndex >= [pageList count] )
        return;
    
    NSDictionary *dic = [pageList objectAtIndex:nCurrentPageIndex];
    NSString *fname = [dic valueForKey:PAGE_IMAGEFILE];
    UIImage *img = [UIImage imageWithContentsOfFile:fname];
    UIImage *image = [self DoRotateImage:img];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:fname atomically:YES];
    [self goToPage:nCurrentPageIndex];
}

- (UIImage *)DoRotateImage:(UIImage *)img
{
    CGSize size = img.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // rotate it left
    CGContextTranslateCTM(ctx, 0, size.width);
    CGContextRotateCTM(ctx,  -M_PI_2);
    [img drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)onDeleteCurrentPage
{
    [pageList removeObjectAtIndex:nCurrentPageIndex];
    if( nCurrentPageIndex == [pageList count] )
        nCurrentPageIndex -= 1;
    [self goToPage:nCurrentPageIndex];
}

- (void)onDeleteAllPages
{
    [self cleanScreen];
}

- (void)setAnnotationTools
{
    ColorsOfLine = [[NSMutableArray alloc] init];
    [ColorsOfLine addObject:[UIColor redColor]];
    [ColorsOfLine addObject:[UIColor greenColor]];
    [ColorsOfLine addObject:[UIColor blueColor]];
    [ColorsOfLine addObject:[UIColor yellowColor]];
    [ColorsOfLine addObject:[UIColor blackColor]];
    nAnnoColorIndex = 0;
    nAnnoLineIndex = 1;
    nAnnoFontSizeIndex = 2;
    
    NSString *imageFilename[6] = {@"Sign.png",@"Highlight.png",@"Text.png",@"Arrow.png",@"Scale.png",@"Settings.png"};
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(NSInteger i=0; i<6; i++)
    {
        UIImage* img = [UIImage imageNamed:imageFilename[i]];
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [arr addObject:goodImg];
    }
    typeSegments = [[UISegmentedControl alloc] initWithItems:arr];
    CGSize size = self.navigationController.toolbar.frame.size;
    int y = size.height > 40 ? 5 : 2;
    typeSegments.frame = CGRectMake(10, y, size.width-20, size.height-2*y);
    typeSegments.tintColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.15 alpha:1.0];
    typeSegments.userInteractionEnabled = YES;
    typeSegments.selectedSegmentIndex = -1;
    [typeSegments addTarget:self action:@selector(switchAnnotationType) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.toolbar addSubview:typeSegments];

    NSInteger wid = 300;
    if( nDeviceType == DEVICE_IPHONE )
    {
        CGSize se = [[UIScreen mainScreen] bounds].size;
        wid = se.width - 20;
    }
    int wd = 25;
    int ht = 20;
    
    colorAnnoSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 8, wid, 28)];
    for(NSInteger i=0; i<5; i++)
    {
        UIGraphicsBeginImageContext(CGSizeMake(wd, ht));
        CGFloat r, g, b, a;
        [[self getColorWithIndex:i] getRed:&r green:&g blue:&b alpha:&a];
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), r, g, b, 1);
        CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake (0, 0, wd, ht));
        UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [colorAnnoSegments insertSegmentWithImage:goodImg atIndex:i animated:NO];
        UIGraphicsEndImageContext();
    }
    colorAnnoSegments.selectedSegmentIndex = nAnnoColorIndex;
    
    lineAnnoSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 8, wid, 28)];
    for(NSInteger i=0; i<5; i++)
    {
        UIGraphicsBeginImageContext(CGSizeMake(wd, ht));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextBeginPath(ctx);
        [[UIColor blackColor] set];
        CGContextSetLineWidth(ctx, [self getLineWidthWithIndex:i]);
        CGContextMoveToPoint(ctx, 2, ht-2);
        CGContextAddLineToPoint(ctx, wd-2, 2);
        CGContextStrokePath(ctx);
        UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [lineAnnoSegments insertSegmentWithImage:goodImg atIndex:i animated:NO];
        UIGraphicsEndImageContext();
    }
    lineAnnoSegments.selectedSegmentIndex = nAnnoLineIndex;
    
    fontSizeAnnoSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 8, wid, 28)];
    for(NSInteger i=0; i<5; i++)
    {
        UIGraphicsBeginImageContext(CGSizeMake(wd, ht));
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:[self getFontSizeWithIndex:i]],
                                      NSForegroundColorAttributeName: [UIColor blackColor],
                                      NSParagraphStyleAttributeName: style
                                      };
        CGRect rect = CGRectMake(0, -i, wd, ht);
        [@"a" drawInRect:rect withAttributes:attributes];
        UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [fontSizeAnnoSegments insertSegmentWithImage:goodImg atIndex:i animated:NO];
        UIGraphicsEndImageContext();
    }
    fontSizeAnnoSegments.selectedSegmentIndex = nAnnoFontSizeIndex;
}

- (void)switchAnnotationType
{
    if( typeSegments.selectedSegmentIndex == ANNOTATION_SETTINGS )
    {
        [self onSettings];
        return;
    }
    
    if( [viewerPage.pageList count] == 0 )
    {
        [viewerPage ShowAlertTitle:@"No page" message:@"There is not a page that the annotation function can work on."];
        [self cleanTypeSelection];
        return;
    }
    
    NSInteger nSelected = typeSegments.selectedSegmentIndex;
    [contentVC checkStates];
    nAnnotationType = nSelected;
    typeSegments.selectedSegmentIndex = nSelected;
    
    if( nAnnotationType == ANNOTATION_SIGN )
    {
        [contentVC onSign];
    }
    if( nAnnotationType == ANNOTATION_TEXT )
    {
        [contentVC onText];
    }
    [contentVC didChangeAnnotationType:self];
}

SettingsViewController *settingsVC = nil;
- (void)onSettings
{
    settingsVC = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingsVC.preferredContentSize = CGSizeMake(320, 340);
    UIBarButtonItem *ok = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsOK)];
    UINavigationController *naviController = [[UINavigationController alloc] init];
    naviController.viewControllers = [NSArray arrayWithObject:settingsVC];
    naviController.navigationBar.topItem.title = @"Settings";
    naviController.navigationBar.topItem.rightBarButtonItem = ok;
    naviController.delegate = self;
    naviController.modalPresentationStyle = UIModalPresentationPopover;
    naviController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    naviController.popoverPresentationController.sourceView = typeSegments;
    CGRect rt = typeSegments.frame;
    rt.origin.x = self.view.frame.size.width - 100;
    rt.size.width = 100;
    naviController.popoverPresentationController.sourceRect = rt;
    [self presentViewController:naviController animated:YES completion:nil];
    
    lineAnnoSegments.selectedSegmentIndex = nAnnoLineIndex;
    colorAnnoSegments.selectedSegmentIndex = nAnnoColorIndex;
    fontSizeAnnoSegments.selectedSegmentIndex = nAnnoFontSizeIndex;
    [self cleanTypeSelection];
}

- (void)onSettingsOK
{
    [settingsVC dismissViewControllerAnimated:YES completion:nil];
    settingsVC = nil;
    nAnnoLineIndex = (int)lineAnnoSegments.selectedSegmentIndex;
    nAnnoColorIndex = (int)colorAnnoSegments.selectedSegmentIndex;
    nAnnoFontSizeIndex = (int)fontSizeAnnoSegments.selectedSegmentIndex;
}

- (void)cleanTypeSelection
{
    typeSegments.selectedSegmentIndex = -1;
    nAnnotationType = -1;
}

- (NSInteger)getFontSizeWithIndex:(NSInteger)index
{
    return 12+2*index;
}

- (NSInteger)getLineWidthWithIndex:(NSInteger)index
{
    return 1+index;
}

- (UIColor *)getColorWithIndex:(NSInteger)index
{
    return [ColorsOfLine objectAtIndex:index];
}

- (void)displaySharedImages:(NSNumber *)number
{
    NSURL* containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.bdfax.extension"];
    NSString* documentPath = containerURL.path;
    int pages = [number intValue];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=0; i<pages; i++)
    {
        NSString* fileName = [NSString stringWithFormat:@"imageShared%d.jpg", i];
        NSString* filePath = [documentPath stringByAppendingPathComponent:fileName];
        UIImage* image = [UIImage imageWithContentsOfFile:filePath];
        if( image )
        {
            CGSize size = image.size;
            double max = 2200.0;
            UIImage *newImage = image;
            if( size.width > max || size.height > max )
            {
                if( size.width > size.height )
                {
                    double r = max / size.width;
                    size.width = max;
                    size.height *= r;
                }
                else
                {
                    double r = max / size.height;
                    size.height = max;
                    size.width *= r;
                }
                UIGraphicsBeginImageContext(size);
                [image drawInRect: CGRectMake(0, 0, size.width, size.height)];
                newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            image = [sendPage convertion:newImage setAnnotation:NO];
            [array addObject:image];
        }
    }
    NSString *filename = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mytiff.tif"];
    [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
    if( [sendPage saveTifFileWithMultiPages:array images:YES filename:filename] )
    {
        [self setPageInfoForFile:filename];
    }
    [array removeAllObjects];
    [self showSpinner:NO];
}

- (void)LaunchSendDlgWithURL:(NSURL *)url
{
    NSString * APP_SHARE_URL_SCHEME = @"redmaple-shareurlscheme";
    NSArray *array = [[url absoluteString] componentsSeparatedByString:@"."];
    if( [array count] == 0 || [[array objectAtIndex:0] isEqualToString:@"accom"] )
        return;
    
    [self cleanScreen];
    [self showSpinner:YES];
    NSString *urlString = [url absoluteString];
    if( [urlString containsString:APP_SHARE_URL_SCHEME] )
    {
        NSArray *arr1 = [urlString componentsSeparatedByString:@"."];
        NSArray *arr2 = [[arr1 firstObject] componentsSeparatedByString:@"files"];
        int count = [[arr2 lastObject] intValue];
        NSLog( @"Image number: %d", count );
        NSNumber *number = [NSNumber numberWithInt:count];
        [self performSelector:@selector(displaySharedImages:) withObject:number afterDelay:0.1];
        return;
    }
    
    NSArray *arr = [urlString componentsSeparatedByString:@"/"];
    NSString *fname = [arr lastObject];
    NSString *theFilePath = [self getFilePathWithFilename:fname];
    
    NSError *error = nil;
    [[NSFileManager defaultManager] copyItemAtURL:url
                                            toURL:[NSURL fileURLWithPath:theFilePath]
                                            error:&error];
    if( error )
    {
        [self ShowAlertTitle:@"Error" message:[error localizedDescription]];
    }
    else
    {
        NSString *ext = [array objectAtIndex:[array count]-1];
        ext = [ext lowercaseString];
        if ([ext isEqualToString:@"tif"] || [ext isEqualToString:@"jpg"] ||
            [ext isEqualToString:@"tiff"] || [ext isEqualToString:@"jpeg"] ||
            [ext isEqualToString:@"png"] || [ext isEqualToString:@"bmp"] ||
            [ext isEqualToString:@"pdf"] )
        {
            [self setPageInfoForFile:theFilePath];
        }
        else if ([ext isEqualToString:@"doc"] || [ext isEqualToString:@"docx"] ||
                 [ext isEqualToString:@"xls"] || [ext isEqualToString:@"xlsx"] ||
                 [ext isEqualToString:@"ppt"] || [ext isEqualToString:@"pptx"] )
        {
            [sendPage attachFile:theFilePath];
            [sendPage setAttachmentImages];
            [self switchToView:sendPage];
        }
        else
        {
            [self ShowAlertTitle:@"Error" message:@"Cannot open this type of files."];
        }
    }
    [self showSpinner:NO];
}

@end
