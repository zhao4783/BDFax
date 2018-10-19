//
//  WebServices.h
//  MobileFax
//
//  Created by Zhao                                                     on 3/20/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAXCOM_x0020_Service.h"

#ifndef WebServices_Mobile_h
#define WebServices_Mobile_h

@interface WebServicesMobile : NSObject
{
    FAXCOM_x0020_ServiceSoapBinding *binding;
    bool bAccessing;
}

- (BOOL)login:(BOOL)inSilent;
- (void)terminateSession;
- (BOOL)setStatusLogs;
- (void)deletePendingLog;
- (void)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)getReceivedIPFaxes;
- (void)updateReceivedIPFaxes;
- (NSString *)receiveIPFaxByFaxID:(NSString *)faxID;
- (NSString *)getWebServiceVersion;
- (void)removeFaxWithIndex:(NSIndexPath *)indexPath;
- (void)setReadFlag;
- (bool)sendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack index:(int)index;
- (BOOL)canAccess;

@end

#endif /* WebServices_Mobile_h */
