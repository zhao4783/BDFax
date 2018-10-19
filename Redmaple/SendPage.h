//
//  SendPage.h
//  MobileFax
//
//  Created by Zhao                                                     on 5/30/13.
//  Copyright (c) 2013 Zhao                                                    . All rights reserved.
//

#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MyTextField : UITextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender;

@end


@interface SendPage : UITableViewController <UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UISearchBarDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>
{
    UITableView *matchedContactsTable;
    MyTextField *recipient;
    UITextField *subject;
    UITextView *memo;
    UIScrollView *scrollView;
    UIImageView *imageView;
    
    NSMutableArray *deviceContacts;
    NSMutableArray *recipients;
    NSMutableArray *attachmentArray;
    UIButton *addButton;

    NSInteger  nCmd;
    NSInteger  nDeleteOne;
    NSInteger  nSelectedPage;
    UIWebView *webView;
    UILongPressGestureRecognizer *longPress;
    NSMutableArray *AttachImageArray;
    UILabel *labelAttachments;
    UITableViewController* contactsMenuController;
    
    UISegmentedControl *attachmentSegments;
    UIActivityIndicatorView *spinner;
    BOOL bSendSftfax;
}
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSMutableArray *attachmentArray;
@property (strong, nonatomic) UITextField *recipient;
@property (nonatomic) BOOL bSendSftfax;

- (IBAction)OnSend:(id)sender;
- (IBAction)OnReset:(id)sender;

- (void)setAttachmentImages;
- (void)selectAttachment:(CGPoint)point;
- (void)moveAttachment:(CGSize)sz;
- (void)endMoveAttachment;
- (void)cleanSendFaxPage;
- (void)sortContacts;
- (void)addCoverpageForAttachment;
- (NSInteger)getWindowWidth;
- (NSString *)getCoverpageImageFor:(NSDictionary *)info index:(int)index;
- (UIImage *)doConvert2BW:(UIImage *)image sensitivity:(int)sens;
- (void)showSpinner;
- (void)hideSpinner;
- (void)setContacts;
- (void)setDropboxWindow:(DBFILESMetadata *)data;
- (void)downloadProc:(NSString *)imagePath;
- (bool)saveTifFileWithMultiPages:(NSArray *)attachments images:(BOOL)bImages filename:(NSString *)filename;
- (void)attachFile:(NSString *)file;
- (UIImage *)convertion:(UIImage *)img setAnnotation:(BOOL)bSetAnnotation;
- (void)resetContactList:(NSNumber *)val;
- (BOOL)isFaxNumber:(NSString *)address;
- (BOOL)isEmailAddres:(NSString *)address;

@end

/////////////////////
@interface dropboxController : UITableViewController
{
    NSArray<DBFILESMetadata *> *folderEntries;
}
@property (strong, nonatomic) NSArray<DBFILESMetadata *> *folderEntries;
@end


