//
//  PageViewController.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/9/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAXCOM_x0020_Service.h"
#import "WebServices.h"
#import "WebserviceSft.h"
#import "WebservicesAnywhere.h"
#import "Wsmanager.h"
#import "InboxController.h"
#import "SettingPage.h"
#import "ContentViewController.h"
#import "SendPage.h"
#import "StatusPage.h"
#import "NSTiffSplitter.h"

#define MAX_ATTACHMENT_COUNT    100

#define DEVICE_IPHONE   1
#define DEVICE_IPAD     2
#define APP_VERSION     @"5.3.1.7"

#define SERVER_SFTFAX           @"sftfax.biscom.com"
#define SERVER_FAXCOMANYWHERE   @"webfax.faxcomanywhere.com"
#define SERVER_MOBILEFAX        @"biscommobile.biscom.com"

#define WEB_SERVICE_MOBILE      1
#define WEB_SERVICE_ANYWHER     2
#define WEB_SERVICE_SFT         3

#define KEY_NAME        @"name"
#define KEY_ADDRESS     @"address"
#define KEY_COMPANY     @"company"
#define KEY_PHONE       @"phone"
#define KEY_CONTACTID   @"contactId"

#define IMAGE_ATTACHMENT @"ImgCollection"
#define FILE_ATTACHMENT  @"FileCollection"
#define FAX_ATTACHMENT   @"FaxDocument"

#define FAX_FORMAT      @"PDF"
#define PAGE_IMAGEFILE  @"ImageFile"
#define PAGE_ANNOTATION @"Annotation"

#define FILE_TIF    1
#define FILE_PDF    2

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate, UIDocumentPickerDelegate, UIActionSheetDelegate>
{
    NSMutableArray *pageList;
    NSString *strLogoFile;
    NSInteger nCurrentPageIndex;
    UIPageControl *pageControl;
}
@property (strong, nonatomic) NSMutableArray *pageList;

- (IBAction)OnMenu:(id)sender;
- (IBAction)OnAction:(id)sender;

- (void)onMenuCancel;
- (void)removeFilesfromArray:(NSArray *)arrAtach;
- (void)ShowAlertTitle:(NSString *)title message:(NSString *)msg;
- (void)writeLog:(NSString *)txt;
- (void)switchToNextPage;
- (void)switchToView:(UIViewController *)view;
- (UIImage *)setImageAtPage:(NSInteger)page;
- (UIImage *)MergeAnnotationsWithImage:(UIImage *)image onPage:(NSInteger)page;
- (NSString *)GetTimeStringFrom:(NSDate *)dt forFileName:(BOOL)bFileName;
- (void)displayLogoImage;
- (void)setPageInfoForFile:(NSString *)filename;
- (void)showSpinner:(BOOL)bShow;
- (void)goToPage:(NSInteger)page;
- (void)onPhotoLibrary;
- (void)onTakePicture;
- (void)onICloudDrive;
- (void)convertBWImage;
- (void)cleanScreen;
- (void)onRotate;
- (void)onDeleteCurrentPage;
- (void)onDeleteAllPages;
- (void)cleanTypeSelection;
- (NSInteger)getFontSizeWithIndex:(NSInteger)index;
- (NSInteger)getLineWidthWithIndex:(NSInteger)index;
- (UIColor *)getColorWithIndex:(NSInteger)index;
- (void)forSavingPages:(NSInteger)mode;
- (void)loadAttachFile:(NSString *)tempFile;
- (NSString *)getFilePathWithFilename:(NSString *)fname;
- (void)LaunchSendDlgWithURL:(NSURL *)url;
- (void)onSettings;
- (CGRect)getScrollViewFrame;
- (void)setAnnotationBar;
- (UIImage *)getImageForPage:(NSInteger)page;
- (void)closeFileData;

@end


extern ContentViewController *contentVC;
extern PageViewController *viewerPage;
extern InboxController *inboxPage;
extern SettingPage *settingsPage;
extern SendPage *sendPage;
extern StatusPage *statusPage;
extern WSManager *wsm;
extern NSString *MAIN_TITLE;
extern NSString *sWebService, *sUsername, *sPassword;
extern NSString *sSenderName, *sSenderAddr, *sSenderComp, *sSenderPhon;
extern NSString *WebServiceVersion;
extern NSString *settingsFilePath;
extern NSString *contactsFilePath;
extern NSString *FaxFolder;
extern CGRect savedScrollViewFrame;
extern int nDeviceType;
extern int nIOSVersion;
extern int nWebService;
extern BOOL bOrientLandscape;
extern UISwitch *coverPageSwitch;
extern NSMutableArray *listOfMeta;
extern NSMutableArray *ImgCollection;
extern NSString *theFaxID;
extern NSInteger nSelectedIndex;
extern NSInteger nTotalPages;
extern NSInteger nNextPage;
extern FAWebServiceMain_MessageStatus *stsAnywhere;
extern FAWebServiceMain_PendingMessage *ptsAnywhere;
extern FAXCOM_x0020_Service_MessageStatus *stsMobile;
extern FAXCOM_x0020_Service_PendingMessage *ptsMobile;
extern NSURL *urlSaved;
extern UISegmentedControl *typeSegments;
extern BOOL bBackToSendPage;
extern BOOL biPhoneX;
extern UIBarButtonItem *savedLeftButton;
extern UIBarButtonItem *savedRightButton;
extern NSString *savedTitle;
extern CGRect landscapeFrame;
extern CGRect portraitFrame;
extern BOOL bShowThumbnail;
extern NSMutableArray *appContacts;


