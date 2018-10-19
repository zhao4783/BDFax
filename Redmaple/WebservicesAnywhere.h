//
//  Webservices.h
//  MobileFax
//
//  Created by Zhao                                                     on 1/26/16.
//  Copyright © 2016 Zhao                                                    . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FAWebServiceMain.h"

#ifndef WebServicesAnywhere_h
#define WebServicesAnywhere_h

@interface WebServicesAnywhere : NSObject
{
    FAWebServiceMainSoapBinding *binding;
    bool bAccessing;
}

- (BOOL)login:(BOOL)inSilent;
- (void)terminateSession;
- (BOOL)setStatusLogs;
- (BOOL)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath;
- (bool)doSendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack;
- (void)getReceivedIPFaxes;
- (void)updateReceivedIPFaxes;
- (NSString *)receiveIPFaxByFaxID:(NSString *)faxID;
- (BOOL)removeFax:(NSIndexPath *)indexPath;
- (void)setApplicationBadgeNumber:(NSInteger)badgeNumber;
- (BOOL)canAccess;

@end

#endif /* WebServicesAnywhere_h */
