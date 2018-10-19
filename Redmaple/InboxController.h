//
//  InboxController.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/11/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAX_PAGE_COUNT  200

@interface InboxController : UITableViewController <UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>
{
    UICollectionView *thumbnailView;
    UITableView *faxTable;
    UILongPressGestureRecognizer *longPress;
    UIActivityIndicatorView *spinner;
    UIActivityIndicatorView *thumbSpinner;
}
@property (strong, nonatomic) UITableView *faxTable;

- (IBAction)OnRefresh:(id)sender;

- (void)setApplicationBadgeNumber:(NSInteger)badgeNumber;
- (void)updateViewWithUnreadNumber:(NSInteger)num;
- (void)deselectFaxTable;
- (void)clearThumbnailView;
- (void)openDocumentForSft:(NSString *)fileName;
- (void)showSpinner:(BOOL)bShow;
- (bool)setInfo;
- (NSString *)getFileName;
- (void)prepareForThumbnails;
- (void)resetThumbnailView;

@end
