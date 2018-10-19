//
//  Wsmanager.h
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#ifndef Wsmanager_h
#define Wsmanager_h

#import "WebServices.h"
#import "WebserviceSft.h"
#import "WebservicesAnywhere.h"


////////////////////
@interface WSManager : NSObject
{
    WebServicesMobile *wsMobile;
    WebServicesSft *wsSft;
    WebServicesAnywhere *wsAnywhere;
}
@property (strong, nonatomic) WebServicesSft *wsSft;

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
- (NSArray *)getContacts;
- (void)addContact:(NSDictionary *)dic;
- (void)deleteContacts:(NSArray *)contacts;

@end


#endif /* Wsmanager_h */

